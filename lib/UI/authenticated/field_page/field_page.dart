

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football_booking_fbo_mobile/constants.dart';
import 'package:football_booking_fbo_mobile/providers/google_login.dart';

import '../../../Models/field_model.dart';
import 'field_widgets/field_card.dart';
import 'field_widgets/field_detail.dart';
import 'field_widgets/search_field.dart';

class FieldPage extends StatefulWidget{

  @override
  State<FieldPage> createState() => _FieldPageState();
}

class _FieldPageState extends State<FieldPage> {
  // final List<String> convenientList = ["có bãi giữ xe","có nước uống miễn phí","có canteen"];
  // List<Field> list = [
  //   Field(name:"Sân bóng FPT",districtName:'Quận 9',address:"Lô E2a-7, Đường D1, Khu Công nghệ cao, P.Long Thạnh Mỹ, Tp. Thủ Đức, TP.HCM.",openTime:"7h",closeTime:"21h", ),
  //   Field(name:"Sân bóng Hutech",districtName:'Quận 9',address:" Khu Công nghệ cao TP.HCM, Đường D1, P.Long Thạnh Mỹ, TP.Thủ Đức, TP.HCM",openTime:"7h",closeTime:"22h",),
  //   Field(name:"Sân bóng Tiểu Ngư",districtName:'Quận 10',address:"780/14e Sư Vạn Hạnh, Phường 12, Quận 10, Thành phố Hồ Chí Minh",openTime:"6h",closeTime:"22h", ),
  //   Field(name:"Sân bóng Phú Thọ",districtName:'Quận 11',address:"219 Lý Thường Kiệt, Phường 15, Quận 11, Thành phố Hồ Chí Minh",openTime:"6h",closeTime:"22h", ),
  //   Field(name:"Sân bóng FPT 1",districtName:'Quận 9',address:"Lô E2a-7, Đường D1, Khu Công nghệ cao, P.Long Thạnh Mỹ, Tp. Thủ Đức, TP.HCM.",openTime:"7h",closeTime:"21h", ),
  //   Field(name:"Sân bóng Hutech 1",districtName:'Quận 9',address:" Khu Công nghệ cao TP.HCM, Đường D1, P.Long Thạnh Mỹ, TP.Thủ Đức, TP.HCM",openTime:"7h",closeTime:"22h",),
  //   Field(name:"Sân bóng Tiểu Ngư 1",districtName:'Quận Bình Thạnh',address:"780/14e Sư Vạn Hạnh, Phường 12, Quận 10, Thành phố Hồ Chí Minh",openTime:"6h",closeTime:"22h", ),
  //   Field(name:"Sân bóng Phú Thọ 1",districtName:'Quận 11',address:"219 Lý Thường Kiệt, Phường 15, Quận 11, Thành phố Hồ Chí Minh",openTime:"6h",closeTime:"22h", ),
  //   Field(name:"Sân bóng Tao Đàn",districtName:'Quận 1',address:"1 Huyền Trân Công Chúa, Phường Bến Thành, Quận 1, Thành phố Hồ Chí Minh",openTime:"6h",closeTime:"22h", ),
  // ];

   List<String> regionList = [];

  String _showStatus = "all";

  String _selectedRegion = "";

  List<Field> showRegionList = [];





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
      
