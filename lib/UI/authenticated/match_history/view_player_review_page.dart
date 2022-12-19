import 'package:flutter/material.dart';
import 'package:football_booking_fbo_mobile/Models/player_review.dart';
import 'package:football_booking_fbo_mobile/constants.dart';

class ViewPlayerReviewPage extends StatelessWidget{
  PlayerReview playerReview;

  ViewPlayerReviewPage({required this.playerReview});

  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Xem đánh giá',style: WhiteTitleText()),
        centerTitle: true,
        elevation: 0.0,
        bottomOpacity: 0.0,
        shadowColor: Colors.grey.withOpacity(0.02),
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.white),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: MyPaddingAll10(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tên cầu thủ',style: HeadLine1(context),),
            SizedBox(height: size.height * 0.01,),
            Container(
                padding: MyPaddingAll(),
                width: size.width ,
                height: size.height * 0.05,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: const Offset(
                          0.0,
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
                    ]
                ),
                child: Text(playerReview.playerName,style: TextLine1(context,true),)),
            SizedBox(height: size.height * 0.03,),
            Text('Biểu hiện của cầu thủ',style: HeadLine1(context),),
            SizedBox(height: size.height * 0.01,),
            Container(
                padding: MyPaddingAll(),
                width: size.width ,
                height: size.height * 0.05,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: const Offset(
                          0.0,
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
                    ]
                ),
                child: Text(playerReview.star == 1 ? "Tốt":"Xấu",style: TextLine1(context,true),)),
            SizedBox(height: size.height * 0.03,),
            Text('Bình luận về cầu thủ',style: HeadLine1(context),),
            SizedBox(height: size.height * 0.01,),
            Container(
                padding: MyPaddingAll(),
                width: size.width ,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: const Offset(
                          0.0,
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
                    ]
                ),
                child: Text(playerReview.comment,style: TextLine1(context,true),maxLines: 5),),
          ],
        ),
      ),


    );
  }

}