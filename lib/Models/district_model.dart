

class District {
  final int id;
  final String name;

  District({required this.id,required this.name});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id'] as int,
      name: json['districtName'] as String,
    );
  }

  @override
  String toString() {
    return ' $name';
  }
}