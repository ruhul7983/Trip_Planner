class PostModel {
  PostModel({
    required this.Date,
    required this.Location,
    required this.TourCost,
    required this.TripDetails,
    required this.image,
    required this.placename,
  });
  late final String Date;
  late final String Location;
  late final String TourCost;
  late final String TripDetails;
  late final String image;
  late final String placename;

  PostModel.fromJson(Map<String, dynamic> json){
    Date = json['Date']??'';
    Location = json['Location']??'';
    TourCost = json['TourCost']??'';
    TripDetails = json['TripDetails']??'';
    image = json['image']as String;
    placename = json['placename']??'';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Date'] = Date;
    data['Location'] = Location;
    data['Tour Cost'] = TourCost;
    data['Trip Details'] = TripDetails;
    data['image'] = image;
    data['place name'] = placename;
    return data;
  }
}