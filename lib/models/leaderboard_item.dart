// To parse this JSON data, do
//
//     final parkourModel = parkourModelFromJson(jsonString);

import 'dart:convert';

LeaderboardItem parkourModelFromJson(String str) =>
    LeaderboardItem.fromJson(json.decode(str));

String parkourModelToJson(LeaderboardItem data) => json.encode(data.toJson());

class LeaderboardItem {
  LeaderboardItem({
    this.userName = "",
    this.userId = "",
    this.runId = "",
    this.timeTaken = -1,
  });
  String userName;
  String userId;
  String runId;
  int timeTaken;

  factory LeaderboardItem.fromJson(Map<String, dynamic> json) =>
      LeaderboardItem(
        userName: json["userName"] ?? "",
        userId: json["userId"],
        runId: json["runId"],
        timeTaken: json["timeTaken"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "userId": userId,
        "runId": runId,
        "timeTaken": timeTaken,
      };
}
