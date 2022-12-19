

import 'package:equatable/equatable.dart';

abstract class ZaloPayEvent extends Equatable{
  const ZaloPayEvent();

  @override
  List<Object> get props => [];
}

class CreateOrder extends ZaloPayEvent{

  final int totalAmount;

  CreateOrder({required this.totalAmount});

  @override
  List<Object> get props => [totalAmount];
}

