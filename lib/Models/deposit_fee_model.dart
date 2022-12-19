

class DepositFeeModel {
  final double depositAmount;

  DepositFeeModel({required this.depositAmount});

  factory DepositFeeModel.fromJson(Map<String,dynamic> json){
    return DepositFeeModel(
      depositAmount: json['rentalFee'] as double,
    );
  }
}