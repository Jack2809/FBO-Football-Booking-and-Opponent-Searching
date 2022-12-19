import 'package:flutter/material.dart';
import 'package:football_booking_fbo_mobile/Models/player_model.dart';
import 'package:football_booking_fbo_mobile/constants.dart';

class PlayerDetail extends StatefulWidget {
  Player player;


  PlayerDetail({required this.player});

  @override
  State<PlayerDetail> createState() => _PlayerDetailState();
}

class _PlayerDetailState extends State<PlayerDetail> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = getSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Xem chi tiết cầu thủ', style: WhiteTitleText()),
        centerTitle: true,
        elevation: 0.0,
        bottomOpacity: 0.0,
        shadowColor: Colors.grey.withOpacity(0.02),
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),

        actions: [

        ],

      ),
      body: Container(
        color: Colors.grey.withOpacity(0.02),
        padding: MyPaddingAll10(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  backgroundColor: primaryColor,
                  backgroundImage: AssetImage('assets/player_icon.png'),
                  radius: size.height * 0.1,
                ),
              ),
              Center(child: Text(widget.player.name,style: TextLine1(context,true)),),
              SizedBox(height: size.height * 0.02,),
              Row(
                children: [
                  Icon(Icons.phone,color:Colors.green,size: size.height * 0.03,),
                  SizedBox(width: size.width * 0.02,),
                  Text('SĐT: ',style: HeadLine1(context)),
                  Text(widget.player.phone,style: TextLine1(context,false)),
                ],
              ),
              SizedBox(height: size.height * 0.02,),
              Text('Đội đang tham gia',style: HeadLine1(context)),
              SizedBox(height: size.height * 0.02,),
        widget.player.teamList.isEmpty?Center(child: Text('Cầu thủ này chưa gia nhập đội hình nào',style: TextLine1(context,false),maxLines: 2,textAlign: TextAlign.center),):ListView.separated(
            separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10.0),
            padding: MyPaddingAll10(),
            shrinkWrap: true,
            itemCount: widget.player.teamList.length,
            itemBuilder: ((context, index) {
                return Container(
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5.0,
                          spreadRadius: 2.0,
                        ),
                      ]
                  ),
                  child: Center(child: Text(widget.player.teamList[index].name,
                    style: TextLine1(context, true),)),
                );

              }
            ))
            ],
          ),
        ),
      ),

    );
  }

}