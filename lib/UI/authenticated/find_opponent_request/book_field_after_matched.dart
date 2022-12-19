import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/facility_with_matched_post_bloc/facility_with_matched_post_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/facility_with_matched_post_bloc/facility_with_matched_post_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/facility_with_matched_post_bloc/facility_with_matched_post_state.dart';
import 'package:football_booking_fbo_mobile/Blocs/time_slot_booking_facitily_post_bloc/time_slot_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/time_slot_booking_facitily_post_bloc/time_slot_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/time_slot_booking_facitily_post_bloc/time_slot_state.dart';
import 'package:football_booking_fbo_mobile/Models/field_model.dart';
import 'package:football_booking_fbo_mobile/Models/opponent_request_model.dart';
import 'package:football_booking_fbo_mobile/Models/time_slot_model.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/find_opponent_request/book_facility_by_zalo_pay.dart';
import 'package:football_booking_fbo_mobile/constants.dart';
import 'package:group_button/group_button.dart';
import 'package:interval_time_picker/interval_time_picker.dart';
import 'package:intl/intl.dart';

class BookingFieldAfterMatchedPage extends StatefulWidget{
  OpponentRequestDetailModel myRequest ;
  MatchedRequest opponentRequest;

  BookingFieldAfterMatchedPage({required this.myRequest,required this.opponentRequest});

  @override
  State<BookingFieldAfterMatchedPage> createState() => _BookingFieldAfterMatchedPageState();
}

class _BookingFieldAfterMatchedPageState extends State<BookingFieldAfterMatchedPage> {

  @override
  void initState() {
    log(widget.myRequest.id.toString());
    log(widget.opponentRequest.id.toString());
    log(widget.myRequest.duration.toString());
    log(widget.myRequest.fieldTypeId.toString());
    log(widget.myRequest.bookingDate.toString());
    BlocProvider.of<FacilityWithMatchedPostBloc>(context).add(
        FetchFacilityWithMatchedPost(
            myRequestId: widget.myRequest.id,
            opponentRequestId: widget.opponentRequest.id,
            duration: widget.myRequest.duration / 60,
            fieldTypeId: widget.myRequest.fieldTypeId,
            startDate: widget.myRequest.bookingDate
        ));
    super.initState();
  }

  Facility? _facility = null;

  TimeOfDay? _timeStart = null;

  bool _isValidTimeStart = true;

  bool _isFirstLoadTimeSlot = true;

  bool? _isChosenFacility ;

  bool _isAppropriateStartTime = false;

  bool _isFirstClickedConfirm = true;

  void _selectTimeStart(TimeOfDay timeStart, TimeOfDay timeEnd,
      int duration,List<TimeSlot> timeslots) async {
    final TimeOfDay? newTime = await showIntervalTimePicker(
      context: context,
      initialTime: timeStart,
      interval: 15,
      visibleStep: VisibleStep.fifteenths,
    );
    if (newTime != null) {
      int endTimeMinutes = ((timeEnd.hour * 60) + timeEnd.minute) - duration;
      int chosenTimeMinutes = (newTime.hour * 60) + newTime.minute;
      int startTimeMinutes = (timeStart.hour * 60) + timeStart.minute;


      if (endTimeMinutes >= chosenTimeMinutes &&
          chosenTimeMinutes >= startTimeMinutes) {
        setState(() {
          _timeStart = newTime;
          _isValidTimeStart = true;
        });
      }
      else {
        setState(() {
          _timeStart = null;
          _isValidTimeStart = false;
        });
      }
    }
  }


