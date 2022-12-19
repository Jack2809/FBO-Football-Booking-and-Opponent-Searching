import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/a_matched_post_bloc/matched_post_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/billpay_bloc/billpay_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/book_facility_bloc/book_facility_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/booked_facility_post_bloc/booked_facility_post_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/deposit_fee_bloc/deposit_fee_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/district_bloc/district_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/facility_with_matched_post_bloc/facility_with_matched_post_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/field_bloc/field_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/field_bloc/field_search_bloc/field_search_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/match_history_bloc/match_history_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/match_history_score_bloc/match_history_score_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/opponent_request_bloc/opponent_request_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_bloc/player_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_match_history/player_match_history_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_team_bloc/player_team_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/recommended_request_bloc/recommended_request_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/review_player_in_match_bloc/review_player_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_detail_bloc/team_detail_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/time_slot_booking_facitily_post_bloc/time_slot_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/user_access_key_bloc/user_access_key_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/user_bloc/user_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/view_detail_facility_in_post_bloc/view_detail_facility_in_post_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/waiting_request_bloc/waiting_request_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/zalopay_bloc/zalopay_bloc.dart';
import 'package:football_booking_fbo_mobile/UI/bottom_navigation_bar.dart';
import 'package:football_booking_fbo_mobile/UI/unauthenticated/login_page/login_page.dart';
import 'package:football_booking_fbo_mobile/providers/google_login.dart';
import 'package:football_booking_fbo_mobile/services/access_key_shared_references.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Blocs/opponent_request_detail_bloc/opponent_request_detail_bloc.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences.setMockInitialValues({});
  await UserAccessKey.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GoogleLoginProvider()),
        BlocProvider(create: (context) => PlayerBloc()),
        BlocProvider(create: (context) => TeamBloc()),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => PlayerTeamBloc()),
        BlocProvider(create: (context) => DistrictBloc()),
        BlocProvider(create: (context) => OpponentRequestBloc()),
        BlocProvider(create: (context) => FieldBloc()),
        BlocProvider(create: (context) => RecommendedRequestBloc()),
        BlocProvider(create: (context) => OpponentRequestDetailBloc()),
        BlocProvider(create: (context) => WaitingRequestBloc()),
        BlocProvider(create: (context) => MatchedPostBloc()),
        BlocProvider(create: (context) => FacilityWithMatchedPostBloc()),
        BlocProvider(create: (context) => TimeSlotBloc()),
        BlocProvider(create: (context) => ZaloPayBloc()),
        BlocProvider(create: (context) => DepositFeeBloc()),
        BlocProvider(create: (context) => BookedFacilityByPostBloc()),
        BlocProvider(create: (context) => MatchHistoryBloc()),
        BlocProvider(create: (context) => ViewDetailFacilityBloc()),
        BlocProvider(create: (context) => MatchHistoryScoreBloc()),
        BlocProvider(create: (context) => PlayerReviewsBloc()),
        BlocProvider(create: (context) => TeamDetailBloc()),
        BlocProvider(create: (context) => FieldSearchBloc()),
        BlocProvider(create: (context) => UserAccessBloc()),
        BlocProvider(create: (context) => BillPayBloc()),
        BlocProvider(create: (context) => BookFacilityBloc()),
        BlocProvider(create: (context) => PlayerMatchHistoryBloc()),
      ],
      child: MaterialApp(
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child:CircularProgressIndicator());
          }else if(snapshot.hasData){
            return MyPageControllerPage();
          }else if(snapshot.hasError){
            return Center(child: Text('something went wrong!!'),);
          }else{
            return LoginPage();
          }
        },
      ),
    );
  }
  
}




