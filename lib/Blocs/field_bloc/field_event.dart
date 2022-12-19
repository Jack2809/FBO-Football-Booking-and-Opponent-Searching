import 'package:equatable/equatable.dart';


abstract class FieldEvent extends Equatable{
  const FieldEvent();

  @override
  List<Object> get props => [];
}

class FetchFields extends FieldEvent{
  final int districtId;

  FetchFields({required this.districtId});

  @override
  List<Object> get props => [districtId];

}





