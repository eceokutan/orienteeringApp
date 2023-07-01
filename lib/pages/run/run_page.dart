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
import 'package:check_point/pages/home/HomePage.dart';
import 'package:check_point/pages/run/run_controller.dart';
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
  int checkPointId = 0;

  void checkLeaderBoard() {
    //leaderboard listesini çek.
    //ben ilk 5te miyim? kontrol et.
    //eğer ilk 5teysem ilk 5 listesini değiştir.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              FirebaseFirestore.instance
                  .collection("runs")
                  .doc(widget.runModel.id)
                  .delete();
            },
          ),
          title: Text(widget.runModel.parkour!.name),
        ),
        body: Column(
          children: [
            GestureDetector(
              child: Image.network(widget.runModel.parkour!.mapImageUrl),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    insetPadding: EdgeInsets.zero,
                    content: InteractiveViewer(
                        maxScale: 3,
                        minScale: 0.1,
                        child: Image.network(
                            widget.runModel.parkour!.mapImageUrl)),
                    contentPadding: EdgeInsets.zero,
                  ),
                );
              },
            ),
            Text("Next CheckPoint: ${checkPointId}" ?? "null"),
            if (checkPointId == 0)
              Text("currentLatitude:  ${_currentPosition?.latitude}" ?? "null"),
            if (checkPointId == 0)
              Text(" currentLongitude: ${_currentPosition?.longitude}" ??
                  "null"),
            ElevatedButton(
                onPressed: () async {
                  _currentPosition = await GpsService().getLocation();
                  CheckPoint currentCheckPoint =
                      widget.runModel.parkour!.checkPointList[checkPointId];

                  if (RunController()
                      .checkPosition(_currentPosition!, currentCheckPoint)) {
                    isPositionCorrect = true;

                    if (checkPointId + 1 <
                        widget.runModel.parkour!.checkPointList.length) {
                      checkPointId++;
                      CheckModel checkModel = CheckModel(
                        checkPointId: currentCheckPoint.id,
                        checkDateTime: DateTime.now(),
                      );
                      await RunController()
                          .createCheck(checkModel, widget.runModel.id!);
                    } else {
                      //end
                      await RunController()
                          .endRun(widget.runModel.id!,
                              widget.runModel.startDateTime!)
                          .then((value) => showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text("completed"),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HomePage()),
                                                (route) => false);
                                          },
                                          child: Text("Go to Home Page"))
                                    ],
                                  );
                                },
                              ));
                    }
                  } else {
                    isPositionCorrect = false;
                  }

                  setState(() {});
                },
                child: const Text("Check")),
            Text("Correct? ${isPositionCorrect ? "Correct" : "False"}"),
          ],
        ));
  }
}
