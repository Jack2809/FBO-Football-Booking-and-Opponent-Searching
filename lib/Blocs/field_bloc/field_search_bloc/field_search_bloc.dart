

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/field_bloc/field_search_bloc/field_search_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/field_bloc/field_search_bloc/field_search_state.dart';
import 'package:football_booking_fbo_mobile/services/field_services.dart';

class FieldSearchBloc extends Bloc<FieldSearchEvent,FieldSearchState>{
  FieldSearchBloc() : super (LoadingSearchFields()){


    on<SearchFields> ((event,emit) async{
      emit(LoadingSearchFields());
      var searchFieldList = await searchFields(event.duration, event.fieldTypeId, event.searchContent, event.chosenDate);
      emit(LoadedSearchFields(fieldList: searchFieldList));

    });

  }

}