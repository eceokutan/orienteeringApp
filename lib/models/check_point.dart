class CheckPoint {
  CheckPoint({this.id, this.latitude, this.longitude});

  String? id;

  double? longitude;

  double? latitude;

  factory CheckPoint.fromJson(Map<String, dynamic> json) => CheckPoint(
        longitude: json["longitude"],
        id: json["id"],
        latitude: json["latitude"],
      );

  Map<String, dynamic> toJson() => {
        "longitude": longitude,
        "id": id,
        "latitude": latitude,
      };
}
