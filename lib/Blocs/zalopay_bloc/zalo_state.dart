

import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/zalopay_response_model.dart';

abstract class ZaloPayState extends Equatable{
  const ZaloPayState();


  @override
  List<Object> get props => [];
}

class LoadingZaloPay extends ZaloPayState{

}

class LoadedZaloPay extends ZaloPayState{
  ZaloPayResponseModel zaloPayResponse;

  LoadedZaloPay({required this.zaloPayResponse});

  @override
  List<Object> get props => [zaloPayResponse];

}