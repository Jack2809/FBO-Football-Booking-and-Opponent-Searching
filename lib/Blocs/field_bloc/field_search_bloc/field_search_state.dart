


import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/field_model.dart';

abstract class FieldSearchState extends Equatable{
  const FieldSearchState();

  @override
  List<Object> get props => [];
}

class LoadingSearchFields extends FieldSearchState{

}

class LoadedSearchFields extends FieldSearchState{
  final List<Field> fieldList;

  LoadedSearchFields({required this.fieldList});

  @override
  List<Object> get props => [fieldList];

}