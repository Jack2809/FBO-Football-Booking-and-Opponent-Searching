import 'package:flutter/material.dart' ;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/opponent_request_bloc/opponent_request_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/opponent_request_bloc/opponent_request_event.dart';
import 'package:football_booking_fbo_mobile/Models/opponent_request_model.dart';
import 'package:football_booking_fbo_mobile/constants.dart';

class OpponentRequestDetail extends StatefulWidget{
  OpponentRequest request;

  OpponentRequestDetail({required this.request});

  @override
  State<OpponentRequestDetail> createState() => _OpponentRequestDetailState();
}

class _OpponentRequestDetailState extends State<OpponentRequestDetail> {

  String timeFormat (String time){
    var split = time.split(':');
    String finalTime = split[0]+":"+split[1];
    return finalTime;
  }

  String dateFormat(String date){
    var split = date.split('-');
    String finalDate = split[2]+"-"+split[1]+"-"+split[0];
    return finalDate;
  }



  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        bottomOpacity: 0.0,
        shadowColor: Colors.grey.withOpacity(0.02),
        backgroundColor: Colors.transparent,
        title: Text('Chi tiết yêu cầu',style: HeadLine1()),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                _showDeleteingOpponentRequest();
              }, icon: Icon(Icons.delete,color: Colors.redAccent,)),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: Container(
        padding: MyPaddingAll(),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ngày đá',style:HeadLine1()),
                    Text(dateFormat(widget.request.bookingDate),style:TextLine1(true),),
                    Text('Khu vực',style:HeadLine1()),
                    Text("...",style:TextLine1(true)),
                    Text('Thời gian rảnh',style:HeadLine1()),
                    Text(timeFormat(widget.request.startFreeTime)+"-"+timeFormat(widget.request.endFreeTime),style:TextLine1(true)),
                  ],
                ),
                SizedBox(width: size.width * 0.1,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Thời lượng',style:HeadLine1()),
                    Text(widget.request.duration.toString()+"'",style:TextLine1(true)),
                    Text('Loại sân',style:HeadLine1()),
                    Text(widget.request.fieldTypeId == 1 ?"5 vs 5" : "7 vs 7",style:TextLine1(true)),
                    Text('Đội hình',style:HeadLine1()),
                    Text(widget.request.teamName,style:TextLine1(true)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5.0,),
          ],
        ),
      ),
    );
  }
  Future<void > _showDeleteingOpponentRequest() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xóa yêu cầu'),
          content: Text('Bạn thật sự muốn xóa yêu cầu này chứ ?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Xóa'),
              onPressed: () {
                BlocProvider.of<OpponentRequestBloc>(context).add(DeleteOpponentRequest(requestId: widget.request.id));
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Hủy bỏ'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}