import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_bloc/player_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_bloc/player_event.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/account_page/account_widgets/player_page/player_card.dart';
import 'package:football_booking_fbo_mobile/constants.dart';
import '../../../../../Blocs/player_bloc/player_state.dart';
import 'player_detail_page.dart';


class PlayerPage extends StatefulWidget{
  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {


  @override
  void initState() {
    BlocProvider.of<PlayerBloc>(context).add(FetchPlayers());
    super.initState();
    BlocProvider.of<PlayerBloc>(context).listenerStream.listen((event) {
      if(event == ""){

      } else if(event == "Đã xóa cầu thủ"){
        successfulDialog(context, event);
      }else{
        failDialog(context, event);
      }

    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cầu thủ của tôi', style: WhiteTitleText()),
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
      ),
      body: Container(
        color: Colors.grey.withOpacity(0.02),
        child: BlocBuilder<PlayerBloc,PlayerState>(
            builder:(context,state){
              if(state is LoadingPlayers){
                return Center(child: CircularProgressIndicator(),);
              }
              else if(state is LoadedPlayers){
                if(state.playersList.isEmpty){
                  return Center(child: Text('Không có cầu thủ nào'),);
                }else{
                  return ListView.separated(
                      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10.0),
                      padding: MyPaddingAll10(),
                      // shrinkWrap: true,
                      itemCount: state.playersList.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> PlayerDetail(player:state.playersList[index])));
                          },
                          child: PlayerCard(player: state.playersList[index]),
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
      // floatingActionButton: Container(
      //   decoration:BoxDecoration(
      //     borderRadius: BorderRadius.circular(10.0),
      //     color: Colors.green,
      //   ),
      //   child: TextButton.icon(
      //     onPressed: () {
      //       // Navigator.push(context, MaterialPageRoute(builder: (context) =>  CreateTeamPage()),);
      //     },
      //     icon: Icon(Icons.add,color: Colors.white,),
      //     label: Text('Tạo Đội hình',style: MyButtonText()),
      //   ),
      // ),

    );
  }
}