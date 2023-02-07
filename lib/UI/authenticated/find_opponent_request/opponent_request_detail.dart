import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/a_matched_post_bloc/matched_post_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/a_matched_post_bloc/matched_post_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/a_matched_post_bloc/matched_post_state.dart';
import 'package:football_booking_fbo_mobile/Blocs/booked_facility_post_bloc/booked_facility_post_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/booked_facility_post_bloc/booked_facility_post_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/booked_facility_post_bloc/booked_facility_post_state.dart';
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
import 'package:football_booking_fbo_mobile/UI/authenticated/find_opponent_request/book_field_after_matched.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/find_opponent_request/opponent_request_card.dart';
import 'package:football_booking_fbo_mobile/constants.dart';
import 'dart:developer';
import 'view_detail_facility_in_post.dart';

class OpponentRequestDetail extends StatefulWidget {
  int requestId;
  int requestStatus;
  bool expired ;
  OpponentRequestDetail({required this.requestId, required this.requestStatus,required this.expired});

  @override
  State<OpponentRequestDetail> createState() => _OpponentRequestDetailState();
}

class _OpponentRequestDetailState extends State<OpponentRequestDetail> {
  @override
  void initState() {
    log("ticket of list id: "+widget.requestId.toString());
    initialPage(widget.requestId,widget.requestStatus);
    super.initState();
    BlocProvider.of<OpponentRequestBloc>(context).listenerStream.listen((event) {
      if(event == ""){

      } else if(event == "Xóa yêu cầu thành công"){
        successfulDialog1Pop(context, event);
      }else if(event == "Không thể xóa yêu cầu vì đang trong quá trình đặt sân hoặc đã hoàn thành trận đấu"){
        failDialog(context, event);
      }else{
        errorDialog(context, event);
      }

    });
    BlocProvider.of<WaitingRequestBloc>(context).listenerStream.listen((event) {
      if(event == ""){

      }else if(event =="Chấp nhận yêu cầu thành công"){
        successfulDialog(context, event);
      }
      else if(event == "Yêu cầu này đã không còn khả dụng"){
        failDialog(context, event);
      }else{
        errorDialog(context, event);
      }

    });

    BlocProvider.of<RecommendedRequestBloc>(context).listenerStream.listen((event) {
      if(event == ""){

      } else if(event == "Hủy bỏ thành công"){
        successfulDialog(context, event);
      }else if(event == "Hủy bỏ thất bại, vì yêu cầu của bạn đã được cáp kèo"){
        failDialog(context, event);
        getTicketDetail();
      }else{
        errorDialog(context, event);
      }

    });
  }

  void getTicketDetail(){
    BlocProvider.of<OpponentRequestDetailBloc>(context)
        .add(FetchOpponentRequestDetail(requestId: widget.requestId));
  }

  void initialPage(int postId,int status){
    log("ticket status: " +status.toString());
    log('ticket id: ' + postId.toString());
    BlocProvider.of<OpponentRequestBloc>(context).add(FetchOpponentRequests());
    if (status == 1) {
      BlocProvider.of<OpponentRequestDetailBloc>(context)
          .add(FetchOpponentRequestDetail(requestId: postId));
      BlocProvider.of<RecommendedRequestBloc>(context)
          .add(GetRecommendedRequest(requestId: postId));
      BlocProvider.of<WaitingRequestBloc>(context)
          .add(GetWaitingRequest(requestId: postId));
    } else if (status == 2) {
      BlocProvider.of<OpponentRequestDetailBloc>(context)
          .add(FetchOpponentRequestDetail(requestId: postId));
      BlocProvider.of<MatchedPostBloc>(context)
          .add(GetMatchedPost(myPostId: postId));
    }
    else {
      BlocProvider.of<OpponentRequestDetailBloc>(context)
          .add(FetchOpponentRequestDetail(requestId: postId));
      BlocProvider.of<MatchedPostBloc>(context)
          .add(GetMatchedPost(myPostId: postId));
      BlocProvider.of<BookedFacilityByPostBloc>(context)
          .add(GetBookedFacilityByPost(postId: postId));
    }
  }

