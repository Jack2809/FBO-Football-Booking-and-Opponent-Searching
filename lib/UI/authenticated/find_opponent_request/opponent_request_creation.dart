import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/club_bloc/club_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/club_bloc/club_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/club_bloc/club_state.dart';
import 'package:football_booking_fbo_mobile/Blocs/district_bloc/district_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/district_bloc/district_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/district_bloc/district_state.dart';
import 'package:football_booking_fbo_mobile/Blocs/opponent_request_bloc/opponent_request_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/opponent_request_bloc/opponent_request_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_state.dart';
import 'package:football_booking_fbo_mobile/Models/district_model.dart';
import 'package:football_booking_fbo_mobile/Validator/opponentRequestCreation_validator.dart';
import 'package:football_booking_fbo_mobile/constants.dart';
import 'package:group_button/group_button.dart';
import 'package:interval_time_picker/interval_time_picker.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:intl/intl.dart';



class CreateOpponentRequestPage extends StatefulWidget{
  @override
  State<CreateOpponentRequestPage> createState() => _CreateOpponentRequestPageState();
}

class _CreateOpponentRequestPageState extends State<CreateOpponentRequestPage> with InputOpponentRequestValidation{

  @override
  void initState() {
    BlocProvider.of<DistrictBloc>(context).add(FetchDistricts());
    BlocProvider.of<ClubBloc>(context).add(FetchClubs());

    super.initState();
  }

  var _selectedDate = DateTime.now();

  TimeOfDay _freeTimeStart= TimeOfDay(hour: 0, minute: 0);

  TimeOfDay _freeTimeEnd= TimeOfDay(hour: 0, minute: 0);

  int _duration = 60 ;

  int? _clubId ;

  int? _teamId ;

  bool _is5vs5 = true ;

  List<int> _selectedDistrictIds = [];

  List<String> _selectedDistrictsStr = [];

  bool _isFirstLoadTeam = true;

  String? validFreeTimeStr ;

  String? validClubStr ;

  String? validTeamStr ;

  String? validDistrictStr;



  void _selectFreeTimeStart() async {
    final TimeOfDay? newTime = await showIntervalTimePicker(
      context: context,
      initialTime: _freeTimeStart,
      interval: 30,
      visibleStep: VisibleStep.thirtieths,
    );
    if (newTime != null) {
      setState(() {
        _freeTimeStart = newTime;
      });
    }
  }

  void _selectFreeTimeEnd() async {
    final TimeOfDay? newTime = await showIntervalTimePicker(
      context: context,
      initialTime: _freeTimeEnd,
      interval: 30,
      visibleStep: VisibleStep.thirtieths,
    );
    if (newTime != null) {
      setState(() {
        _freeTimeEnd = newTime;
      });
    }
  }

  void _dropdownCallBack(int? selectedDuration){
    if(selectedDuration is int){
      setState(() {
        _duration = selectedDuration;
      });
    }
  }

  void _clubDropdownCallBack(int? selectedClubId){
    if(selectedClubId is int){
      setState(() {
        _clubId = selectedClubId;
        _isFirstLoadTeam = false ;
        log("clubid:"+_clubId.toString());
      });
      BlocProvider.of<TeamBloc>(context).add(FetchTeams(clubId: _clubId!));
    }
  }

  void _teamDropdownCallBack(int? selectedTeamId){
    if(selectedTeamId is int){
      setState(() {
        _teamId = selectedTeamId;
        _isFirstLoadTeam = false;
        log("teamid:"+_teamId.toString());
      });

    }
  }


