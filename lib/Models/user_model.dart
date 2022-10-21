

class UserModel {

  final int id;
  final String accessToken;

  UserModel({required this.id,required this.accessToken});

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
        id: json['id'] as int,
        accessToken:json['accessToken'] as String);
  }

}

class UserInfoModel {
  int id;
  String username;
  String email;
  String name;
  String dateOfBirth;
  String address;
  String phoneNumber;
  String image;

  UserInfoModel({ required this.id,
    required this.username,
    required this.email,
    required this.name,
    required this.dateOfBirth,
    required this.address,
    required this.phoneNumber,
    required this.image,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      address: json['address'] as String,
      phoneNumber: json['phoneNumber']  ?? '' ,
      image: json['image'] as String,
    );
  }
}