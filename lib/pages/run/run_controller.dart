import 'package:check_point/models/check_point.dart';
import 'package:check_point/models/run_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class RunController {
  //singleton kodu
  RunController._();

  static final RunController _instance = RunController._();

  factory RunController() {
    return _instance;
  }

  double tolerance = 0.00003;

  Future createCheck(CheckModel checkModel, String id) async {
    var runRef = FirebaseFirestore.instance.collection("runs").doc(id);

    var checkRef = runRef.collection("checks").doc(checkModel.id);

    checkModel.id = checkRef.id;

    checkRef.set(checkModel.toMap());
  }

  bool checkLatitude(Position _currentPosition, CheckPoint currentCheckPoint) {
    if ((_currentPosition.latitude < currentCheckPoint.latitude! + tolerance) &&
        (_currentPosition.latitude >
            (currentCheckPoint.latitude! - tolerance))) {
      return true;
    }
    return false;
  }

  bool checkLongitude(Position _currentPosition, CheckPoint currentCheckPoint) {
    if ((_currentPosition.longitude <
            currentCheckPoint.longitude! + tolerance) &&
        (_currentPosition.longitude >
            (currentCheckPoint.longitude! - tolerance))) {
      return true;
    }
    return false;
  }

  bool checkPosition(Position _currentPosition, CheckPoint currentCheckPoint) {
    if (checkLatitude(_currentPosition, currentCheckPoint) &&
        checkLongitude(_currentPosition, currentCheckPoint)) {
      return true;
    } else {
      return false;
    }
  }
}
