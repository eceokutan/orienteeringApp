import 'package:check_point/models/check_point.dart';
import 'package:check_point/models/run_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

//flutter: lat41.063716507916986 CHECKED
//flutter: long28.972566970745504

//flutter: lat41.06343459060022 GIVEN
//flutter: long28.97250479802087
class RunManager {
  //singleton code
  RunManager._();

  static final RunManager _instance = RunManager._();

  factory RunManager() {
    return _instance;
  }

  double tolerance = 0.00015;
  //0.00003

  Future createCheck(CheckModel checkModel, String id) async {
    var runRef = FirebaseFirestore.instance.collection("runs").doc(id);

    var checkRef = runRef.collection("checks").doc(checkModel.id);

    checkModel.id = checkRef.id;

    checkRef.set(checkModel.toMap());
  }

  bool checkLatitude(Position currentPosition, CheckPoint currentCheckPoint) {
    if ((currentPosition.latitude < currentCheckPoint.latitude! + tolerance) &&
        (currentPosition.latitude >
            (currentCheckPoint.latitude! - tolerance))) {
      return true;
    }
    return false;
  }

  bool checkLongitude(Position currentPosition, CheckPoint currentCheckPoint) {
    if ((currentPosition.longitude <
            currentCheckPoint.longitude! + tolerance) &&
        (currentPosition.longitude >
            (currentCheckPoint.longitude! - tolerance))) {
      return true;
    }
    return false;
  }

  bool checkPosition(Position currentPosition, CheckPoint currentCheckPoint) {
    if (checkLatitude(currentPosition, currentCheckPoint) &&
        checkLongitude(currentPosition, currentCheckPoint)) {
      return true;
    } else {
      return false;
    }
  }

  Future endRun(String runId, String startTimeString) async {
    //saat kaydetme
    DateTime nowTime = DateTime.now();
    DateTime startTime = DateTime.parse(startTimeString);
    Duration totalTime = nowTime.difference(startTime);
    var runRef = await FirebaseFirestore.instance
        .collection("runs")
        .doc(runId)
        .update({
      "endDateTime": nowTime.toIso8601String(),
      "timeTaken": totalTime.inMilliseconds
    });
  }
}
