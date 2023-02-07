import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/district_bloc/district_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/district_bloc/district_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/district_bloc/district_state.dart';
import 'package:football_booking_fbo_mobile/Blocs/field_bloc/field_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/field_bloc/field_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/field_bloc/field_state.dart';
import 'package:football_booking_fbo_mobile/Models/district_model.dart';
import 'package:football_booking_fbo_mobile/constants.dart';
import 'package:group_button/group_button.dart';
import 'field_widgets/field_card.dart';
import 'field_widgets/field_detail.dart';
import 'field_widgets/search_field.dart';

class FieldPage extends StatefulWidget{

  @override
  State<FieldPage> createState() => _FieldPageState();
}

class _FieldPageState extends State<FieldPage> {
  
  @override
  void initState() {
    BlocProvider.of<DistrictBloc>(context).add(FetchDistricts());
    super.initState();
  }

  int _districtId = 0;
  String _districtName = "";

  bool _isFirstLoad = true ;

  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        bottomOpacity: 0.0,
        shadowColor: Colors.grey.withOpacity(0.02),
        backgroundColor: Colors.green,
        title: Text('Sân bóng',style: WhiteTitleText()),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchFieldPage()));
              },
              icon: Icon(Icons.search,color: Colors.white,))
        ],
      ),

      body: SafeArea(
        child: Container(
          padding: MyPaddingAll10(),
          child: BlocBuilder<DistrictBloc, DistrictState>(builder: (context, state) {
            if (state is LoadingDistricts) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedDistricts) {
              if (state.districtList.isEmpty) {
                return Center(
                  child: Text('Không có quận nào trong hệ thống'),
                );
              } else {
                if(_isFirstLoad){
                  _districtId = state.districtList.first.id;
                  _districtName = state.districtList.first.name;
                }
                BlocProvider.of<FieldBloc>(context)
                    .add(FetchFields(districtId: _districtId));
                return SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          int districtIdTemp = _districtId;
                          String districtNameTemp = _districtName;
                          _showChoosingADistrict(state.districtList,districtIdTemp,districtNameTemp);
                        },
                        child: Container(
                          height: size.height * 0.05,
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.green),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: const Offset(
                                    2.0,
                                    2.0,
                                  ),
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0,
                                ),
                                BoxShadow(
                                  color: Colors.white,
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ),
                              ]),
                          child: Center(child: Text(_districtName,style: TextLine1(context,true),)),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03,),
                      BlocBuilder<FieldBloc, FieldState>(
                          builder: (context, state) {
                            if (state is LoadingFields) {
                              return Container(
                                height: size.height * 0.8,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else if (state is LoadedFields) {
                              if (state.fieldList.isEmpty) {
                                return Center(
                                  child: Text('Không có sân nào trong quận này'),
                                );
                              } else {
                                return GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 15.0,
                                      crossAxisSpacing: 15.0,
                                      childAspectRatio: 0.57,
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
                                            child: FieldCard(context,state.fieldList[index],size),
                                          ),
                                        ),
                                      );
                                    }

                                );
                              }
                            } else {
                              return Center(
                                child: Text('Something wrong!!'),
                              );
                            }
                          }),

                    ],
                  ),
                );
              }
            } else {
              return Center(
                child: Text('Something wrong!!'),
              );
            }
          }),
        ),
      ),

    );
  }

  Future<void> _showChoosingADistrict(List<District> districtList,int previousDistrictId,String previousDistrictName) async {
    int tempId = previousDistrictId;
    String tempName = previousDistrictName;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        Size size = getSize(context);
        return AlertDialog(
          title: const Text('Chọn quận'),
          content: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GroupButton<District>(
                    maxSelected: 1,
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
                      if (isSelected) {
                        tempId = district.id;
                        tempName = district.name;

                      } else {
                        tempId = previousDistrictId;
                        tempName = previousDistrictName;
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
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {

                if (tempId == previousDistrictId || tempName == previousDistrictName) {
                  Navigator.pop(context);
                } else {
                  setState(() {
                    _isFirstLoad = false ;
                    _districtId = tempId;
                    _districtName = tempName;
                  });
                  BlocProvider.of<FieldBloc>(context).add(FetchFields(districtId: _districtId));

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

