import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/a_matched_post_bloc/matched_post_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/a_matched_post_bloc/matched_post_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/a_matched_post_bloc/matched_post_state.dart';
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
import 'package:football_booking_fbo_mobile/UI/authenticated/find_opponent_request/book_field_after_matched.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/find_opponent_request/opponent_request_card.dart';
import 'package:football_booking_fbo_mobile/constants.dart';
import 'dart:developer';

class OpponentRequestDetail extends StatefulWidget {
  OpponentRequest request;

  OpponentRequestDetail({required this.request});

  @override
  State<OpponentRequestDetail> createState() => _OpponentRequestDetailState();
}

class _OpponentRequestDetailState extends State<OpponentRequestDetail> {
  @override
  void initState() {
    if(widget.request.status == 1){
      BlocProvider.of<OpponentRequestDetailBloc>(context)
          .add(FetchOpponentRequestDetail(requestId: widget.request.id));
      BlocProvider.of<RecommendedRequestBloc>(context)
          .add(GetRecommendedRequest(requestId: widget.request.id));
      BlocProvider.of<WaitingRequestBloc>(context)
          .add(GetWaitingRequest(requestId: widget.request.id));
    }
    else if(widget.request.status == 2){
      BlocProvider.of<OpponentRequestDetailBloc>(context)
          .add(FetchOpponentRequestDetail(requestId: widget.request.id));
      BlocProvider.of<MatchedPostBloc>(context)
          .add(GetMatchedPost(myPostId: widget.request.id));
    }
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
        title: Text('Chi tiết yêu cầu', style: WhiteTitleText()),
        centerTitle: true,
        actions: [
          TextButton(
            child: Text('xóa', style: TextStyle(color: Colors.redAccent)),
            onPressed: () {
              _showDeletingOpponentRequest();
            },
          ),
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
          height: size.height,
          padding: MyPaddingLeftRight(),
          child: BlocBuilder<OpponentRequestDetailBloc,
              OpponentRequestDetailState>(builder: (context, myState) {
            if (myState is LoadingOpponentRequestDetail) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (myState is LoadedOpponentRequestDetail) {
              log('status post:'+ myState.requestDetail.status.toString());
              return RefreshIndicator(
                onRefresh: ()async{
                  if(myState.requestDetail.status == 1){
                    BlocProvider.of<OpponentRequestDetailBloc>(context)
                        .add(FetchOpponentRequestDetail(requestId: widget.request.id));
                    BlocProvider.of<RecommendedRequestBloc>(context)
                        .add(GetRecommendedRequest(requestId: widget.request.id));
                    BlocProvider.of<WaitingRequestBloc>(context)
                        .add(GetWaitingRequest(requestId: widget.request.id));
                  }
                  else if(myState.requestDetail.status == 2){
                    BlocProvider.of<OpponentRequestDetailBloc>(context)
                        .add(FetchOpponentRequestDetail(requestId: widget.request.id));
                    BlocProvider.of<MatchedPostBloc>(context)
                        .add(GetMatchedPost(myPostId: widget.request.id));
                  }
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      RequestInformationCard(myState: myState.requestDetail),
                      SizedBox(
                        height: 10.0,
                      ),
                      myState.requestDetail.status == 1 ? DefaultTabController(
                          length: 2, // length of tabs
                          initialIndex: 0,
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      color: Colors.grey[300]),
                                  child: TabBar(
                                    indicator: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25.0),
                                        color: Colors.green),
                                    labelColor: Colors.white,
                                    unselectedLabelColor: Colors.black,
                                    tabs: [
                                      Tab(text: 'Yêu cầu phù hợp'),
                                      Tab(text: 'Đội đang chờ'),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                      height: size.height * 0.56 - 1, //height of TabBarView
                                      decoration: BoxDecoration(
                                          border: Border(
                                              top: BorderSide(
                                                  color: Colors.grey, width: 0.5))),
                                      child: TabBarView(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          children: <Widget>[
                                            BlocBuilder<RecommendedRequestBloc,
                                                    RecommendedRequestState>(
                                                builder: (context, state) {
                                              if (state
                                                  is LoadingRecommendedRequests) {
                                                return Center(
                                                  child: CircularProgressIndicator(),
                                                );
                                              } else if (state
                                                  is LoadedRecommendedRequests) {
                                                if (state.requestList.isEmpty) {
                                                  return Center(
                                                      child: Text(
                                                    'hiện tại Không có yêu cầu phù hợp nào',
                                                    style: Black12TextLine(false),
                                                  ));
                                                } else {
                                                  return Flex(
                                                    direction: Axis.vertical,
                                                    children: [
                                                  Expanded(
                                                  child: ListView.separated(
                                                  shrinkWrap: true,
                                                      separatorBuilder:
                                                          (BuildContext context,
                                                          int index) =>
                                                      const SizedBox(
                                                          height: 10.0),
                                                      padding: MyPaddingAll(),
                                                      // shrinkWrap: true,
                                                      itemCount:
                                                      state.requestList.length,
                                                      itemBuilder:
                                                      ((context, index) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            // Navigator.push(context, MaterialPageRoute(builder: (context) =>  OpponentRequestDetail(request: state.requestList[index],)));
                                                          },
                                                          child: RecommendedRequestCard(
                                                              opponentRequestItem:
                                                              state.requestList[
                                                              index],
                                                              myRequest: myState
                                                                  .requestDetail),
                                                        );
                                                      })),
                                                  ),
                                                    ],
                                                  );
                                                }
                                              } else {
                                                return Center(
                                                  child: Text('Something wrong!!'),
                                                );
                                              }
                                            }),
                                            BlocBuilder<WaitingRequestBloc,
                                                    WaitingRequestState>(
                                                builder: (context, state) {
                                              if (state is LoadingWaitingRequests) {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              } else if (state
                                                  is LoadedWaitingRequests) {
                                                if (state.requestList.isEmpty) {
                                                  return Center(
                                                      child: Text(
                                                    'Hiện tại không có đội đang chờ nào',
                                                    style: Black12TextLine(false),
                                                  ));
                                                } else {
                                                  return Flex(
                                                    direction: Axis.vertical,
                                                    children: [
                                                      Expanded(
                                                          child:ListView.separated(
                                                              shrinkWrap: true,
                                                              physics:
                                                              NeverScrollableScrollPhysics(),
                                                              separatorBuilder:
                                                                  (BuildContext context,
                                                                  int index) =>
                                                              const SizedBox(
                                                                  height: 10.0),
                                                              padding: MyPaddingAll(),
                                                              // shrinkWrap: true,
                                                              itemCount:
                                                              state.requestList.length,
                                                              itemBuilder:
                                                              ((context, index) {
                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    // Navigator.push(context, MaterialPageRoute(builder: (context) =>  OpponentRequestDetail(request: state.requestList[index],)));
                                                                  },
                                                                  child: WaitingRequestCard(
                                                                      myRequest: myState.requestDetail,
                                                                      requestItem: state.requestList[index]),

                                                                );
                                                              })),
                                                      ),
                                                    ],
                                                  );
                                                }
                                              } else {
                                                return Center(
                                                  child: Text('Something wrong!!'),
                                                );
                                              }
                                            }),
                                          ])),

                              ])) : Column(
                                children: [
                                  Text('Đội Đối Thủ',style:HeadLine1()),
                                  SizedBox(height: 20.0,),
                                  BlocBuilder<MatchedPostBloc,MatchedPostState>(
                                      builder:(context,state) {
                                        if (state is LoadingMatchedPost) {
                                          return Center(
                                            child:
                                            CircularProgressIndicator(),
                                          );
                                        }else if (state is LoadedMatchedPost){
                                          return Column(
                                            children: [
                                              MatchedPostCard(matchedRequest: state.matchedRequest,),
                                              SizedBox(height: 10.0),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                                child: TextButton.icon(
                                                  icon:Icon(Icons.calendar_today,color: Colors.white,),
                                                  onPressed: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  BookingFieldAfterMatchedPage(myRequest:myState.requestDetail,opponentRequest: state.matchedRequest,)));
                                                  },
                                                  label: Text('Đặt sân và giờ đá',style: MyButtonText()),
                                                ),
                                              ),

                                            ],
                                          );
                                        }else {
                                          return Center(
                                            child: Text('Something wrong!!'),
                                          );
                                        }
                                      }
                                  ),

                                ],
                              ),
                    ],
                  ),
                ),
              );
            } else {
              return Text('Something went wrong');
            }
          }),
        ),
      ),
    );
  }

  Future<void> _showDeletingOpponentRequest() async {
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
                BlocProvider.of<OpponentRequestBloc>(context)
                    .add(DeleteOpponentRequest(requestId: widget.request.id));
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
