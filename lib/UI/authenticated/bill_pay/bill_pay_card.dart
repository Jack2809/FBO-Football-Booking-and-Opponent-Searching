import 'package:flutter/material.dart';
import 'package:football_booking_fbo_mobile/Models/bill_pay.dart';
import 'package:football_booking_fbo_mobile/constants.dart';

class BillPayCard extends StatefulWidget{

  BillPay billPay;

  BillPayCard({required this.billPay});


  @override
  State<BillPayCard> createState() => _BillPayCardState();
}

class _BillPayCardState extends State<BillPayCard> {
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Container(
      padding: MyPaddingAll(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: const Offset(
                2.0,
                2.0,
              ),
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: Colors.white,
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ),
          ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.money,color: Colors.green,),
              SizedBox(width: 5.0,),
              Text('Số tiền: ',style: HeadLine1(context),),
              Spacer(),
              Text(toVND(widget.billPay.amount),style: TextLine1(context,false),)

            ],
          ),

          SizedBox(height: size.height * 0.02,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.stadium,color: Colors.green,),
              SizedBox(width: 5.0,),
              Text('Sân bóng: ',style: HeadLine1(context),),
              Spacer(),
              Container(
                width: size.width * 0.4,
                  child: Text(widget.billPay.facilityName,style: TextLine1(context,false),maxLines: 2,)
              )

            ],
          ),
          SizedBox(height: size.height * 0.02,),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.calendar_month,color: Colors.green,),
              SizedBox(width: 5.0,),
              Text('Ngày đá: ',style: HeadLine1(context),),
              Spacer(),
              Expanded(child: Text(dateFormat(widget.billPay.dateReserved),style: TextLine1(context,false),maxLines: 2,))

            ],
          ),



        ],
      ),
    );
  }
}