import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_team_bloc/player_team_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_team_bloc/player_team_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_team_bloc/player_team_state.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_event.dart';
import 'package:football_booking_fbo_mobile/Models/player_model.dart';
import 'package:football_booking_fbo_mobile/Models/team_model.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/account_page/account_widgets/team/player_card.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/account_page/account_widgets/team/player_creation.dart';
import 'package:football_booking_fbo_mobile/Validator/player_validator.dart';
import 'package:football_booking_fbo_mobile/constants.dart';

class TeamDetail extends StatefulWidget {
  Team team;


  TeamDetail({required this.team});

  @override
  State<TeamDetail> createState() => _TeamDetailState();
}

class _TeamDetailState extends State<TeamDetail> with InputPlayerValidation{
  @override
  void dispose() {
    nameC.dispose();
    phoneC.dispose();
    emailC.dispose();
    jerseyNoC.dispose();
    ageC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    BlocProvider.of<TeamBloc>(context)
        .add(FetchTeams());
    BlocProvider.of<PlayerTeamBloc>(context).add(FetchTeamPlayers(teamId: widget.team.id));
    super.initState();
  }

  final formGlobalKey = GlobalKey<FormState>();

  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController jerseyNoC = TextEditingController();
  TextEditingController ageC = TextEditingController();
  bool _isDelete = false;

  @override
  Widget build(BuildContext context) {

    Size size = getSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Xem chi tiết Đội Hình', style: WhiteTitleText()),
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
          IconButton(
            icon: Icon(Icons.delete,color: Colors.white),
            onPressed: (){
              _showDeletingTeam();

            },
          ),
        ],

      ),
      body: Form(
        key: formGlobalKey,
        child: Container(
          color: Colors.grey.withOpacity(0.02),
          padding: MyPaddingAll10(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: CircleAvatar(
                    backgroundColor: primaryColor,
                    child: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/FPT_logo_2010.svg/640px-FPT_logo_2010.svg.png', fit: BoxFit.fill),
                    radius: size.height * 0.1,
                  ),
                ),
                Center(child: Text(widget.team.name, style: TextLine1(true))),
                Text(
                  'Mô tả',
                  style: HeadLine1(),
                ),
                Text(widget.team.name, style: TextLine2()),

                Text('Danh sách cầu thủ trong Đôi Hình:',style: HeadLine1()),
                BlocBuilder<PlayerTeamBloc, PlayerTeamState>(
                    builder: (context, state) {
                  if (state is LoadingTeamPlayers) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LoadedTeamPlayers) {

                    if (state.teamPlayersList.isEmpty) {
                      return Center(
                        child: Text('Không có Player nào !'),
                      );
                    } else {
                      return ListView.separated(
                        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 5.0),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.teamPlayersList.length,
                          itemBuilder: ((context, index) {
                            return PlayerCard(team:widget.team,player: state.teamPlayersList[index],);
                          }));
                    }
                  } else {
                    return Center(
                      child: Text('Something wrong!!'),
                    );
                  }
                }),
                SizedBox(height: size.height * 0.1),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.green,
        ),
        child: TextButton.icon(
          onPressed: () async{
            final result = await Navigator.push(context, MaterialPageRoute(builder: (context) =>  CreatePlayerPage(team: widget.team)));
            if(!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green,content: Text(result)));
          },
          icon: Icon(Icons.person_add_rounded,color:Colors.white),
          label: Text('Thêm cầu thủ',style: MyButtonText()),
        ),
      ),
    );
  }


  Future<void > _showDeletingTeam() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xóa Đội Hình'),
          content: Text('Bạn thật sự muốn xóa Đội Hình chứ ?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Xóa'),
              onPressed: () {
                setState(() {
                  _isDelete = true ;
                });
                BlocProvider.of<TeamBloc>(context).add(DeleteTeam(teamId: widget.team.id));
                Navigator.pop(context);
                Navigator.pop(context,'Đội hình đã được xóa');
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Hủy bỏ'),
              onPressed: () {
                setState(() {
                  _isDelete = false ;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
