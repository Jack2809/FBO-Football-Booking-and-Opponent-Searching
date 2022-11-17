

class BookedFacilityByPost {
<<<<<<< HEAD
  final String facilityName;


  BookedFacilityByPost({
    required this.facilityName,

  });

  factory BookedFacilityByPost.fromJson(Map<String,dynamic> json){
    return BookedFacilityByPost(
        facilityName: json['facilityName'] as String,
    );
  }

=======
  final int facilityId;
  final String facilityName;
  final String fieldTypeId;
  final String address;
  final String bookingDate;
  final String startTime;
  final String endTime;
  final String districtName;

  BookedFacilityByPost({
    required this.facilityId,
    required this.facilityName,
    required this.fieldTypeId,
    required this.address,
    required this.bookingDate,
    required this.startTime,
    required this.endTime,
    required this.districtName
  });

>>>>>>> f7fbb583d6e9cdbbcbb9f5e0109f4ee8d3a9bc55
}