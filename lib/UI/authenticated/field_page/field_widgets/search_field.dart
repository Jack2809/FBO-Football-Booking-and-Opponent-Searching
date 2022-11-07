import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:football_booking_fbo_mobile/Blocs/field_bloc/field_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/field_bloc/field_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/field_bloc/field_state.dart';
import 'package:football_booking_fbo_mobile/constants.dart';
import 'field_card.dart';
import 'field_detail.dart';
import 'package:intl/intl.dart';


class SearchFieldPage extends StatefulWidget{

  @override
  State<SearchFieldPage> createState() => _SearchFieldPageState();
}

class _SearchFieldPageState extends State<SearchFieldPage> {

  TextEditingController searchContentC = TextEditingController();

  double durationSearch = 1.0;

  int fieldTypeIdSearch = 1;

  String chosenDaySearch = DateFormat('yyyy-MM-dd').format(DateTime.now());

  bool isFirstSearch = true;

  void _durationCallBack(double? selectedDuration){
    if(selectedDuration is double){
      setState(() {
        durationSearch = selectedDuration;
      });
    }
  }

  void _fieldTypeCallBack(int? selectedFieldTypeId){
    if(selectedFieldTypeId is int){
      setState(() {
        fieldTypeIdSearch = selectedFieldTypeId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
        bottomOpacity: 0.0,
        shadowColor: Colors.grey.withOpacity(0.02),
        backgroundColor: Colors.green,
        title: Container(
          height: size.height * 0.05,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: TextField(
              controller: searchContentC,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'nhập tên sân hoặc quận huyện',
              ),
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                setState(() {
                  isFirstSearch = false;
                });
                BlocProvider.of<FieldBloc>(context).add(SearchFields(searchContent: searchContentC.text, chosenDate: chosenDaySearch, duration: durationSearch, fieldTypeId: fieldTypeIdSearch));
              },
              icon: Icon(Icons.search,color: Colors.white,))
        ],
      ),
      body: Container(
        color: Colors.grey.withOpacity(0.02),
        padding: MyPaddingAll10(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Thời lượng',style: TextLine1(true)),
                        Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Center(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  value: durationSearch,
                                  items:[
                                    DropdownMenuItem(child: Center(child: Text('1 tiếng',textAlign:TextAlign.center)),value: 1.0),
                                    DropdownMenuItem(child: Center(child: Text('1 tiếng 30 phút',textAlign:TextAlign.center)),value: 1.5),
                                    DropdownMenuItem(child: Center(child: Text('2 tiếng',textAlign:TextAlign.center)),value: 2.0),
                                  ] ,
                                  onChanged:_durationCallBack),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Loại sân',style: TextLine1(true)),
                        Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Center(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  value: fieldTypeIdSearch,
                                  items:[
                                    DropdownMenuItem(child: Center(child: Text('5 vs 5',textAlign:TextAlign.center)),value: 1),
                                    DropdownMenuItem(child: Center(child: Text('7 vs 7',textAlign:TextAlign.center)),value: 2),

                                  ] ,
                                  onChanged:_fieldTypeCallBack),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ngày',style: TextLine1(true)),
                        Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: TextButton(
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime.now(),
                                    maxTime: DateTime.now().add(Duration(days: 365)), onChanged: (date) {
                                      print('change $date');
                                    }, onConfirm: (date) {
                                      setState(() {
                                        chosenDaySearch = DateFormat('yyyy-MM-dd').format(date);
                                      });
                                    }, currentTime: DateTime.now(), locale: LocaleType.vi);
                              },
                              child: Text(
                                dateFormat(chosenDaySearch),
                                style: TextStyle(color: Colors.black),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.0,),
                BlocBuilder<FieldBloc,FieldState>(
                    builder:(context,state){
                      if(state is LoadingFields){
                        return isFirstSearch ? SizedBox():Center(child: CircularProgressIndicator(),);
                      }
                      else if(state is LoadedFields){
                        if(state.fieldList.isEmpty){
                          return Center(child: Text('Không có sân theo nội dung tim kiếm'),);
                        }else{
                          return GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15.0,
                                  crossAxisSpacing: 15.0,
                                  childAspectRatio: 0.58,
                                ),
                                itemCount: state.fieldList.length,
                                itemBuilder: (BuildContext context,int index){
                                  return Hero(
                                    tag: state.fieldList[index].name,
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => FieldDetail(field: state.fieldList[index])),
                                          );
                                        },
                                        child: FieldCard(state.fieldList[index],size),
                                      ),
                                    ),
                                  );
                                }

                            );

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

    );
  }
}


// class CustomSearch extends SearchDelegate{
//   final List<Field> list;
//   CustomSearch({required this.list});
//
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//           onPressed: (){
//             query = '';
//           },
//           icon: Icon(Icons.close))
//     ];
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//         onPressed: (){
//           close(context, '');
//         },
//         icon: Icon(Icons.arrow_back_ios));
//   }
//
//   @override
//   Widget buildResults (BuildContext context) {
//     Size size = getSize(context);
//     List<Field> matchList = [];
//     for (var item in list){
//       if(item.name.toLowerCase().contains(query.toLowerCase())){
//         matchList.add(item);
//       }
//     }
//     return Container(
//       padding: MyPaddingAll(),
//       child: ListView.builder(
//         padding: MyPaddingAll(),
//           itemCount: matchList.length,
//           itemBuilder: (context,index){
//             var result = matchList[index];
//             return GestureDetector(
//                 onTap: (){
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => FieldDetail(field: result)),
//                   );
//                 },
//                 child: HorizontalFieldCard(result, size)
//             );
//           }
//       ),
//     );
//   }
//
//   @override
//   Widget buildSuggestions (BuildContext context) {
//
//     return Container();
//     // Size size = MediaQuery.of(context).size;
//     // List<Field> matchList = [];
//     // for (var item in list){
//     //   if(item.name.toLowerCase().contains(query.toLowerCase())){
//     //     matchList.add(item);
//     //   }
//     // }
//     // return ListView.builder(
//     //     itemCount: matchList.length,
//     //     itemBuilder: (context,index){
//     //       var result = matchList[index];
//     //       return GestureDetector(
//     //         onTap: (){
//     //           Navigator.push(
//     //             context,
//     //             MaterialPageRoute(builder: (context) => FieldDetail(field: result)),
//     //           );
//     //         },
//     //           child: HorizontalFieldCard(result, size)
//     //       );
//     //     }
//     // );
//   }
//
// }