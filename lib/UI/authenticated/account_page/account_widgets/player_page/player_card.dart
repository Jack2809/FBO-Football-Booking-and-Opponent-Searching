import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_bloc/player_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_bloc/player_event.dart';
import 'package:football_booking_fbo_mobile/Models/player_model.dart';
import 'package:football_booking_fbo_mobile/constants.dart';

class PlayerCard extends StatefulWidget {
  Player player;
  PlayerCard({required this.player});

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Container(
      height: size.height * 0.1,
      padding: MyPaddingAll(),
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
              spreadRadius: 2.0,
            ),
          ]
      ),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/player_icon.png'),
                    backgroundColor: Colors.green,radius: size.width * 0.06),
                SizedBox(width: size.width * 0.02,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person,color: Colors.green),
                        Text(widget.player.name),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.phone,color: Colors.green),
                        Text(widget.player.phone),
                      ],
                    ),
                  ],
                ),
              ]),
            ],
          ),
          Spacer(),
          TextButton.icon(
            onPressed: () {
              _showDeletingPlayer();
            },
            icon: Icon(Icons.delete,color: Colors.redAccent),
            label: Text('Xóa',style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _showDeletingPlayer(){
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Xóa Cầu Thủ',
      desc: 'Bạn có thật sự muốn xóa cầu thủ này khỏi hệ thống chứ ?',
      buttonsTextStyle: const TextStyle(color: Colors.black),
      showCloseIcon: true,
      btnOkOnPress: () {
        BlocProvider.of<PlayerBloc>(context).add(DeletePlayer(playerId: widget.player.id));
      },
      btnCancelOnPress: (){
      },
    ).show();
  }
}