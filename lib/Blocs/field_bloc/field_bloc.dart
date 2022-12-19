

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/field_bloc/field_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/field_bloc/field_state.dart';
import 'package:football_booking_fbo_mobile/services/field_services.dart';

class FieldBloc extends Bloc<FieldEvent,FieldState>{
  FieldBloc() : super (LoadingFields()){


    on<FetchFields> ((event,emit) async{
      emit(LoadingFields());
      var fieldList = await fetchFields(event.districtId);
      emit(LoadedFields(fieldList: fieldList));

    });

  }

}