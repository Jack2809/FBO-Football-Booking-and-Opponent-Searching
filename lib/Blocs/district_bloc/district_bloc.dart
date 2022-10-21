

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/district_bloc/district_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/district_bloc/district_state.dart';
import 'package:football_booking_fbo_mobile/services/district_services.dart';

class DistrictBloc extends Bloc<DistrictEvent,DistrictState>{
  DistrictBloc() : super (LoadingDistricts()){
    on<FetchDistricts> ((event,emit) async{
      emit(LoadingDistricts());
      var fetchedList = await fetchAllDistricts();
      emit(LoadedDistricts(districtList:fetchedList));
    });


  }

}