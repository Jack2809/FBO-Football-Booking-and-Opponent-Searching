

class BookedFacilityByPost {
  final String facilityName;


  BookedFacilityByPost({
    required this.facilityName,

  });

  factory BookedFacilityByPost.fromJson(Map<String,dynamic> json){
    return BookedFacilityByPost(
        facilityName: json['facilityName'] as String,
    );
  }

}