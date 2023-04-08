//başlangıç pointin kordinatlarını vermeli ***o koordinata basıp google mapse falan gönderilebilir
//START tuşuna basınca doğru yerde mi? değilse süre başlamaz
//doğru yerdeyse süre başlar (+- 3 metre hata payı)
//istenen pointlere doğru giderse doğru gittiğini söyleyeceğiz gidemezse yanlış diyeceğiz
//bitiriş yerine gelince süre biter

//başlangıç saatini gösterebiliriz (belki sayaç)
//kaç tane doğru tiklendi kaç tane kaldı gözükebilir
//önce online şekilde yazarız, sonra geliştirmek istersek offline

import 'package:check_point/models/check_point.dart';
import 'package:check_point/models/run_model.dart';
import 'package:check_point/service/gps_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class RunPage extends StatefulWidget {
  const RunPage({super.key, required this.runModel});

  final RunModel runModel;

  @override
  State<RunPage> createState() => _RunPageState();
}

class _RunPageState extends State<RunPage> {
  Position? _currentPosition;

  bool isPositionCorrect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.runModel.parkour!.name),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                widget.runModel.parkour!.checkPointList[0].latitude.toString()),
            Text(widget.runModel.parkour!.checkPointList[0].longitude
                .toString()),
            Text("currentLatitude:  ${_currentPosition?.latitude}" ?? "null"),
            Text(" currentLongitude: ${_currentPosition?.longitude}" ?? "null"),
            ElevatedButton(
                onPressed: () async {
                  _currentPosition = await GpsService().getLocation();

                  bool isLatituteCorrect = false;

                  bool isLongitudeCorrect = false;

                  CheckPoint currentCheckPoint =
                      widget.runModel.parkour!.checkPointList[0];

                  if ((_currentPosition!.latitude <
                          currentCheckPoint.latitude! + 0.00003) &&
                      (_currentPosition!.latitude >
                          (currentCheckPoint.latitude! - 0.00003))) {
                    isLatituteCorrect = true;
                  }

                  if ((_currentPosition!.longitude <
                          currentCheckPoint.longitude! + 0.00003) &&
                      (_currentPosition!.longitude >
                          (currentCheckPoint.longitude! - 0.00003))) {
                    isLongitudeCorrect = true;
                  }

                  if (isLatituteCorrect && isLongitudeCorrect) {
                    isPositionCorrect = true;

                    CheckModel checkModel = CheckModel(
                      checkPointId: currentCheckPoint.id,
                      checkDateTime: DateTime.now(),
                    );

                    var runRef = FirebaseFirestore.instance
                        .collection("runs")
                        .doc(widget.runModel.id);

                    var checkRef =
                        runRef.collection("checks").doc(checkModel.id);

                    checkModel.id = checkRef.id;

                    checkRef.set(checkModel.toMap());
                  } else {
                    isPositionCorrect = false;
                  }

                  setState(() {});
                },
                child: const Text("Check")),
            Text("Aynı mı? ${isPositionCorrect ? "Doğru" : "Yanlış"}"),
          ],
        ));
  }
}
