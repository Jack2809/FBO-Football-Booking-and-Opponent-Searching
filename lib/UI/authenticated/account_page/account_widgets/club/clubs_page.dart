 import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Models/club_model.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/account_page/account_widgets/club/club_card.dart';
import 'package:football_booking_fbo_mobile/constants.dart';
import 'package:football_booking_fbo_mobile/services/access_key_shared_references.dart';
import 'package:football_booking_fbo_mobile/services/club_services.dart';
import 'club_creation_page.dart';

 import 'package:football_booking_fbo_mobile/Blocs/club_bloc/club_event.dart';
 import 'package:football_booking_fbo_mobile/Blocs/club_bloc/club_bloc.dart';
 import 'package:football_booking_fbo_mobile/Blocs/club_bloc/club_state.dart';

import 'club_detail_page.dart';



 class ClubPage extends StatefulWidget{
   @override
   State<ClubPage> createState() => _ClubPageState();
 }

 class _ClubPageState extends State<ClubPage> {


   @override
   void initState() {
     BlocProvider.of<ClubBloc>(context).add(FetchClubs());
     super.initState();
   }

   @override
   void dispose() {
     super.dispose();
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('Câu Lạc Bộ của tôi', style: TextLine1(true)),
         centerTitle: true,
         elevation: 0.0,
         bottomOpacity: 0.0,
         shadowColor: Colors.grey.withOpacity(0.02),
         backgroundColor: Colors.transparent,
         leading: IconButton(
           onPressed: () {
             Navigator.of(context).pop();
           },
           icon: Icon(Icons.arrow_back_ios, color: Colors.black),
         ),
       ),
       body: Container(
         color: Colors.grey.withOpacity(0.02),
         child: BlocBuilder<ClubBloc,ClubState>(
             builder:(context,state){
               if(state is LoadingClubs){
                 return Center(child: CircularProgressIndicator(),);
               }
               else if(state is LoadedClubs){
                 if(state.clubList.isEmpty){
                   return Center(child: Text('Không có CLB nào'),);
                 }else{
                   return ListView.separated(
                     separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10.0),
                     padding: MyPaddingAll(),
                    // shrinkWrap: true,
                    itemCount: state.clubList.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  ClubDetail(club:state.clubList[index],)));
                        },
                        child: ClubCard(club: state.clubList[index]),
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
       ),
       floatingActionButton: Container(
         color: Colors.green,
         child: TextButton.icon(
           onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context) =>  ClubCreationPage()),
            );
           },
           icon: Icon(Icons.person_add_rounded),
           label: Text('Tạo CLB',style: TextLine1(true)),
         ),
       ),

     );
   }
 }


