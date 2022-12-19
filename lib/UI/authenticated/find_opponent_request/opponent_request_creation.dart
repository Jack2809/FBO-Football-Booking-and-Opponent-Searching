import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/district_bloc/district_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/district_bloc/district_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/district_bloc/district_state.dart';
import 'package:football_booking_fbo_mobile/Blocs/opponent_request_bloc/opponent_request_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/opponent_request_bloc/opponent_request_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_state.dart';
import 'package:football_booking_fbo_mobile/Models/district_model.dart';
import 'package:football_booking_fbo_mobile/Models/team_model.dart';
import 'package:football_booking_fbo_mobile/Validator/opponentRequestCreation_validator.dart';
import 'package:football_booking_fbo_mobile/constants.dart';
import 'package:group_button/group_button.dart';
import 'package:interval_time_picker/interval_time_picker.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';




class CreateOpponentRequestPage extends StatefulWidget{
  @override
  State<CreateOpponentRequestPage> createState() => _CreateOpponentRequestPageState();
}

class _CreateOpponentRequestPageState extends State<CreateOpponentRequestPage> with InputOpponentRequestValidation{

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    BlocProvider.of<DistrictBloc>(context).add(FetchDistricts());
    BlocProvider.of<TeamBloc>(context).add(FetchTeams());
    super.initState();
    BlocProvider.of<OpponentRequestBloc>(context).listenerStream.listen((event) {
      if(event ==""){

      } else if(event == "tạo yêu cầu thành công"){
          successfulDialog1Pop(context, event);
        }else if(event == "tạo yêu cầu thất bại"){
          failDialog(context, event);
        }else{
          errorDialog(context, event);
        }

    });

  }

  var _selectedDate = DateTime.now();

  TimeOfDay _freeTimeStart = TimeOfDay(hour: 0, minute: 0);

  TimeOfDay _freeTimeEnd = TimeOfDay(hour: 0, minute: 0);



  int _duration = 60 ;

  Team? team;

  int? _teamId ;

  int? _teamQuantity;

  bool _is5vs5 = true ;

  bool _isRivalry = false;

  List<int> _selectedDistrictIds = [];

  List<String> _selectedDistrictsStr = [];

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



  void _teamDropdownCallBack(Team? selectedTeam){
    if(selectedTeam is Team){
      setState(() {
        team = selectedTeam;
        _teamId = selectedTeam.id;
        _teamQuantity = selectedTeam.numberOfPlayers;
      }
      );
      log('teamId:'+ _teamId.toString());
      log('teamQuantity:'+ _teamQuantity.toString());


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
        backgroundColor: Colors.green,
        title: Text('Tạo Yêu Cầu',style: WhiteTitleText()),
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
      body: Container(
        padding: MyPaddingAll10(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Ngày đá',style: HeadLine1(context),),
              SizedBox(height: 10.0,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                      spreadRadius: 5.0,
                    )
                  ]
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
              Text('Thời gian rảnh',style: HeadLine1(context),),
              SizedBox(height: 10.0,),
              Row(
                children: [
                  Text('Từ ',style: TextLine1(context,true)),
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
                          child: Center(child: Text(_freeTimeStart.format(context),style: TextLine(context),)))),
                  Text('Đến ',style: TextLine1(context,true)),
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
                          child: Center(child: Text(_freeTimeEnd.format(context),style: TextLine(context),)))),

                ],
              ),
              Text(validFreeTimeStr == null || validFreeTimeStr == "" ? "":validFreeTimeStr!,style: ErrorText(),),
              SizedBox(height: 10.0,),
              Text('Thời lượng',style: HeadLine1(context)),
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
              Text('Loại sân',style: HeadLine1(context)),
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
                        label: Text('5 vs 5',style: _is5vs5 ? MyButtonText() : TextLine1(context,true),)),
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
                        label: Text('7 vs 7',style: _is5vs5?TextLine1(context,true):MyButtonText(),)),
                  ),
                ],
              ),
              Text('Thể thức thi đấu',style: HeadLine1(context)),
              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: size.width * 0.41,
                    decoration: BoxDecoration(
                      color: !_isRivalry ? Colors.green : primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: TextButton.icon(
                        onPressed: (){
                          setState(() {
                            _isRivalry = false;
                          });
                        },
                        icon: Icon(Icons.sports_soccer,color:!_isRivalry?Colors.white:Colors.black,size: 20),
                        label: Text('Giao hữu',style: !_isRivalry ? MyButtonText() : MyButtonText1(),)),
                  ),

                  Container(
                    width: size.width * 0.41,
                    decoration: BoxDecoration(
                      color: _isRivalry ? Colors.green : primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: TextButton.icon(
                        onPressed: (){
                          setState(() {
                            _isRivalry = true ;
                          });
                        },
                        icon: Icon(Icons.sports_soccer,color:!_isRivalry?Colors.black:Colors.white,size: 20,),
                        label: Text('Tranh tài',style: !_isRivalry?MyButtonText1():MyButtonText(),)),
                  ),
                ],
              ),
              SizedBox(height: 10.0,),
              Text('Khu vực',style: HeadLine1(context)),
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
                                child: _selectedDistrictsStr.isEmpty ? Center(child: Text('Chọn khu vực đá',style: TextLine1(context,true))): Center(child: Text(_selectedDistrictsStr.join(","),style: TextLine2(context))),
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
              BlocBuilder<TeamBloc,TeamState>(
                  builder:(context,state){
                    if(state is LoadingTeams){
                     return Center(child: CircularProgressIndicator(),);
                    }
                    else if(state is LoadedTeams){
                      if(state.teamList.isEmpty){
                        return Center(child: Text('không có đội hình nào trong CLB này'),);
                      }else{
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.0,),
                            Text('Chọn đội hình',style: HeadLine1(context)),
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
                                    value:  team,
                                    items: state.teamList
                                        .map((team) =>
                                        DropdownMenuItem<Team>(
                                          value: team,
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

              Container(
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextButton.icon(
                  onPressed: () {

                    if(isValidFreeTimeValid(_freeTimeStart,_freeTimeEnd,_duration)!="" || isSelectedTeam(team,_is5vs5)!="" || isSelectedDistrict(_selectedDistrictIds)!=""){
                      if(mounted) {
                        setState(() {
                          validFreeTimeStr = isValidFreeTimeValid(
                              _freeTimeStart, _freeTimeEnd, _duration);
                          validTeamStr = isSelectedTeam(team, _is5vs5);
                          validDistrictStr =
                              isSelectedDistrict(_selectedDistrictIds);
                        });
                      }
                    }else{
                      if(mounted) {
                        setState(() {
                          validFreeTimeStr = isValidFreeTimeValid(
                              _freeTimeStart, _freeTimeEnd, _duration);
                          validTeamStr = isSelectedTeam(team, _is5vs5);
                          validDistrictStr =
                              isSelectedDistrict(_selectedDistrictIds);
                        });
                      }
                      String bookingDate = _selectedDate.toString();
                      String freetimeStart = convertTime(_freeTimeStart);
                      String freetimeEnd = convertTime(_freeTimeEnd);
                      int duration = _duration;
                      int teamId = _teamId!;
                      int fieldTypeId = _is5vs5 ? 1 : 2;
                      List<int> districtIdList = _selectedDistrictIds;
                      int isRivalry = _isRivalry ? 1 : 0 ;
                      BlocProvider.of<OpponentRequestBloc>(context).add(
                          CreateOpponentRequest(districtIdList: districtIdList, bookingDate: bookingDate, duration: duration, freetimeStart: freetimeStart, freetimeEnd: freetimeEnd, fieldTypeId: fieldTypeId, teamId: teamId,isRivalry: isRivalry));
                    }

                  },
                  icon: Icon(Icons.add,color:Colors.white),
                  label: Text('Tạo Yêu Cầu',style: WhiteTitleText()),
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
                            '${district.name}',
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
              child: const Text('Hủy bỏ'),
              onPressed: () {
                districtIdList.clear();
                districtStrList.clear();
                Navigator.of(context).pop();
              },
            ),

            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                districtStrList.sort((a,b){
                  return a.compareTo(b);
                });
                setState(() {
                  _selectedDistrictIds = districtIdList;
                  _selectedDistrictsStr = districtStrList;
                });

                Navigator.pop(context);
              },
            ),

          ],
        );
      },
    );
  }
}