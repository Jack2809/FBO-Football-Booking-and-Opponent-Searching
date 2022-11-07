 import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_state.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/account_page/account_widgets/team/team_card.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/account_page/account_widgets/team/team_creation.dart';
import 'package:football_booking_fbo_mobile/constants.dart';



import 'team_detail_page.dart';



 class TeamPage extends StatefulWidget{
   @override
   State<TeamPage> createState() => _TeamPageState();
 }

 class _TeamPageState extends State<TeamPage> {


   @override
   void initState() {
     BlocProvider.of<TeamBloc>(context).add(FetchTeams());
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
         title: Text('Đội hình của tôi', style: WhiteTitleText()),
         centerTitle: true,
         elevation: 0.0,
         bottomOpacity: 0.0,
         shadowColor: Colors.grey.withOpacity(0.02),
         backgroundColor: Colors.green,
         leading: IconButton(
           onPressed: () {
             Navigator.of(context).pop();
           },
           icon: Icon(Icons.arrow_back_ios, color: Colors.white),
         ),
       ),
       body: Container(
         color: Colors.grey.withOpacity(0.02),
         child: BlocBuilder<TeamBloc,TeamState>(
             builder:(context,state){
               if(state is LoadingTeams){
                 return Center(child: CircularProgressIndicator(),);
               }
               else if(state is LoadedTeams){
                 if(state.teamList.isEmpty){
                   return Center(child: Text('Không có đội hình nào'),);
                 }else{
                   return ListView.separated(
                     separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10.0),
                     padding: MyPaddingAll10(),
                    // shrinkWrap: true,
                    itemCount: state.teamList.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () async{
                          final result = await Navigator.push(context, MaterialPageRoute(builder: (context) =>  TeamDetail(team:state.teamList[index],)));
                          if(!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green,content: Text(result)));
                        },
                        child: TeamCard(team: state.teamList[index]),
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
         decoration:BoxDecoration(
           borderRadius: BorderRadius.circular(10.0),
           color: Colors.green,
         ),
         child: TextButton.icon(
           onPressed: () async{
             final result = await Navigator.push(context, MaterialPageRoute(builder: (context) =>  CreateTeamPage()),);
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green,content: Text(result)));
           },
           icon: Icon(Icons.add,color: Colors.white,),
           label: Text('Tạo Đội hình',style: MyButtonText()),
         ),
       ),

     );
   }
 }


