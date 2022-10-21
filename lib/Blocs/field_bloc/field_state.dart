import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/field_model.dart';

abstract class FieldState extends Equatable{
  const FieldState();

  @override
  List<Object> get props => [];
}

class LoadingFields extends FieldState{

}

class LoadedFields extends FieldState{
  final List<Field> fieldList;

  LoadedFields({required this.fieldList});

  @override
  List<Object> get props => [fieldList];

}