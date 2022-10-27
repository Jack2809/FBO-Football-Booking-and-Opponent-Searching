import 'package:flutter/material.dart' ;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/opponent_request_bloc/opponent_request_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/opponent_request_bloc/opponent_request_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/opponent_request_detail_bloc/opponent_request_detail_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/opponent_request_detail_bloc/opponent_request_detail_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/opponent_request_detail_bloc/opponent_request_detail_state.dart';
import 'package:football_booking_fbo_mobile/Blocs/recommended_request_bloc/recommended_request_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/recommended_request_bloc/recommended_request_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/recommended_request_bloc/recommended_request_state.dart';
import 'package:football_booking_fbo_mobile/Blocs/waiting_request_bloc/waiting_request_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/waiting_request_bloc/waiting_request_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/waiting_request_bloc/waiting_request_state.dart';
import 'package:football_booking_fbo_mobile/Models/opponent_request_model.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/find_opponent_request/opponent_request_card.dart';
import 'package:football_booking_fbo_mobile/constants.dart';

class OpponentRequestDetail extends StatefulWidget{
  OpponentRequest request;

  OpponentRequestDetail({required this.request});

  @override
  State<OpponentRequestDetail> createState() => _OpponentRequestDetailState();
}

class _OpponentRequestDetailState extends State<OpponentRequestDetail> {

  @override
  void initState() {
    BlocProvider.of<OpponentRequestDetailBloc>(context).add(FetchOpponentRequestDetail(requestId: widget.request.id));
    BlocProvider.of<RecommendedRequestBloc>(context).add(GetRecommendedRequest(requestId: widget.request.id));
    BlocProvider.of<WaitingRequestBloc>(context).add(GetWaitingRequest(requestId: widget.request.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        bottomOpacity: 0.0,
        shadowColor: Colors.grey.withOpacity(0.03),
        backgroundColor: Colors.green,
        title: Text('Chi tiết yêu cầu',style: WhiteTitleText()),
        centerTitle: true,
        actions: [
          TextButton(
            child: Text('xóa',style: TextStyle(color: Colors.redAccent)),
              onPressed: (){
                _showDeleteingOpponentRequest();
              },),
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
          padding: MyPaddingLeftRight(),
          child: BlocBuilder<OpponentRequestDetailBloc,OpponentRequestDetailState>(
              builder:(context,myState){
                if(myState is LoadingOpponentRequestDetail){
                  return Center(child: CircularProgressIndicator(),);
                }
                else if(myState is LoadedOpponentRequestDetail){
                  return Column(
                    children: <Widget>[
                   RequestInformationCard(myState: myState.requestDetail),

                      SizedBox(height: 10.0,),
                      DefaultTabController(
                          length: 2, // length of tabs
                          initialIndex: 0,
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    color: Colors.grey[300]
                                  ),
                                  child: TabBar(
                                    indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      color: Colors.green
                                    ),
                                    labelColor: Colors.white,
                                    unselectedLabelColor: Colors.black,
                                    tabs: [
                                      Tab(text: 'Yêu cầu phù hợp'),
                                      Tab(text: 'Đội đang chờ'),

                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.0,),
                                Container(
                                      height: size.height * 0.56 - 1, //height of TabBarView
                                      decoration: BoxDecoration(
                                          border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
                                      ),
                                      child: Expanded(
                                        child: TabBarView(
                                        physics: const NeverScrollableScrollPhysics(),
                                            children: <Widget>[
                                          BlocBuilder<RecommendedRequestBloc,RecommendedRequestState>(
                                              builder:(context,state){
                                                if(state is LoadingRecommendedRequests){
                                                  return Center(child: CircularProgressIndicator(),);
                                                }
                                                else if(state is LoadedRecommendedRequests){
                                                  if(state.requestList.isEmpty){
                                                    return Center(child: Text('hiện tại Không có yêu cầu phù hợp nào',style: TextLine1(true),));
                                                  }else{
                                                    return ListView.separated(
                                                        shrinkWrap: true,
                                                        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10.0),
                                                        padding: MyPaddingAll(),
                                                        // shrinkWrap: true,
                                                        itemCount: state.requestList.length,
                                                        itemBuilder: ((context, index) {
                                                          return GestureDetector(
                                                            onTap: (){
                                                              // Navigator.push(context, MaterialPageRoute(builder: (context) =>  OpponentRequestDetail(request: state.requestList[index],)));
                                                            },
                                                            child: RecommendedRequestCard(opponentRequestItem: state.requestList[index],myRequest: myState.requestDetail),
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
                                          BlocBuilder<WaitingRequestBloc,WaitingRequestState>(
                                              builder:(context,state){
                                                if(state is LoadingWaitingRequests){
                                                  return Center(child: CircularProgressIndicator(),);
                                                }
                                                else if(state is LoadedWaitingRequests){
                                                  if(state.requestList.isEmpty){
                                                    return Center(child: Text('Hiện tại không có đội đang chờ nào',style: Black12TextLine(false),));
                                                  }else{
                                                    return ListView.separated(
                                                        shrinkWrap: true,
                                                        physics: NeverScrollableScrollPhysics(),
                                                        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10.0),
                                                        padding: MyPaddingAll(),
                                                        // shrinkWrap: true,
                                                        itemCount: state.requestList.length,
                                                        itemBuilder: ((context, index) {
                                                          return GestureDetector(
                                                            onTap: (){
                                                              // Navigator.push(context, MaterialPageRoute(builder: (context) =>  OpponentRequestDetail(request: state.requestList[index],)));
                                                            },
                                                            child: WaitingRequestCard(requestItem: state.requestList[index]),
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
                                        ]),
                                      )
                                  ),

                              ])
                      ),
                    ],
                  );
                }else{
                  return Text('Something went wrong');
                }

              }
          ),
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



