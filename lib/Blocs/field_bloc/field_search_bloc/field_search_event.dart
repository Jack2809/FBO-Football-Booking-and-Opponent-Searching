

import 'package:equatable/equatable.dart';

abstract class FieldSearchEvent extends Equatable{
  const FieldSearchEvent();

  @override
  List<Object> get props => [];
}


class SearchFields extends FieldSearchEvent{
  final String searchContent;
  final String chosenDate;
  final double duration;
  final int fieldTypeId;

  SearchFields({required this.searchContent,required this.chosenDate,required this.duration,required this.fieldTypeId});

  @override
  List<Object> get props => [searchContent,chosenDate,duration,fieldTypeId];
}