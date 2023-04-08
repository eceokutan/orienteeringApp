import 'package:check_point/models/parkour_model.dart';

class RunModel {
  String? id;
  String? userId;
  ParkourModel? parkour;
  DateTime? startDateTime;
  DateTime? endDateTime;

  RunModel({
    this.id,
    this.userId,
    this.parkour,
    this.startDateTime,
    this.endDateTime,
  });

  RunModel fromMap(Map<String, dynamic> map) {
    return RunModel(
      id: map["id"],
      userId: map["userId"],
      parkour: map["parkour"],
      endDateTime: map["endDateTime"],
      startDateTime: map["startDateTime"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": userId,
      "parkour": parkour!.toJson(),
      "startDateTime": startDateTime?.toIso8601String(),
      "endDateTime": endDateTime?.toIso8601String(),
    };
  }
}

class CheckModel {
  String? id;
  String? checkPointId;
  DateTime? checkDateTime;

  CheckModel({
    this.id,
    this.checkPointId,
    this.checkDateTime,
  });

  CheckModel fromMap(Map<String, dynamic> map) {
    return CheckModel(
      id: map["id"],
      checkPointId: map["checkPointId"],
      checkDateTime: map["checkDateTime"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "checkPointId": checkPointId,
      "checkDateTime": checkDateTime?.toIso8601String(),
    };
  }
}
