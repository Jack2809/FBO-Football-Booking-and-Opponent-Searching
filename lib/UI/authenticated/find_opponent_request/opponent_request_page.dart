import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/opponent_request_bloc/opponent_request_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/opponent_request_bloc/opponent_request_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/opponent_request_bloc/opponent_request_state.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/find_opponent_request/opponent_request_card.dart';
import 'package:football_booking_fbo_mobile/constants.dart';
import 'opponent_request_creation.dart';
import 'opponent_request_detail.dart';

class OpponentRequestPage extends StatefulWidget{

  @override
  State<OpponentRequestPage> createState() => _OpponentRequestPageState();
}

class _OpponentRequestPageState extends State<OpponentRequestPage> {

  @override
  void initState() {
    BlocProvider.of<OpponentRequestBloc>(context).add(FetchOpponentRequests());
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        bottomOpacity: 0.0,
        shadowColor: Colors.grey.withOpacity(0.02),
        backgroundColor: Colors.green,
        title: Text('Yêu cầu của tôi',style: WhiteTitleText()),
        // centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add,color: Colors.white),
            onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => CreateOpponentRequestPage()));
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.grey.withOpacity(0.02),
        padding: MyPaddingAll(),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<OpponentRequestBloc>(context).add(FetchOpponentRequests());
            },
            child: BlocBuilder<OpponentRequestBloc,OpponentRequestState>(
                builder:(context,state){
                  if(state is LoadingOpponentRequests){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  else if(state is LoadedOpponentRequests){
                    if(state.requestList.isEmpty){
                      return Center(child: Text('Không có yêu cầu nào'),);
                    }else{
                      return ListView.separated(
                          separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10.0),
                          padding: MyPaddingAll(),
                          // shrinkWrap: true,
                          itemCount: state.requestList.length,
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>  OpponentRequestDetail(requestId: state.requestList[index].id,requestStatus: state.requestList[index].status,)));
                              },
                              child: OpponentRequestCard(requestItem: state.requestList[index]),
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
        ),
      ),

    );
  }
}