  @override
  Widget build(BuildContext context) {



    Size size = getSize(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        bottomOpacity: 0.0,
        shadowColor: Colors.grey.withOpacity(0.02),
        backgroundColor: Colors.transparent,
        title: Text('Tạo Yêu Cầu',style: HeadLine1()),
        centerTitle: true,
        actions: [

        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: Container(
        padding: MyPaddingAll(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Chọn ngày đá',style: HeadLine1(),),
              SizedBox(height: 10.0,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: SizedBox(
                  height: size.height * 0.15,
                  child: ScrollDatePicker(
                    minimumDate: DateTime.now(),
                    maximumDate: DateTime.now().add(Duration(days: 365)),
                    selectedDate: _selectedDate,
                    locale: Locale('en'),
                    onDateTimeChanged: (DateTime value) {
                      setState(() {
                        _selectedDate = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
              Text('Chọn Thời gian rảnh',style: HeadLine1(),),
              SizedBox(height: 10.0,),
              Row(
                children: [
                  Text('Từ ',style: TextLine1(true)),
                  GestureDetector(
                      onTap: (){
                        _selectFreeTimeStart();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10,right: 10),
                        width: size.width * 0.3,
                        height: size.height * 0.05,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black12),
                        ),
                          child: Center(child: Text(_freeTimeStart.format(context),style: TextLine(),)))),
                  Text('Đến ',style: TextLine1(true)),
                  GestureDetector(
                      onTap: (){
                        _selectFreeTimeEnd();
                      },
                      child: Container(
                          margin: EdgeInsets.only(left: 10,right: 10),
                          width: size.width * 0.3,
                          height: size.height * 0.05,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Center(child: Text(_freeTimeEnd.format(context),style: TextLine(),)))),

                ],
              ),
              Text(validFreeTimeStr == null || validFreeTimeStr == "" ? "":validFreeTimeStr!,style: ErrorText(),),
              SizedBox(height: 10.0,),
              Text('Thời lượng mong muốn đá ',style: HeadLine1()),
              SizedBox(height: 20.0,),
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
              SizedBox(height: 10.0,),
              Text('Loại sân mong muốn đá ',style: HeadLine1()),
              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: size.width * 0.41,
                    decoration: BoxDecoration(
                      color: _is5vs5 ? Colors.green : primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: TextButton.icon(
                        onPressed: (){
                          setState(() {
                            _is5vs5 = true;
                          });
                        },
                        icon: Icon(Icons.sports_soccer,color:_is5vs5?Colors.white:Colors.black,size: 20),
                        label: Text('5 vs 5',style: _is5vs5 ? MyButtonText() : TextLine1(true),)),
                  ),

                  Container(
                    width: size.width * 0.41,
                    decoration: BoxDecoration(
                      color: _is5vs5 ? primaryColor : Colors.green,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: TextButton.icon(
                        onPressed: (){
                          setState(() {
                            _is5vs5 = false ;
                          });
                        },
                        icon: Icon(Icons.sports_soccer,color:_is5vs5?Colors.black:Colors.white,size: 20,),
                        label: Text('7 vs 7',style: _is5vs5?TextLine1(true):MyButtonText(),)),
                  ),
                ],
              ),
              SizedBox(height: 10.0,),
              Text('Khu vực mong muốn đá',style: HeadLine1()),
              SizedBox(height: 10.0,),
              BlocBuilder<DistrictBloc,DistrictState>(
                  builder:(context,state){
                    if(state is LoadingDistricts){
                      return Center(child: CircularProgressIndicator(),);
                    }
                    else if(state is LoadedDistricts){
                      if(state.districtList.isEmpty){
                        return Center(child: Text('Không có quận nào'),);
                      }else{
                        return GestureDetector(
                          onTap: (){
                            _showAddingDistricts(state.districtList);
                          },
                            child: Container(
                              width: size.width * 0.95,
                              height: size.height * 0.05,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black12),
                              ),
                                child: _selectedDistrictsStr.isEmpty ? Center(child: Text('Chọn khu vực đá',style: TextLine1(true))): Center(child: Text(_selectedDistrictsStr.join(","),style: TextLine2())),
                            ));
                      }
                    }
                    else {
                      return Center(child: Text('Something wrong!!'),);
                    }
                  }
              ),
              Text(validDistrictStr == null || validDistrictStr == "" ? "":validDistrictStr!,style: ErrorText(),),

              SizedBox(height: 10.0,),
              Text('Chọn CLB',style: HeadLine1()),
              SizedBox(height: 10.0,),
              BlocBuilder<ClubBloc,ClubState>(
                  builder:(context,state){
                    if(state is LoadingClubs){
                      return Center(child: CircularProgressIndicator(),);
                    }
                    else if(state is LoadedClubs){
                      if(state.clubList.isEmpty){
                        return Center(child: Text('Vui lòng tạo CLB và đội hình trước'),);
                      }else{
                        return Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Center(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  isExpanded: true,
                                  value: _clubId,
                                  items: state.clubList
                                      .map((club) =>
                                      DropdownMenuItem<int>(
                                        value: club.id,
                                        child: Center(
                                          child: Text(
                                            club.name,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ))
                                      .toList(),
                                onChanged: _clubDropdownCallBack,
                                  ),
                            ),
                          ),
                        );
                      }
                    }
                    else {
                      return Center(child: Text('Something wrong!!'),);
                    }
                  }
              ),
              Text(validClubStr == null || validClubStr == "" ? "":validClubStr!,style: ErrorText(),),
              SizedBox(height: 10.0,),
              BlocBuilder<TeamBloc,TeamState>(
                  builder:(context,state){
                    if(state is LoadingTeams){
                     return  _isFirstLoadTeam ?  SizedBox() : Center(child: CircularProgressIndicator(),);
                    }
                    else if(state is LoadedTeams){
                      if(state.teamList.isEmpty){
                        return Center(child: Text('không có đội hình nào trong CLB này'),);
                      }else{
                        return _isFirstLoadTeam?SizedBox():Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.0,),
                            Text('Chọn đội hình',style: HeadLine1()),
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
                                    value:  _teamId ,
                                    items: state.teamList
                                        .map((team) =>
                                        DropdownMenuItem<int>(
                                          value: team.id,
                                          child: Center(
                                            child: Text(
                                              team.name,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ))
                                        .toList(),
                                    onChanged: _teamDropdownCallBack,
                                  ),
                                ),
                              ),
                            ),
                            Text(validTeamStr == null || validTeamStr == "" ? "":validTeamStr!,style: ErrorText(),),
                          ],
                        );
                      }
                    }
                    else {
                      return Center(child: Text('Something wrong!!'),);
                    }
                  }
              ) ,
              // Text(validTeamStr == null || validTeamStr == "" ? "":validTeamStr!,style: ErrorText(),),

              Container(
                color: Colors.green,
                child: TextButton.icon(
                  onPressed: () {

                    // DateTime bookingDate1 = _selectedDate;
                    // DateTime freetimeStart1 = DateTime(_selectedDate.year,_selectedDate.month,_selectedDate.day,_freeTimeStart.hour,_freeTimeStart.minute,0);
                    // DateTime freetimeEnd1 = DateTime(_selectedDate.year,_selectedDate.month,_selectedDate.day,_freeTimeEnd.hour,_freeTimeEnd.minute,0);

                    if(isValidFreeTimeValid(_freeTimeStart,_freeTimeEnd,_duration)!="" || isSelectedClub(_clubId)!="" || isSelectedTeam(_teamId)!="" || isSelectedDistrict(_selectedDistrictIds)!=""){
                      setState(() {
                        validFreeTimeStr = isValidFreeTimeValid(_freeTimeStart,_freeTimeEnd,_duration);
                        validClubStr = isSelectedClub(_clubId);
                        validTeamStr = isSelectedTeam(_teamId);
                        validDistrictStr = isSelectedDistrict(_selectedDistrictIds);
                      });
                    }else{
                      setState(() {
                        validFreeTimeStr = isValidFreeTimeValid(_freeTimeStart,_freeTimeEnd,_duration);
                        validClubStr = isSelectedClub(_clubId);
                        validTeamStr = isSelectedTeam(_teamId);
                        validDistrictStr = isSelectedDistrict(_selectedDistrictIds);
                      });
                      String bookingDate = _selectedDate.toString();
                      String freetimeStart = _freeTimeStart.format(context)+":00";
                      String freetimeEnd = _freeTimeEnd.format(context)+":00";
                      int duration = _duration;
                      int teamId = _teamId!;
                      int fieldTypeId = _is5vs5 ? 1 : 2;
                      List<int> districtIdList = _selectedDistrictIds;
                      // log("booking date: "+_selectedDate.toString());
                      // log("freetime start: "+_f.toString());
                      // log("freetime end: "+freetimeEnd.toString());
                      // log("duration: "+duration.toString());
                      // log("teamid: "+teamId.toString());
                      // log("fieldtype: "+fieldTypeId.toString());
                      // log("district: "+districtIdList.join(","));
                      BlocProvider.of<OpponentRequestBloc>(context).add(
                          CreateOpponentRequest(districtIdList: districtIdList, bookingDate: bookingDate, duration: duration, freetimeStart: freetimeStart, freetimeEnd: freetimeEnd, fieldTypeId: fieldTypeId, teamId: teamId));
                      setState(() {
                        _isFirstLoadTeam = true;
                      });
                      Navigator.pop(context);
                    }

                  },
                  icon: Icon(Icons.add,color:Colors.black),
                  label: Text('Tạo Yêu Cầu',style: TextLine2()),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<void > _showAddingDistricts(List<District> districtList) async {
    List<int> districtIdList = [];
    List<String> districtStrList = [];
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        Size size = getSize(context);
        return AlertDialog(
          title: const Text('Chọn khu vực đá'),
          content: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GroupButton<District>(
                    maxSelected: 5,
                    buttonBuilder: (selected, district, context) {
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
                            '${district.id}-${district.name}',
                          ),
                        ),
                      );
                    },
                    options: GroupButtonOptions(
                      buttonWidth: size.width * 0.7,
                      borderRadius: BorderRadius.circular(10.0),
                      selectedColor: Colors.green,
                    ),
                    onSelected: (district, index, isSelected) {
                      if(isSelected){
                        districtIdList.add(district.id);
                        districtStrList.add(district.name);
                        log(districtIdList.toString());
                        log(districtStrList.toString());
                      }else{
                        districtIdList.remove(district.id);
                        districtStrList.remove(district.name);
                        log(districtIdList.toString());
                        log(districtStrList.toString());
                      }
                    },
                    isRadio: false,
                    buttons: districtList,
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
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  _selectedDistrictIds = districtIdList;
                  _selectedDistrictsStr = districtStrList;
                });

                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Hủy bỏ'),
              onPressed: () {
                districtIdList.clear();
                districtStrList.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}