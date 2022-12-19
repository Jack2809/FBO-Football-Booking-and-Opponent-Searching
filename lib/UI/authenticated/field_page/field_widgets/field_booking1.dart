import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/time_slot_booking_facitily_post_bloc/time_slot_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/time_slot_booking_facitily_post_bloc/time_slot_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/time_slot_booking_facitily_post_bloc/time_slot_state.dart';
import 'package:football_booking_fbo_mobile/Models/field_model.dart';
import 'package:football_booking_fbo_mobile/Models/time_slot_model.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/field_page/field_widgets/reservation_payment.dart';
import 'package:football_booking_fbo_mobile/constants.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';


class PickingBookingTimePage extends StatefulWidget{
  Field field;
  String bookingDate;
  String fieldTypeName;

  PickingBookingTimePage({required this.field,required this.bookingDate,required this.fieldTypeName});

  @override
  State<PickingBookingTimePage> createState() => _PickingBookingTimePageState();
}

class _PickingBookingTimePageState extends State<PickingBookingTimePage> {

  @override
  void initState() {
    int fieldTypeId = widget.fieldTypeName == "5vs5"? 1 : 2 ;
    String bookingDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(widget.bookingDate));
    BlocProvider.of<TimeSlotBloc>(context).add(
        FetchTimeSlot(facilityId:widget.field.id,bookingDate: bookingDate,fieldTypeId:fieldTypeId));
    super.initState();
  }

  void _dropdownCallBack(int? selectedDuration){
    if(selectedDuration is int){
      setState(() {
        _duration = selectedDuration;
      });
    }
  }

  int _duration = 60;

  List<String> _timeSlotStr = [];

  String _bookingTime = '';

  bool? _isChosenBookingTime ;


  List<String> getTimeSlotStr(List<TimeSlot> timeslotList,String bookingDate,int duration){
    DateTime bookingDateTime = DateTime.parse(bookingDate);
    DateTime now = DateTime.now();
    DateFormat format = DateFormat('yyyy-MM-dd');
    List<String> tempList = [];
    if(format.format(bookingDateTime).compareTo(format.format(now)) == 0){
      TimeOfDay currentTime = TimeOfDay.fromDateTime(now.add(Duration(minutes: 5)));
      // TimeOfDay currentTime = TimeOfDay(hour: 10,minute: 35);
      int temp = currentTime.minute;
      if(temp == 0){
        currentTime = currentTime.replacing(hour: currentTime.hour,minute: 0);
      } else if(temp < 15){
        currentTime = currentTime.replacing(hour: currentTime.hour,minute: 15);
      }else if(temp <30){
        currentTime = currentTime.replacing(hour: currentTime.hour,minute: 30);
      }else if(temp <45){
        currentTime = currentTime.replacing(hour: currentTime.hour,minute: 45);
      }else{
        currentTime = currentTime.replacing(hour: currentTime.hour + 1,minute: 0);
      }
      log(currentTime.format(context));
      DateTime startTime ;
      DateTime endTime ;
      DateTime currentDateTime ;
      Duration step = Duration(minutes: duration);
      int startTimeHourInt;
      int startTimeMinutesInt;
      int endTimeHourInt;
      int endTimeMinutesInt;
      int currentHourInt;
      int currentMinutesInt;
      for (var timeSlot in timeslotList){
        startTimeHourInt = int.parse(timeSlot.startTime.split(":")[0]);
        startTimeMinutesInt = int.parse(timeSlot.startTime.split(":")[1]);
        endTimeHourInt = int.parse(timeSlot.endTime.split(":")[0]);
        endTimeMinutesInt = int.parse(timeSlot.endTime.split(":")[1]);
        currentHourInt = int.parse(currentTime.format(context).split(":")[0]);
        currentMinutesInt = int.parse(currentTime.format(context).split(":")[1]);
        startTime = DateTime(bookingDateTime.year,bookingDateTime.month,bookingDateTime.day,startTimeHourInt,startTimeMinutesInt);
        endTime = DateTime(bookingDateTime.year,bookingDateTime.month,bookingDateTime.day,endTimeHourInt,endTimeMinutesInt);
        currentDateTime = DateTime(bookingDateTime.year,bookingDateTime.month,bookingDateTime.day,currentHourInt,currentMinutesInt);
        if((currentDateTime.isAfter(startTime) || currentDateTime.isAtSameMomentAs(startTime)) && (currentDateTime.add(step).isBefore(endTime)||currentDateTime.add(step).isAtSameMomentAs(endTime))){
          while(currentDateTime.isBefore(endTime) && (currentDateTime.add(step).isBefore(endTime)||currentDateTime.add(step).isAtSameMomentAs(endTime))) {
            tempList.add(DateFormat.Hm().format(currentDateTime));
            DateTime timeIncrement = currentDateTime.add(step);
            currentDateTime = timeIncrement;
          }
        }else{
          // if(startTime.isAfter(currentDateTime)&&(startTime.isBefore(endTime) && startTime.add(step).isBefore(endTime))){
          //   tempList.add(DateFormat.Hm().format(startTime));
          // }
          while(startTime.isAfter(currentDateTime)&&(startTime.isBefore(endTime) && (startTime.add(step).isBefore(endTime)||startTime.add(step).isAtSameMomentAs(endTime)))) {
            tempList.add(DateFormat.Hm().format(startTime));
            DateTime timeIncrement = startTime.add(step);
            startTime = timeIncrement;
          }
        }
      }

    }else {
      DateTime startTime ;
      DateTime endTime ;
      Duration step = Duration(minutes: duration);
      int startTimeHourInt;
      int startTimeMinutesInt;
      int endTimeHourInt;
      int endTimeMinutesInt;

      for(var timeSlot in timeslotList){
        startTimeHourInt = int.parse(timeSlot.startTime.split(":")[0]);
        startTimeMinutesInt = int.parse(timeSlot.startTime.split(":")[1]);
        endTimeHourInt = int.parse(timeSlot.endTime.split(":")[0]);
        endTimeMinutesInt = int.parse(timeSlot.endTime.split(":")[1]);
        startTime = DateTime(bookingDateTime.year,bookingDateTime.month,bookingDateTime.day,startTimeHourInt,startTimeMinutesInt);
        endTime = DateTime(bookingDateTime.year,bookingDateTime.month,bookingDateTime.day,endTimeHourInt,endTimeMinutesInt);

        // if(startTime.isBefore(endTime) && startTime.add(step).isBefore(endTime)){
        //   tempList.add(DateFormat.Hm().format(startTime));
        // }
        while(startTime.isBefore(endTime) && startTime.add(step).isBefore(endTime) || startTime.add(step).isAtSameMomentAs(endTime)) {
          tempList.add(DateFormat.Hm().format(startTime));
          DateTime timeIncrement = startTime.add(step);
          startTime = timeIncrement;
        }

        // if(timeslotList.length > 1){
        //   tempList.removeLast();
        // }

      }
    }

    return tempList;
  }



  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Chọn giờ đá và đặt sân'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: MyPaddingAll(),
        decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/gradient_background.png'),
          fit: BoxFit.fill,
        )
        ),
        child: SafeArea(
          child: Container(
            height: size.height ,
            padding: MyPaddingAll(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white.withOpacity(0.7),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Thời lượng',style: HeadLine1(context)),
                  SizedBox(height: size.height * 0.02,),
                  Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Center(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            isExpanded: true,
                            value: _duration,
                            items:[
                              DropdownMenuItem(child: Center(child: Text('1 tiếng',textAlign:TextAlign.center)),value: 60),
                              DropdownMenuItem(child: Center(child: Text('1 tiếng 30 phút',textAlign:TextAlign.center)),value: 90),
                              DropdownMenuItem(child: Center(child: Text('2 tiếng',textAlign:TextAlign.center)),value: 120),
                            ] ,
                            onChanged:_dropdownCallBack),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02,),
                  Text('Thời gian trống của sân',style: HeadLine1(context)),
                  SizedBox(height: size.height * 0.02,),
                  BlocBuilder<TimeSlotBloc, TimeSlotState>(
                      builder: (context, state) {
                        if (state is LoadingTimeSlot) {
                          return  Center( child: CircularProgressIndicator(),);
                        }
                        else if (state is LoadedTimeSlot) {
                          if (state.timeSlotList.isEmpty) {
                            return Center(
                              child: Text('Đã hết sân hoặc sân chưa có khung giá vào thời gian này, vui lòng liên hệ chủ sân'),);
                          } else {
                            _timeSlotStr = getTimeSlotStr(state.timeSlotList, widget.bookingDate, _duration);
                            return _timeSlotStr.isNotEmpty?Column(
                              children: [
                                GridView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 15.0,
                                          crossAxisSpacing: 15.0,
                                          childAspectRatio: 1 / 0.15,
                                        ),
                                        itemCount: _timeSlotStr.length,
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
                                            child: Center(child: Text(_timeSlotStr[index],style: WhiteTitleText(),)),
                                          );
                                        }
                                    ),

                                SizedBox(height: size.height * 0.02,),
                                Center(
                                  child: GestureDetector(
                                      onTap: () {
                                        _showChoosingTime(_timeSlotStr);
                                      },
                                      child: Container(
                                        width: size.width * 0.95,
                                        height: size.height * 0.05,
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.black12),
                                        ),
                                        child: _bookingTime == ""
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
                                            Text(_bookingTime, style: TextLine1(context,false)),
                                          ],
                                        )),
                                      )),
                                ),

                                SizedBox(height: size.height * 0.02,),

                                SizedBox(
                                  width: size.width * 0.9,
                                  child: TextButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.resolveWith((states) {
                                        if(states.contains(MaterialState.pressed)){
                                          return Colors.redAccent;
                                        }
                                        return Colors.green;
                                      }
                                      ),
                                    ),
                                    child: Text("Tiếp tục",style: MyButtonText()),
                                    onPressed: (){
                                      if(_bookingTime.isEmpty){
                                        _showBookingTimeAlert();
                                      }else{

                                        DateTime startTime = DateTime(
                                            int.parse(widget.bookingDate.split('-')[0]), int.parse(widget.bookingDate.split('-')[1]), int.parse(widget.bookingDate.split('-')[2]),
                                            int.parse(_bookingTime.split(':')[0]),int.parse(_bookingTime.split(':')[1]));
                                        final f = new DateFormat('yyyy-MM-dd HH:mm:ss');
                                        String startTimeStr = f.format(startTime);
                                        int fieldTypeId = widget.fieldTypeName == "5vs5"? 1 : 2 ;
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context)=> ReservationPayment(field: widget.field,bookingTime: startTimeStr,duration:_duration,fieldTypeId: fieldTypeId,)));
                                      }
                                    },
                                  ),
                                ),

                              ],
                            ):Center(
                              child: Text('Hiện tại tất cả sân đã được đặt hoặc sân đang ngoài giờ hoạt động'),);

                          }
                        }
                        else {
                          return Center(child: Text('Something wrong!!'),);
                        }
                      }
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showBookingTimeAlert(){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Giờ Đá',
      desc: "Bạn vui lòng chọn giờ đá để tiếp tục",
      buttonsTextStyle: const TextStyle(color: Colors.black),
      showCloseIcon: true,
      btnOkOnPress: () {

      },
    ).show();
  }

  Future<void > _showChoosingTime(List<String> timeList) async {
    String tempTime = '';
    String error = '';
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        Size size = getSize(context);
        return AlertDialog(
          title: const Text('Chọn giờ đá'),
          content: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 5.0,),
                  GroupButton<String>(
                    maxSelected: 1,
                    buttonBuilder: (selected, time, context) {
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
                            '${time}',
                          ),
                        ),
                      );
                    },
                    options: GroupButtonOptions(
                      buttonWidth: size.width * 0.7,
                      borderRadius: BorderRadius.circular(10.0),
                      selectedColor: Colors.green,
                    ),
                    onSelected: (time, index, isSelected) {
                      if(isSelected){
                        tempTime = time;
                      }else{
                        tempTime = '';
                      }
                    },
                    isRadio: false,
                    buttons: timeList,
                  )

                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Hủy bỏ'),
              onPressed: () {
                setState(() {
                  tempTime = '';
                });
                Navigator.of(context).pop();
              },
            ),

            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                if(tempTime.isEmpty){
                  setState(() {

                  });
                }
                else{
                  setState(() {
                    _bookingTime = tempTime;
                  });

                  Navigator.pop(context);
                }

              },
            ),

          ],
        );
      },
    );
  }

}