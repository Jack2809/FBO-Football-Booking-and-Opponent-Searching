import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';
import 'package:football_booking_fbo_mobile/Blocs/book_facility_bloc/book_facility_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/book_facility_bloc/book_facility_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/deposit_fee_bloc/deposit_fee_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/deposit_fee_bloc/deposit_fee_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/deposit_fee_bloc/deposit_fee_state.dart';
import 'package:football_booking_fbo_mobile/Blocs/zalopay_bloc/zalo_state.dart';
import 'package:football_booking_fbo_mobile/Blocs/zalopay_bloc/zalopay_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/zalopay_bloc/zalopay_event.dart';
import 'package:football_booking_fbo_mobile/Models/field_model.dart';
import 'package:football_booking_fbo_mobile/constants.dart';

class ReservationPayment extends StatefulWidget{
  final Field field;
  final int duration;
  final int fieldTypeId;
  final String bookingTime;


  ReservationPayment({required this.field,required this.duration,required this.fieldTypeId,required this.bookingTime});

  @override
  State<ReservationPayment> createState() => _ReservationPaymentState();
}

class _ReservationPaymentState extends State<ReservationPayment> {



  @override
  void initState() {
    BlocProvider.of<DepositFeeBloc>(context).add(GetDepositFee(facilityId: widget.field.id, duration: widget.duration/60, fieldTypeId: widget.fieldTypeId, startDateTime: widget.bookingTime));
    super.initState();
    BlocProvider.of<BookFacilityBloc>(context).listenerStream.listen((event) {
      if(event ==""){

      } else if(event == "Đặt sân thành công"){
        _showSuccessfulPaymentAndSuccessfulReservation();
      }else if(event == "Đặt sân thất bại"){
        _showSuccessfulPaymentAndFailedReservation();
      }else{
        errorDialog(context, event);
      }

    });
  }

  void _showSuccessfulPaymentAndFailedReservation(){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Đặt sân thất bại',
      desc: "Bạn đã đặt sân thất bại",
      buttonsTextStyle: const TextStyle(color: Colors.black),
      showCloseIcon: true,
      btnOkOnPress: () {
        Navigator.of(context)..pop()..pop()..pop();
      },
    ).show();
  }

  void _showSuccessfulPaymentAndSuccessfulReservation(){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Đặt sân thành công',
      desc: "Bạn đã thanh toán đặt cọc thành công và đặt sân thành công",
      buttonsTextStyle: const TextStyle(color: Colors.black),
      showCloseIcon: true,
      btnOkOnPress: () {
        Navigator.of(context)..pop()..pop()..pop();
      },
    ).show();
  }

  void _showFailedPayment(){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Thanh toán thất bại',
      desc: "Bạn đã thanh toán đặt cọc thất bại",
      buttonsTextStyle: const TextStyle(color: Colors.black),
      showCloseIcon: true,
      btnOkOnPress: () {

      },
    ).show();
  }

  void _showCancelPayment(){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Hủy thanh toán',
      desc: "Bạn đã hủy thanh toán",
      buttonsTextStyle: const TextStyle(color: Colors.black),
      showCloseIcon: true,
      btnOkOnPress: () {

      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        bottomOpacity: 0.0,
        shadowColor: Colors.grey.withOpacity(0.02),
        backgroundColor: Colors.green,
        title: Text('Thanh Toán',style: WhiteTitleText()),
        centerTitle: true,
        actions: [

        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<DepositFeeBloc,DepositFeeState>(
            builder:(context,depositState){
              if(depositState is LoadingDepositFee){
                return Center(child: CircularProgressIndicator(),);
              }
              else if(depositState is LoadedDepositFee){
                BlocProvider.of<ZaloPayBloc>(context).add(CreateOrder(totalAmount: depositState.depositFeeModel.depositAmount.toInt()*1000));
                return Center(
                  child: BlocBuilder<ZaloPayBloc,ZaloPayState>(
                      builder:(context,state){
                        if(state is LoadingZaloPay){
                          return Center(child: CircularProgressIndicator(),);
                        }
                        else if (state is LoadedZaloPay){
                          return Column(
                            children: [
                              SizedBox(height: size.height * 0.02,),
                              Text('Tổng Tiền Đặt Cọc',style: TextLine(context),),
                              SizedBox(height: size.height * 0.05,),
                              Text(toVND(depositState.depositFeeModel.depositAmount),style:HeadLine(context),),
                              SizedBox(height: size.height * 0.05,),
                              ElevatedButton.icon(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                                    if(states.contains(MaterialState.pressed)){
                                      return Colors.blue;
                                    }
                                    return Colors.green;
                                  }
                                  ),
                                ),
                                onPressed: () async {
                                  FlutterZaloPaySdk.payOrder(zpToken: state.zaloPayResponse.zpTransToken).listen((event) async{
                                    setState(() {
                                      switch (event) {
                                        case FlutterZaloPayStatus.cancelled:
                                          _showCancelPayment();
                                          break;
                                        case FlutterZaloPayStatus.success:
                                          BlocProvider.of<BookFacilityBloc>(context).add(BookFacility(depositMoney: depositState.depositFeeModel.depositAmount,facilityId: widget.field.id, fieldTypeId: widget.fieldTypeId, duration: widget.duration/60, startDateTime: widget.bookingTime));
                                          break;
                                        case FlutterZaloPayStatus.failed:
                                          _showFailedPayment();
                                          break;
                                        default:
                                          _showFailedPayment();
                                          break;
                                      }
                                    });
                                  });
                                },
                                icon: Image.asset('assets/zalopay.png',width: 30,height: 30 ),
                                label: Text('Thanh toán bằng ZaloPay'), // <-- Text
                              ),

                            ],
                          );
                        }
                        else {
                          return Center(child: Text('Something wrong!!'),);
                        }
                      }
                  ),
                );
              }
              else {
                return Center(child: Text('Something wrong!!'),);
              }
            }
        ),
      ),

    );
  }
}