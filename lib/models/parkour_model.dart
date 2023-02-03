// To parse this JSON data, do
//
//     final parkourModel = parkourModelFromJson(jsonString);

import 'dart:convert';

ParkourModel parkourModelFromJson(String str) =>
    ParkourModel.fromJson(json.decode(str));

String parkourModelToJson(ParkourModel data) => json.encode(data.toJson());

class ParkourModel {
  ParkourModel(
      {this.name = "",
      this.id = "",
      this.checkPointCount = "",
      this.checkPointList = const [],
      this.mapImageUrl = "",
      this.leaderBoard = "",
      this.createdDate = "",
      this.createdBy = "",
      this.description = ""});

  String name;
  String id;
  String checkPointCount;
  List<dynamic> checkPointList;
  String mapImageUrl;
  String leaderBoard;
  String createdDate;
  String createdBy;

  String description;

  factory ParkourModel.fromJson(Map<String, dynamic> json) => ParkourModel(
        name: json["name"],
        id: json["id"],
        checkPointCount: json["checkPointCount"],
        checkPointList:
            List<dynamic>.from(json["checkPointList"].map((x) => x)),
        mapImageUrl: json["mapImage"],
        leaderBoard: json["leaderBoard"],
        createdDate: json["createdDate"],
        createdBy: json["createdBy"],
        description: json["description"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "checkPointCount": checkPointCount,
        "checkPointList": List<dynamic>.from(checkPointList.map((x) => x)),
        "mapImage": mapImageUrl,
        "leaderBoard": leaderBoard,
        "createdDate": createdDate,
        "createdBy": createdBy,
        "description": description,
      };
}