      // body: Container(
      //   color: Colors.grey.withOpacity(0.02),
      //   padding: MyPaddingAll(),
      //   child: SafeArea(
      //     child: SingleChildScrollView(
      //       scrollDirection: Axis.vertical,
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: <Widget>[
      //
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Container(
      //                 width: size.height * 0.12,
      //                 decoration: BoxDecoration(
      //                 color: _showStatus == "all" ? Colors.green:Colors.black26,
      //                   borderRadius: BorderRadius.circular(20.0),
      //       ),
      //                 child: TextButton.icon(
      //                   icon: Icon(Icons.grid_view,color: Colors.white),
      //                   label: Text("All",style: TextStyle(color: Colors.white)),
      //                   onPressed: (){
      //                     setState(() {
      //                       _showStatus = "all";
      //                     });
      //                   },
      //                 ),
      //               ),
      //               SizedBox(width: 10.0,),
      //               Container(
      //                 width: size.height * 0.12,
      //                 decoration: BoxDecoration(
      //                 color: _showStatus == "region" ? Colors.green:Colors.black26,
      //                   borderRadius: BorderRadius.circular(20.0),
      //                 ),
      //                 child: TextButton.icon(
      //                   icon: Icon(Icons.place,color: Colors.white),
      //                   label: Text('Region',style: TextStyle(color: Colors.white)),
      //                   onPressed: (){
      //                     setState(() {
      //                       List<String> temp = [];
      //                       _showStatus = "region";
      //                       for(Field item in list){
      //                         temp.add(item.region);
      //                       }
      //                       var seen = Set<String>();
      //                       regionList = temp.where((religon) => seen.add(religon)).toList();
      //                       regionList.sort((a, b) => a.compareTo(b));
      //                       regionList.sort((a, b) => a.length.compareTo(b.length));
      //                       print(regionList);
      //                     });
      //                   },
      //                 ),
      //               ),
      //             ],
      //           ),
      //
      //           if(_showStatus == "all")...[
      //             SizedBox(height: size.height * 0.02,),
      //             Center(
      //               child: GridView.builder(
      //                 physics: NeverScrollableScrollPhysics(),
      //                 shrinkWrap: true,
      //                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //                     crossAxisCount: 2,
      //                     mainAxisSpacing: 15.0,
      //                     crossAxisSpacing: 15.0,
      //                     childAspectRatio: 0.58,
      //                   ),
      //                   itemCount: list.length,
      //                   itemBuilder: (BuildContext context,int index){
      //                     return Hero(
      //                       tag: list[index].name,
      //                       child: Material(
      //                         type: MaterialType.transparency,
      //                         child: GestureDetector(
      //                           onTap: (){
      //                             Navigator.push(
      //                               context,
      //                               MaterialPageRoute(builder: (context) => FieldDetail(field: list[index])),
      //                             );
      //                           },
      //                           child: FieldCard(list[index],size),
      //                         ),
      //                       ),
      //                     );
      //                   }
      //
      //               ),
      //             ),
      //           ]else...[
      //             SizedBox(height: size.height * 0.02,),
      //             SingleChildScrollView(
      //               scrollDirection: Axis.horizontal,
      //               child: Row(
      //                 children: [
      //                 for(int i = 0;i <regionList.length;i++)
      //                   Container(
      //                     decoration: BoxDecoration(
      //                       color: _selectedRegion == regionList[i] ?Colors.green:Colors.white,
      //                       borderRadius: BorderRadius.circular(10.0),
      //                     ),
      //                     child: TextButton(
      //                       child: Text(regionList[i],style: TextStyle(color: Colors.black)),
      //                       onPressed: (){
      //                         setState(() {
      //                           showRegionList.clear();
      //                           _selectedRegion = regionList[i];
      //                           for(Field item in list){
      //                             if(item.region == _selectedRegion){
      //                               showRegionList.add(item);
      //                             }
      //                           }
      //                         });
      //                       },
      //                     ),
      //                   ),
      //               ],
      //               ),
      //             ),
      //             SizedBox(height: size.height * 0.02,),
      //             Center(
      //               child: GridView.builder(
      //                   physics: NeverScrollableScrollPhysics(),
      //                   shrinkWrap: true,
      //                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //                     crossAxisSpacing: 15.0,
      //                     mainAxisSpacing: 15.0,
      //                     childAspectRatio: 0.58,
      //                     crossAxisCount: 2,
      //                   ),
      //                   itemCount: showRegionList.length,
      //                   itemBuilder: (BuildContext context,int index){
      //                     return GestureDetector(
      //                       onTap: (){
      //                         Navigator.push(
      //                           context,
      //                           MaterialPageRoute(builder: (context) => FieldDetail(field: showRegionList[index])),
      //                         );
      //                       },
      //                       child: FieldCard(showRegionList[index],size),
      //                     );
      //                   }
      //
      //               ),
      //             ),
      //
      //           ]
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }



}

