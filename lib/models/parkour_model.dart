// To parse this JSON data, do
//
//     final parkourModel = parkourModelFromJson(jsonString);

import 'dart:convert';

import 'package:check_point/models/check_point.dart';
import 'package:check_point/models/leaderboard_item.dart';

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
      this.leaderBoard = const [],
      // user id, timeTaken, run id
      this.createdDate = "",
      this.createdBy = "",
      this.description = ""});

  String name;
  String id;
  String checkPointCount;
  List<CheckPoint> checkPointList;
  String mapImageUrl;
  List<LeaderboardItem> leaderBoard;
  String createdDate;
  String createdBy;

  String description;

  factory ParkourModel.fromJson(Map<String, dynamic> json) => ParkourModel(
        name: json["name"],
        id: json["id"],
        checkPointCount: json["checkPointCount"],
        checkPointList: (json["checkPointList"] as List<dynamic>)
            .map((x) => CheckPoint.fromJson(x))
            .toList(),
        mapImageUrl: json["mapImage"],
        leaderBoard: (json["leaderBoard"] as List<dynamic>)
            .map((x) => LeaderboardItem.fromJson(x))
            .toList(),
        createdDate: json["createdDate"],
        createdBy: json["createdBy"],
        description: json["description"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "checkPointCount": checkPointCount,
        "checkPointList":
            List<dynamic>.from(checkPointList.map((x) => x.toJson())),
        "mapImage": mapImageUrl,
        "leaderBoard": List<dynamic>.from(leaderBoard.map((x) => x.toJson())),
        "createdDate": createdDate,
        "createdBy": createdBy,
        "description": description,
      };
}
