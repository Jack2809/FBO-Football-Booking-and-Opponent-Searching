import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_match_history/player_match_history_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_match_history/player_match_history_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_match_history/player_match_history_state.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/match_history/match_history_card.dart';
import 'package:football_booking_fbo_mobile/UI/unauthenticated/login_page/player_match_history_detail.dart';

import '../../../constants.dart';

class PlayerMatchHistoryPage extends StatefulWidget {
  String phoneNumber;

  PlayerMatchHistoryPage({required this.phoneNumber});
  @override
  State<PlayerMatchHistoryPage> createState() => _PlayerMatchHistoryPageState();
}

class _PlayerMatchHistoryPageState extends State<PlayerMatchHistoryPage> {

  @override
  void initState() {
    BlocProvider.of<PlayerMatchHistoryBloc>(context).add(FetchPlayerMatchHistory(phoneNumber: widget.phoneNumber));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        bottomOpacity: 0.0,
        shadowColor: Colors.grey.withOpacity(0.02),
        backgroundColor: Colors.green,
        title: Text('Lịch sử trận đấu', style: WhiteTitleText()),
        centerTitle: true,
        actions: [],
      ),
      body: SafeArea(
        child: Container(
          padding: MyPaddingAll10(),
          child: BlocBuilder<PlayerMatchHistoryBloc, PlayerMatchHistoryState>(
              builder: (context, state) {
                if (state is LoadingPlayerMatchHistory) {
                  return Container(
                    height: size.height * 0.8,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is LoadedPlayerMatchHistory) {
                  if (state.matchHistoryList.isEmpty) {
                    return Center(
                      child: Text('Không có lịch sử trận đấu nào của Số Điện Thoại này'),
                    );
                  } else {
                    return ListView.separated(
                        separatorBuilder:
                            (BuildContext context, int index) =>
                        const SizedBox(height: 10.0),
                        padding: MyPaddingAll10(),
                        shrinkWrap: true,
                        itemCount: state.matchHistoryList.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> PlayerMatchHistoryDetail(matchHistory: state.matchHistoryList[index],)));
                            },
                            child: MatchHistoryCard(
                                matchHistory:
                                state.matchHistoryList[index]),
                          );
                        }));
                  }
                } else {
                  return Center(
                    child: Text('Something wrong!!'),
                  );
                }
              }),
        ),
      ),
    );
  }

}