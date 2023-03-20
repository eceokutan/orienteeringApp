import 'dart:developer';

import 'package:check_point/models/check_point.dart';
import 'package:check_point/models/parkour_model.dart';
import 'package:check_point/viewmodels/parkour_view_model.dart';
import 'package:flutter/material.dart';

class CreateParkourPage extends StatefulWidget {
  const CreateParkourPage({super.key});

  @override
  State<CreateParkourPage> createState() => _CreateParkourPageState();
}

class _CreateParkourPageState extends State<CreateParkourPage> {
  TextEditingController parkourNameController = TextEditingController();

  TextEditingController parkourDescriptionController = TextEditingController();

  TextEditingController longtitudeController = TextEditingController();

  TextEditingController latitudeController = TextEditingController();

  List<CheckPoint> checkPoints = [];

  String link = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Parkour Page"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text("Parkur İsmi"),
            TextField(
              controller: parkourNameController,
            ),
            const Text("Parkur Açıklaması"),
            TextField(
              controller: parkourDescriptionController,
            ),
            const SizedBox(
              height: 10,
            ),
            if (ParkourViewModel().parkourImages.isNotEmpty)
              Image.file(
                ParkourViewModel().parkourImages.first.file!,
                alignment: Alignment.center,
                fit: BoxFit.cover,
                height: 200,
              )
            else
              InkWell(
                onTap: () {
                  ParkourViewModel()
                      .pickParkourImages()
                      .then((value) => setState(() {}));
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  alignment: Alignment.center,
                  height: 200,
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text("Add Image +", style: TextStyle()),
                ),
              ),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: longtitudeController,
                  decoration: const InputDecoration(hintText: "Longtitude"),
                )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: TextField(
                  controller: latitudeController,
                  decoration: const InputDecoration(hintText: "Latitude"),
                )),
                IconButton(
                    onPressed: () {
                      log(latitudeController.text);
                      setState(() {
                        try {
                          checkPoints.add(CheckPoint(
                              latitude: double.parse(latitudeController.text),
                              longitude:
                                  double.parse(longtitudeController.text)));
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(title: Text(e.toString()));
                            },
                          );
                        }
                      });
                    },
                    icon: const Icon(Icons.add_box_rounded))
              ],
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: checkPoints.length,
                itemBuilder: (context, index) {
                  CheckPoint checkPoint = checkPoints[index];
                  return Row(
                    children: [
                      Text(
                          "${index + 1} ${checkPoint.longitude} - ${checkPoint.longitude}"),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              checkPoints.remove(checkPoint);
                            });
                          },
                          icon: const Icon(Icons.remove))
                    ],
                  );
                },
              ),
            ),
            if (ParkourViewModel().parkourImages.isNotEmpty)
              ElevatedButton(
                  onPressed: () async {
                    String incominglink = await ParkourViewModel()
                        .uploadImage(ParkourViewModel().parkourImages.first);

                    ParkourModel parkour = ParkourModel(
                        name: parkourNameController.text,
                        mapImageUrl: incominglink,
                        checkPointCount: checkPoints.length.toString(),
                        checkPointList: checkPoints,
                        createdDate: DateTime.now().toIso8601String(),
                        description: parkourDescriptionController.text);

                    await ParkourViewModel().addNewParkour(parkour);
                  },
                  child: const Text("Gönder")),
            if (link.isNotEmpty)
              Image.network(
                link,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
          ],
        ),
      ),
    );
  }
}
