import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';
import 'package:football_booking_fbo_mobile/Blocs/booked_facility_post_bloc/booked_facility_post_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/booked_facility_post_bloc/booked_facility_post_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/deposit_fee_bloc/deposit_fee_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/deposit_fee_bloc/deposit_fee_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/deposit_fee_bloc/deposit_fee_state.dart';
import 'package:football_booking_fbo_mobile/Blocs/zalopay_bloc/zalo_state.dart';
import 'package:football_booking_fbo_mobile/Blocs/zalopay_bloc/zalopay_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/zalopay_bloc/zalopay_event.dart';
import 'package:football_booking_fbo_mobile/Models/opponent_request_model.dart';
import 'package:football_booking_fbo_mobile/constants.dart';


class ZaloPaymentScreen extends StatefulWidget{
  final int facilityId;
  final String startTime;
  OpponentRequestDetailModel myRequest;

  ZaloPaymentScreen({required this.facilityId,required this.startTime,required this.myRequest});

  @override
  State<ZaloPaymentScreen> createState() => _ZaloPaymentScreenState();
}

class _ZaloPaymentScreenState extends State<ZaloPaymentScreen> {

  String _payResult = "";

  @override
  void initState() {
    BlocProvider.of<DepositFeeBloc>(context).add(GetDepositFee(facilityId: widget.facilityId, duration: widget.myRequest.duration/60, fieldTypeId: widget.myRequest.fieldTypeId, startDateTime: widget.startTime));
    super.initState();
  }


  void showSuccessfulPayment(){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Thanh toán thành công',
      desc: "Bạn đã thanh toán đặt cọc thành công và đặt sân thành công",
      buttonsTextStyle: const TextStyle(color: Colors.black),
      showCloseIcon: true,
      btnOkOnPress: () {
        BlocProvider.of<BookedFacilityByPostBloc>(context).add(GetBookedFacilityByPost(postId: widget.myRequest.id));
        Navigator.of(context)..pop()..pop(true);
      },
    ).show();
  }

  void showFailedPayment(){
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

  void showCancelPayment(){
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
                                          showCancelPayment();
                                          _payResult = "User Huỷ Thanh Toán";
                                          break;
                                        case FlutterZaloPayStatus.success:
                                          BlocProvider.of<BookedFacilityByPostBloc>(context).add(BookFacilityByPost(postId: widget.myRequest.id,depositMoney: depositState.depositFeeModel.depositAmount,facilityId: widget.facilityId, fieldTypeId: widget.myRequest.fieldTypeId, duration: widget.myRequest.duration/60, startDateTime: widget.startTime));
                                          showSuccessfulPayment();
                                          _payResult = "Thanh toán thành công";
                                          break;
                                        case FlutterZaloPayStatus.failed:
                                          showFailedPayment();
                                          _payResult = "Thanh toán thất bại";
                                          break;
                                        default:
                                          showFailedPayment();
                                          _payResult = "Thanh toán thất bại";
                                          break;
                                      }
                                    });
                                  });
                                },
                                icon: Image.asset('assets/zalopay.png',width: 30,height: 30 ),
                                label: Text('Thanh toán bằng ZaloPay'), // <-- Text
                              ),

                              Text(_payResult),
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