

class BillPay {
  final int billPayId;
  final int billId;
  final String payType;
  final double amount;
  final String date;
  final String facilityName;
  final String fieldType;
  final String startTime;
  final String endTime;
  final String dateReserved;

  BillPay({
    required this.billPayId,
    required this.billId,
    required this.amount,
    required this.payType,
    required this.date,
    required this.facilityName,
    required this.fieldType,
    required this.startTime,
    required this.endTime,
    required this.dateReserved
});

  factory BillPay.fromJson(Map<String,dynamic> json){
    return BillPay(
      billPayId: json['id'],
      billId: json['billId'],
      payType: json['payType'],
      amount: json['amount'],
      date: json['dateTime'],
      facilityName: json['facilityName'],
      fieldType: json['fieldTypeName'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      dateReserved: json['dateReserved']
    );
  }
}