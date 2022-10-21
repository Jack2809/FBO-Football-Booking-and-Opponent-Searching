class Field {
  final int id;
  final String name;
  final String districtName;
  final String openTime;
  final String closeTime;
  final String address;
  final String description;
  final String image;

  Field({required this.id,required this.name,required this.districtName,required this.address,required this.openTime,required this.closeTime,required this.description,required this.image});

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      id: json['id'] as int,
      name: json['facilityName'] as String,
      description: json['description'] as String,
      address: json['address'] as String,
      image: json['urlImage'] as String,
      openTime:json['openTime'] as String,
      closeTime: json['closeTime'] as String ,
      districtName: json['districtName'] as String,
    );
  }
}