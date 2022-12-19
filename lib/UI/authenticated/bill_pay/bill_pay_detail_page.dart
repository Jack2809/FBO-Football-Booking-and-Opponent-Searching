import 'package:flutter/material.dart';
import 'package:football_booking_fbo_mobile/Models/bill_pay.dart';
import 'package:football_booking_fbo_mobile/constants.dart';

class BillPayDetailPage extends StatelessWidget{

  BillPay billPay;

  BillPayDetailPage({required this.billPay});

  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        bottomOpacity: 0.0,
        shadowColor: Colors.grey.withOpacity(0.03),
        backgroundColor: Colors.green,
        title: Text('Chi tiết giao dịch', style: WhiteTitleText()),
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
        child: Container(
          padding: MyPaddingAll10(),
          child: Column(
            children: [
              Text('Tổng tiền đặt cọc',style: TextLine(context),),
              SizedBox(height: size.height * 0.02,),
              Text(toVND(billPay.amount),style: HeadLine(context),),
              SizedBox(height: size.height * 0.02,),
              Divider(
                  color:Colors.grey,
                indent: 10.0,
                endIndent: 10.0,
              ),
              SizedBox(height: size.height * 0.02,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.calendar_month,color: Colors.green,),
                  SizedBox(width: 5.0,),
                  Text('Ngày thanh toán: ',style: HeadLine1(context),),
                  Spacer(),
                  Container(
                    width: size.width * 0.3,
                      child: Text(convertTimeAndHour(billPay.date),style: TextLine1(context,true),maxLines: 2,)
                  )

                ],
              ),
              SizedBox(height: size.height * 0.02,),
              Divider(
                color:Colors.grey,
                indent: 10.0,
                endIndent: 10.0,
              ),
              SizedBox(height: size.height * 0.02,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check,color: Colors.green,),
                  SizedBox(width: 5.0,),
                  Text('Phương thức: ',style: HeadLine1(context),),
                  Spacer(),
                  Container(
                    width: size.width * 0.3,
                      child: Text(billPay.payType,style: TextLine1(context,true),maxLines: 2,)
                  )

                ],
              ),
              SizedBox(height: size.height * 0.02,),
              Divider(
                color:Colors.grey,
                indent: 10.0,
                endIndent: 10.0,
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
                      child: Text(billPay.facilityName,style: TextLine1(context,true),maxLines: 2,)
                  )

                ],
              ),
              SizedBox(height: size.height * 0.02,),

              Divider(
                color:Colors.grey,
                indent: 10.0,
                endIndent: 10.0,
              ),
              SizedBox(height: size.height * 0.02,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.sports_soccer,color: Colors.green,),
                  SizedBox(width: 5.0,),
                  Text('Loại sân: ',style: HeadLine1(context),),
                  Spacer(),
                  Text(billPay.fieldType,style: TextLine1(context,true),maxLines: 2,)

                ],
              ),
              SizedBox(height: size.height * 0.02,),

              Divider(
                color:Colors.grey,
                indent: 10.0,
                endIndent: 10.0,
              ),
              SizedBox(height: size.height * 0.02,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.calendar_month,color: Colors.green,),
                  SizedBox(width: 5.0,),
                  Text('Ngày đá: ',style: HeadLine1(context),),
                  Spacer(),
                  Text(dateFormat(billPay.dateReserved),style: TextLine1(context,true),maxLines: 2,)

                ],
              ),
              SizedBox(height: size.height * 0.02,),

              Divider(
                color:Colors.grey,
                indent: 10.0,
                endIndent: 10.0,
              ),
              SizedBox(height: size.height * 0.02,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.timer,color: Colors.green,),
                  SizedBox(width: 5.0,),
                  Text('Giờ đá: ',style: HeadLine1(context),),
                  Spacer(),
                  Text(timeFormat(billPay.startTime)+" - "+timeFormat(billPay.endTime),style: TextLine1(context,true),maxLines: 2,)

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

}