  void refreshPage(int postId,int status){
    log("ticket status: " +status.toString());
    log('ticket id: ' + postId.toString());
    BlocProvider.of<OpponentRequestBloc>(context).add(FetchOpponentRequests());
    if (status == 1) {
      BlocProvider.of<RecommendedRequestBloc>(context)
          .add(GetRecommendedRequest(requestId: postId));
      BlocProvider.of<WaitingRequestBloc>(context)
          .add(GetWaitingRequest(requestId: postId));
    } else if (status == 2) {
      BlocProvider.of<MatchedPostBloc>(context)
          .add(GetMatchedPost(myPostId: postId));
    }
    else {
      BlocProvider.of<MatchedPostBloc>(context)
          .add(GetMatchedPost(myPostId: postId));
      BlocProvider.of<BookedFacilityByPostBloc>(context)
          .add(GetBookedFacilityByPost(postId: postId));
    }
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
          IconButton(
            icon: Icon(Icons.delete,color: Colors.red),
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
          child: RefreshIndicator(
            onRefresh: () async {
              getTicketDetail();
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  BlocBuilder<OpponentRequestDetailBloc,
                      OpponentRequestDetailState>(builder: (context, myState) {
                    if (myState is LoadingOpponentRequestDetail) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (myState is LoadedOpponentRequestDetail) {
                      refreshPage(myState.requestDetail.id, myState.requestDetail.status);
                      return Column(
                        children: <Widget>[
                          RequestInformationCard(myState: myState.requestDetail),
                          SizedBox(
                            height: 10.0,
                          ),
                          myState.requestDetail.status == 1
                              ? DefaultTabController(
                              length: 2, // length of tabs
                              initialIndex: 0,
                              child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(25.0),
                                          color: Colors.grey[300]),
                                      child: TabBar(
                                        indicator: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(25.0),
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
                                        height: size.height, //height of TabBarView
                                        decoration: BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                    color: Colors.grey,
                                                    width: 0.5))),
                                        child: TabBarView(
                                            physics:
                                            const NeverScrollableScrollPhysics(),
                                            children: <Widget>[
                                              BlocBuilder<RecommendedRequestBloc, RecommendedRequestState>(
                                                  builder: (context, state) {
                                                    if (state is LoadingRecommendedRequests) {
                                                      return Center(
                                                        child:
                                                        CircularProgressIndicator(),
                                                      );
                                                    } else if (state is LoadedRecommendedRequests) {
                                                      if (state.requestList.isEmpty) {
                                                        return Center(
                                                            child: Text(
                                                              'Hiện tại Không có yêu cầu phù hợp nào',
                                                              style: Black26TextLine(context,
                                                                  false),
                                                            ));
                                                      } else {
                                                        return Flex(
                                                          direction: Axis.vertical,
                                                          children: [
                                                            Expanded(
                                                              child: ListView.separated(
                                                                  physics: NeverScrollableScrollPhysics(),
                                                                  shrinkWrap: true,
                                                                  separatorBuilder: (BuildContext
                                                                  context,
                                                                      int
                                                                      index) =>
                                                                  const SizedBox(
                                                                      height:
                                                                      10.0),
                                                                  padding:
                                                                  MyPaddingAll(),
                                                                  // shrinkWrap: true,
                                                                  itemCount: state
                                                                      .requestList
                                                                      .length,
                                                                  itemBuilder:
                                                                  ((context,
                                                                      index) {
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                      },
                                                                      child: RecommendedRequestCard(
                                                                          opponentRequestItem: state.requestList[
                                                                          index],
                                                                          myRequest:
                                                                          myState.requestDetail),
                                                                    );
                                                                  })),
                                                            ),
                                                          ],
                                                        );
                                                      }
                                                    } else {
                                                      return Center(
                                                        child: Text(
                                                            'Something wrong!!'),
                                                      );
                                                    }
                                                  }),
                                              BlocBuilder<WaitingRequestBloc,
                                                  WaitingRequestState>(
                                                  builder: (context, state) {
                                                    if (state
                                                    is LoadingWaitingRequests) {
                                                      return Center(
                                                        child:
                                                        CircularProgressIndicator(),
                                                      );
                                                    } else if (state
                                                    is LoadedWaitingRequests) {
                                                      if (state
                                                          .requestList.isEmpty) {
                                                        return Center(
                                                            child: Text(
                                                              'Hiện tại không có đội đang chờ nào',
                                                              style: Black26TextLine(context,
                                                                  false),
                                                            ));
                                                      } else {
                                                        return Flex(
                                                          direction: Axis.vertical,
                                                          children: [
                                                            Expanded(
                                                              child: ListView
                                                                  .separated(
                                                                  shrinkWrap:
                                                                  true,
                                                                  physics:
                                                                  NeverScrollableScrollPhysics(),
                                                                  separatorBuilder: (BuildContext
                                                                  context,
                                                                      int
                                                                      index) =>
                                                                  const SizedBox(
                                                                      height:
                                                                      10.0),
                                                                  padding:
                                                                  MyPaddingAll(),
                                                                  // shrinkWrap: true,
                                                                  itemCount: state
                                                                      .requestList
                                                                      .length,
                                                                  itemBuilder:
                                                                  ((context,
                                                                      index) {
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        // Navigator.push(context, MaterialPageRoute(builder: (context) =>  OpponentRequestDetail(request: state.requestList[index],)));
                                                                      },
                                                                      child: WaitingRequestCard(
                                                                        myRequest: myState
                                                                            .requestDetail,
                                                                        requestItem:
                                                                        state.requestList[index],
                                                                        callBack: (){getTicketDetail();},
                                                                      ),

                                                                    );
                                                                  })),
                                                            ),
                                                          ],
                                                        );
                                                      }
                                                    } else {
                                                      return Center(
                                                        child: Text(
                                                            'Something wrong!!'),
                                                      );
                                                    }
                                                  }),
                                            ])),
                                  ]))
                              : SizedBox(),
                          (myState.requestDetail.status == 2 ||
                              myState.requestDetail.status == 3)
                              ? Column(children: [
                            Text('Đội Đối Thủ', style: HeadLine1(context)),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            BlocBuilder<MatchedPostBloc, MatchedPostState>(
                                builder: (context, state) {
                                  if (state is LoadingMatchedPost) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state is LoadedMatchedPost) {
                                    return Column(
                                      children: [
                                        MatchedPostCard(
                                          matchedRequest: state.matchedRequest,
                                          rivalry: myState.requestDetail.isRivalry,
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        myState.requestDetail.status == 2
                                            ? state.matchedRequest.isBooker ==
                                            false
                                            ? Container(
                                          height: size.height * 0.05,
                                          width: size.width * 0.5,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                            BorderRadius.circular(
                                                10.0),
                                          ),
                                          child: TextButton.icon(
                                            icon: Icon(
                                              Icons.calendar_today,
                                              color: Colors.white,
                                            ),
                                            onPressed: myState.requestDetail.expired ? null:() async{
                                              bool result = await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BookingFieldAfterMatchedPage(
                                                            myRequest:
                                                            myState
                                                                .requestDetail,
                                                            opponentRequest:
                                                            state
                                                                .matchedRequest,
                                                          )));

                                              if(result){
                                                getTicketDetail();
                                              }

                                            },
                                            label: Text(
                                                'Đặt sân và giờ đá',
                                                style: MyButtonText()),
                                          ),
                                        )
                                            : Container(
                                          height: size.height * 0.05,
                                          width: size.width * 0.5,
                                          decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius:
                                            BorderRadius.circular(
                                                10.0),
                                          ),
                                          child: Center(
                                              child: Text(
                                                'Đang chờ đặt sân',
                                                style: MyButtonText(),
                                              )),
                                        )
                                            : SizedBox(),
                                      ],
                                    );
                                  } else {
                                    return Center(
                                      child: Text('Something wrong!!'),
                                    );
                                  }
                                }),
                          ])
                              : SizedBox(),
                          SizedBox(height: size.height * 0.02),
                          myState.requestDetail.status == 3
                              ? BlocBuilder<BookedFacilityByPostBloc,
                              BookedFacilityPostState>(
                              builder: (context, state) {
                                if (state is LoadingBookedFacilityByPost) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is LoadedBookedFacilityByPost) {
                                  return Column(
                                    children: [
                                      Text(
                                        'Địa Điểm Đá',
                                        style: HeadLine1(context),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(context,MaterialPageRoute(builder: (context)=> ViewFieldDetail(facilityId: state.bookedFacilityByPost.facilityId,)));
                                        },
                                        child: BookedFacilityByPostCard(
                                            bookedFacilityByPost:
                                            state.bookedFacilityByPost),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Center(
                                    child: Text('Something wrong!!'),
                                  );
                                }
                              })
                              : SizedBox(),
                        ],
                      );
                    } else {
                      return Text('Something went wrong');
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showDeletingOpponentRequest(){
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Xóa Yêu Cầu',
      desc: 'Bạn thật sự muốn xóa yêu cầu này chứ ?',
      buttonsTextStyle: const TextStyle(color: Colors.black),
      showCloseIcon: true,
      btnOkOnPress: () {
        BlocProvider.of<OpponentRequestBloc>(context)
            .add(DeleteOpponentRequest(requestId: widget.requestId));
      },
      btnCancelOnPress: (){
      },
    ).show();
  }
}
