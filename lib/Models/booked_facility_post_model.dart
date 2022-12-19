

class BookedFacilityByPost {
  final int facilityId;
  final String facilityName;
  final String dateReserved;
  final String startTime;

  BookedFacilityByPost({
    required this.facilityId,
    required this.facilityName,
    required this.dateReserved,
    required this.startTime

  });

factory BookedFacilityByPost.fromJson(Map<String, dynamic> json){
  return BookedFacilityByPost(
    facilityId: json['facilityId'] as int,
    facilityName: json['facilityName'] as String,
    dateReserved: json['dateReserved'] as String,
    startTime: json['startTime'] as String,
  );
}
}