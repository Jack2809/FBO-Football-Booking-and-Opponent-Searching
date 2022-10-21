import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/club_bloc/club_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/club_bloc/club_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_bloc/player_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_bloc/player_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_bloc/player_state.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_state.dart';
import 'package:football_booking_fbo_mobile/Models/player_model.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/account_page/account_widgets/club/player_card.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/account_page/account_widgets/club/player_creation.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/account_page/account_widgets/club/team_card.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/account_page/account_widgets/club/team_creation.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/account_page/account_widgets/club/team_detail.dart';
import 'package:football_booking_fbo_mobile/Validator/player_validator.dart';
import 'package:football_booking_fbo_mobile/constants.dart';
import '../../../../../Models/club_model.dart';

class ClubDetail extends StatefulWidget {
  Club club;


  ClubDetail({required this.club});

  @override
  State<ClubDetail> createState() => _ClubDetailState();
}

class _ClubDetailState extends State<ClubDetail> with InputPlayerValidation{
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
    BlocProvider.of<PlayerClubBloc>(context)
        .add(FetchClubPlayers(clubId: widget.club.id));

    BlocProvider.of<TeamBloc>(context)
        .add(FetchTeams(clubId: widget.club.id));
    super.initState();
  }

  final formGlobalKey = GlobalKey<FormState>();

  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController jerseyNoC = TextEditingController();
  TextEditingController ageC = TextEditingController();

  List<Player> clubPlayerList = [];

  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Xem chi tiết CLB', style: TextLine1(true)),
        centerTitle: true,
        elevation: 0.0,
        bottomOpacity: 0.0,
        shadowColor: Colors.grey.withOpacity(0.02),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),

        actions: [
          IconButton(
            icon: Icon(Icons.delete,color: Colors.red),
            onPressed: (){
              _showDeleteingClub();
            },
          ),
        ],

      ),
      body: Form(
        key: formGlobalKey,
        child: Container(
          color: Colors.grey.withOpacity(0.02),
          padding: MyPaddingAll(),
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
                Center(child: Text(widget.club.name, style: TextLine1(true))),
                Text(
                  'Mô tả',
                  style: HeadLine1(),
                ),
                Text(widget.club.name, style: TextLine2()),
                Text('Danh sách đội hình :',style: HeadLine1()),
                BlocBuilder<TeamBloc,TeamState>(
                    builder: (context, state) {
                      if (state is LoadingTeams) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is LoadedTeams) {
                        if (state.teamList.isEmpty) {
                          return Center(
                            child: Text('Không có Team nào'),
                          );
                        } else {
                          return SizedBox(
                            height: size.height * 0.15,
                            child: ListView.separated(
                              separatorBuilder: (BuildContext context, int index) => const SizedBox(width:10.0),
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: state.teamList.length,
                                itemBuilder: ((context, index) {
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => TeamDetail(team: state.teamList[index],club:widget.club,clubPlayerList:clubPlayerList,)));
                                    },
                                      child: TeamCard(team: state.teamList[index])
                                  );
                                })),
                          );
                        }
                      } else {
                        return Center(
                          child: Text('Something wrong!!'),
                        );
                      }

    }),
                Text('Danh sách cầu thủ trong CLB:',style: HeadLine1()),
                BlocBuilder<PlayerClubBloc, PlayerClubState>(
                    builder: (context, state) {
                  if (state is LoadingClubPlayers) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LoadedClubPlayers) {
                    clubPlayerList = state.clubPlayersList;
                    if (state.clubPlayersList.isEmpty) {
                      return Center(
                        child: Text('Không có Player nào !'),
                      );
                    } else {
                      return ListView.separated(
                        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 5.0),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.clubPlayersList.length,
                          itemBuilder: ((context, index) {
                            return PlayerCard(player: state.clubPlayersList[index],club:widget.club,);
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
      floatingActionButton: Row(
        children: [
          Container(
            color: Colors.green,
            child: TextButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  CreatePlayerPage(club:widget.club)));
              },
              icon: Icon(Icons.person_add_rounded,color:Colors.black),
              label: Text('Thêm cầu thủ',style: TextLine2()),
            ),
          ),
          Spacer(),
          Container(
            color: Colors.green,
            child: TextButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  CreateTeamPage(club:widget.club)));
              },
              icon: Icon(Icons.add,color:Colors.black),
              label: Text('Tạo đôi hình',style: TextLine2()),
            ),
          )
        ],
      ),
    );
  }


  Future<void > _showDeleteingClub() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xóa CLB'),
          content: Text('Bạn thật sự muốn xóa CLB chứ ?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Xóa'),
              onPressed: () {
                BlocProvider.of<ClubBloc>(context).add(DeleteClub(clubId: widget.club.id));
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
