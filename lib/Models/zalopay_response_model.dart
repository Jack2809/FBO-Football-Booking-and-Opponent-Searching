

class ZaloPayResponseModel {
  final String orderUrl;
  final int returnCode;
  final String returnMessage;
  final String zpTransToken;
  final String appTransId;

  ZaloPayResponseModel({
    required this.orderUrl,
    required this.returnCode,
    required this.returnMessage,
    required this.zpTransToken,
    required this.appTransId
});

  factory ZaloPayResponseModel.fromJson(Map<String, dynamic> json){
    return ZaloPayResponseModel(
        orderUrl: json['orderUrl'] as String,
      returnCode: json['returnCode'] as int,
      returnMessage: json['returnMessage'] as String,
      zpTransToken: json['zpTransToken'] as String,
      appTransId: json['appTransId'] as String
    );
  }
}