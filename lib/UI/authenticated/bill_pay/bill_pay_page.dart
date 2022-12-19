import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/billpay_bloc/billpay_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/billpay_bloc/billpay_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/billpay_bloc/billpay_state.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/bill_pay/bill_pay_card.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/bill_pay/bill_pay_detail_page.dart';
import 'package:football_booking_fbo_mobile/constants.dart';


class BillPayPage extends StatefulWidget{

  @override
  State<BillPayPage> createState() => _BillPayPageState();
}

class _BillPayPageState extends State<BillPayPage> {

  @override
  void initState() {
    BlocProvider.of<BillPayBloc>(context).add(FetchBillPay());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        bottomOpacity: 0.0,
        shadowColor: Colors.grey.withOpacity(0.02),
        backgroundColor: Colors.green,
        title: Text('Lịch sử thanh toán',style: WhiteTitleText()),
        // centerTitle: true,
        actions: [

        ],
      ),
      body: Container(
        color: Colors.grey.withOpacity(0.02),
        padding: MyPaddingAll(),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<BillPayBloc>(context).add(FetchBillPay());
            },
            child: BlocBuilder<BillPayBloc,BillPayState>(
                builder:(context,state){
                  if(state is LoadingBillPay){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  else if(state is LoadedBillPay){
                    if(state.billPayList.isEmpty){
                      return Center(child: Text('Không có lịch sử thanh toán nào'),);
                    }else{
                      return ListView.separated(
                          separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10.0),
                          padding: MyPaddingAll(),
                          // shrinkWrap: true,
                          itemCount: state.billPayList.length,
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> BillPayDetailPage(billPay:state.billPayList[index],)));
                              },
                              child: BillPayCard(billPay:state.billPayList[index]),
                            );
                          }
                          ));
                    }
                  }
                  else {
                    return Center(child: Text('Something wrong!!'),);
                  }
                }
            ),
          ),
        ),
      ),

    );
  }
}