  String calculateEndTime(String endTime, int duration) {
    int endTimeMinutes = int.parse(endTime.split(':')[0]) * 60 +
        int.parse(endTime.split(':')[1]);
    int finalEndTimeMinutes = endTimeMinutes - duration;
    Duration _duration = Duration(minutes: finalEndTimeMinutes);
    List<String> parts = _duration.toString().split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]))
        .format(context);
  }


  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        bottomOpacity: 0.0,
        shadowColor: Colors.grey.withOpacity(0.02),
        backgroundColor: Colors.green,
        title: Text('Chọn sân và giờ đá', style: WhiteTitleText()),
        centerTitle: true,
        actions: [
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<
            FacilityWithMatchedPostBloc,
            FacilityWithMatchedPostState>(
            builder: (context, facilityState) {
              if (facilityState is LoadingFacilityWithMatchedPost) {
                return Center(
                  child:
                  CircularProgressIndicator(),
                );
              } else if (facilityState is LoadedFacilityWithMatchedPost) {
                if (facilityState.facilityData.facilityList.isEmpty) {
                  return Center(child: Text('Không có sân'));
                }
                else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30.0,
                      ),
                      Text('Chọn sân', style: HeadLine1(context),),
                      SizedBox(height: 10.0,),
                      Center(
                        child: GestureDetector(
                            onTap: () {
                              _showChoosingFacility(
                                  facilityState.facilityData.facilityList);
                            },
                            child: Container(
                              width: size.width * 0.95,
                              height: size.height * 0.08,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black12),
                              ),
                              child: _facility == null
                                  ? Center(child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      'Ấn để chọn sân',
                                      style: Black26TextLine(context,false)),
                                ],
                              ))
                                  : Center(child: Column(
                                    children: [
                                      Column(
                                children: [
                                      Text("Sân đã chọn: ",
                                          style: Black26TextLine(context,false)),
                                      Text(_facility!.name + " - " +
                                          _facility!.districtName,
                                          style: TextLine1(context,false)),
                                ],
                              ),
                                    ],
                                  )),
                            )),
                      ),
                      _isChosenFacility == false ? Center(child: Text(
                        'Vui lòng chọn sân', style: TextStyle(color: Colors
                          .red),)) : SizedBox(),
                      SizedBox(height: 20.0,),
                      _isChosenFacility == true ? BlocBuilder<
                          TimeSlotBloc,
                          TimeSlotState>(
                          builder: (context, state) {
                            if (state is LoadingTimeSlot) {
                              return _isFirstLoadTimeSlot ? SizedBox() : Center(
                                child: CircularProgressIndicator(),);
                            }
                            else if (state is LoadedTimeSlot) {
                              if (state.timeSlotList.isEmpty) {
                                return Center(
                                  child: Text('Không còn thời gian trống'),);
                              } else {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Thời gian trống có thể đặt sân',
                                        style: HeadLine1(context)),
                                    SizedBox(height: 10.0,),
                                    GridView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 15.0,
                                          crossAxisSpacing: 15.0,
                                          childAspectRatio: 1 / 0.15,
                                        ),
                                        itemCount: state.timeSlotList.length,
                                        itemBuilder: (BuildContext context,
                                            int index) {
                                          return Container(
                                            height: 20.0,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(10.0),
                                              border: Border.all(
                                                  color: Colors.black12),
                                              color: Colors.green,
                                            ),
                                            child: Center(child: Text(
                                              convertDateTimeToTimeOfDay(
                                                  context,
                                                  state.timeSlotList[index]
                                                      .startTime) + " - " +
                                                  convertDateTimeToTimeOfDay(
                                                      context,
                                                      state.timeSlotList[index]
                                                          .endTime),
                                              style: WhiteTitleText(),)),
                                          );
                                        }

                                    ),

                                    SizedBox(height: 20.0,),
                                    Text('Chọn giờ đá', style: HeadLine1(context),),
                                    SizedBox(height: 10.0,),
                                    Center(
                                      child: GestureDetector(
                                          onTap: () {
                                            String startTimeStr = facilityState.facilityData
                                                .matchedTimeStart;
                                            String endTimeStr = facilityState.facilityData
                                                .matchedTimeEnd;
                                            TimeOfDay startTime = TimeOfDay(
                                                hour: int.parse(startTimeStr.split(':')[0]),
                                                minute: int.parse(
                                                    startTimeStr.split(':')[1]));
                                            TimeOfDay endTime = TimeOfDay(
                                                hour: int.parse(endTimeStr.split(':')[0]),
                                                minute: int.parse(endTimeStr.split(':')[1]));
                                            _selectTimeStart(startTime, endTime,
                                                widget.myRequest.duration,state.timeSlotList);
                                          },
                                          child: Container(
                                            width: size.width * 0.95,
                                            height: size.height * 0.05,
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(color: Colors.black12),
                                            ),
                                            child: _timeStart == null
                                                ? Center(child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    'Ấn chọn giờ đá',
                                                    style: Black26TextLine(context,false)),
                                              ],
                                            ))
                                                : Center(child: Row(
                                              children: [
                                                Text("Giờ đã chọn: ",
                                                    style: Black26TextLine(context,false)),
                                                Spacer(),
                                                Text(_timeStart!.format(context),
                                                    style: TextLine1(context,false)),
                                              ],
                                            )),
                                          )),
                                    ),
                                    _isValidTimeStart ? SizedBox() : (timeFormat(
                                        facilityState.facilityData.matchedTimeStart) == timeFormat(
                                        calculateEndTime(facilityState.facilityData.matchedTimeEnd,
                                            widget.myRequest.duration))) ? Center(
                                      child: Text('Thời gian đặt phải là ' + timeFormat(facilityState
                                          .facilityData.matchedTimeStart), style: TextStyle(
                                          color: Colors.red)),) : Center(child: Text(
                                      'Thời gian đá phải trong khoảng ' + timeFormat(
                                        facilityState.facilityData.matchedTimeStart,) + '-' +
                                          timeFormat(calculateEndTime(
                                              facilityState.facilityData.matchedTimeEnd,
                                              widget.myRequest.duration)), style: TextStyle(
                                        color: Colors.red),)),


                                    SizedBox(height: 20.0,),
                                    _isFirstClickedConfirm?SizedBox():!_isAppropriateStartTime ? Text('Giờ đá chưa phù hợp với giờ trống của sân',style: ErrorText(),textAlign: TextAlign.center,):SizedBox(),
                                    Container(
                                      width: size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: TextButton.icon(
                                        icon: Icon(Icons.calendar_today, color: Colors
                                            .white,),
                                        onPressed: () {
                                          if (_facility == null || _timeStart == null) {
                                            if (_facility == null) {
                                              setState(() {
                                                _isChosenFacility = false;
                                              });
                                            }
                                            if (_timeStart == null) {
                                              setState(() {
                                                _isValidTimeStart = false;
                                              });
                                            }
                                          } else {
                                            int timeStartMinutes = _timeStart!.hour * 60 +_timeStart!.minute;
                                            String availableStartTime ;
                                            String availableEndTime;
                                            int availableStartTimeMinutes;
                                            int availableEndTimeMinutes;
                                            for(int i = 0;i < state.timeSlotList.length;i++){
                                              // availableStartTime =TimeOfDay.fromDateTime(DateTime.parse(state.timeSlotList[i].startTime)).format(context);
                                              // availableEndTime =TimeOfDay.fromDateTime(DateTime.parse(state.timeSlotList[i].endTime)).format(context);
                                              availableStartTimeMinutes = int.parse(state.timeSlotList[i].startTime.split(":")[0])* 60 + int.parse(state.timeSlotList[i].startTime.split(":")[1]);
                                              availableEndTimeMinutes = int.parse(state.timeSlotList[i].endTime.split(":")[0])* 60 + int.parse(state.timeSlotList[i].endTime.split(":")[1]);
                                              if(timeStartMinutes >= availableStartTimeMinutes && timeStartMinutes <= availableEndTimeMinutes - widget.myRequest.duration){
                                                setState(() {
                                                  _isAppropriateStartTime = true;
                                                });
                                              }
                                            }
                                            setState(() {
                                              _isFirstClickedConfirm = false ;
                                            });
                                            DateTime temp = DateTime.parse(
                                                widget.myRequest.bookingDate);
                                            DateTime startTime = DateTime(
                                                temp.year, temp.month, temp.day,
                                                _timeStart!.hour, _timeStart!.minute);
                                            final f = new DateFormat('yyyy-MM-dd HH:mm:ss');
                                            String startTimeStr = f.format(startTime);
                                            if(_isAppropriateStartTime){
                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (context) =>
                                                      ZaloPaymentScreen(
                                                          facilityId: _facility!.id,
                                                          startTime: startTimeStr,
                                                          myRequest: widget.myRequest)));
                                            }
                                          }
                                        },
                                        label: Text('Xác nhận', style: MyButtonText()),
                                      ),
                                    ),

                                  ],
                                );
                              }
                            }
                            else {
                              return Center(child: Text('Something wrong!!'),);
                            }
                          }
                      ) : SizedBox(),


                    ],
                  );
                }
              } else {
                return Center(
                  child: Text('Something wrong!!'),
                );
              }
            }
        ),
      ),
    );
  }

  Future<void> _showChoosingFacility(List<Facility> facilities) async {
    Facility? facilityTemp;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        Size size = getSize(context);
        return AlertDialog(
          title: const Text('Chọn sân'),
          content: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GroupButton<Facility>(
                    maxSelected: 1,
                    buttonBuilder: (selected, facilities, context) {
                      return Container(
                        width: size.width * 0.7,
                        height: size.height * 0.05,
                        decoration: BoxDecoration(
                          color: selected ? Colors.green : Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Center(
                          child: Text(
                            '${facilities.name}-${facilities.districtName}',
                          ),
                        ),
                      );
                    },
                    options: GroupButtonOptions(
                      buttonWidth: size.width * 0.7,
                      borderRadius: BorderRadius.circular(10.0),
                      selectedColor: Colors.green,
                    ),
                    onSelected: (facility, index, isSelected) {
                      if (isSelected) {
                        facilityTemp = facility;
                      } else {
                        facilityTemp = null;
                      }
                    },
                    isRadio: false,
                    buttons: facilities,
                  )

                ],
              ),
            ),
          ),
          actions: <Widget>[

            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme
                    .of(context)
                    .textTheme
                    .labelLarge,
              ),
              child: const Text('Hủy bỏ'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme
                    .of(context)
                    .textTheme
                    .labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  _facility = facilityTemp;
                  log(_facility!.id.toString());
                  _isFirstLoadTimeSlot = false;
                  _isChosenFacility = true;
                });
                String bookingDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(widget.myRequest.bookingDate));
                BlocProvider.of<TimeSlotBloc>(context).add(FetchTimeSlot(
                    facilityId: _facility!.id,
                    bookingDate: bookingDate,
                    fieldTypeId: widget.myRequest.fieldTypeId));

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

}

