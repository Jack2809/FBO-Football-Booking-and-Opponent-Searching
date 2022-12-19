

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/book_facility_bloc/book_facility_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/book_facility_bloc/book_facility_state.dart';
import 'package:football_booking_fbo_mobile/services/book_facility_service.dart';
import 'package:rxdart/subjects.dart';

class BookFacilityBloc extends Bloc<BookFacilityEvent, BookFacilityState> {

  final BehaviorSubject<dynamic> _listenerController = BehaviorSubject<dynamic>();
  Sink<dynamic> get listener => _listenerController.sink;
  Stream<dynamic> get listenerStream => _listenerController.stream;

  BookFacilityBloc() : super (LoadingBookedFacilityByPost()) {

    on<BookFacility>((event, emit) async {
      var bookedFacility = await bookFacility(
           event.depositMoney, event.facilityId, event.duration,
          event.fieldTypeId, event.startDateTime);
      listener.add(bookedFacility);
      log('book message:' + bookedFacility);
      listener.add('');
    });

  }
}