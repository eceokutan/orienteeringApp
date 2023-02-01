import 'dart:io';

import 'package:check_point/models/parkour_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ParkourService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadSingleFile(
      {required File? file, required String childPath}) async {
    Reference firebaseStorageRef = firebaseStorage.ref().child(childPath);
    UploadTask uploadTask = firebaseStorageRef.putFile(file!);

    TaskSnapshot taskSnapshot = await uploadTask;

    String url = await taskSnapshot.ref.getDownloadURL();

    return url;
  }

  List<Map<String, dynamic>> parkourListAsMap = [
    {
      "name": "1 parkur",
      "id": "1",
      "checkPointCount": "10",
      "checkPointList": [],
      "mapImage": "",
      "leaderBoard": "",
      "createdDate": "",
      "createdBy": "Ece",
    },
    {
      "name": "2 parkur",
      "id": "2",
      "checkPointCount": "5",
      "checkPointList": [],
      "mapImage": "",
      "leaderBoard": "",
      "createdDate": "",
      "createdBy": "Yigit",
    },
    {
      "name": "3 parkur",
      "id": "3",
      "checkPointCount": "5",
      "checkPointList": [],
      "mapImage": "",
      "leaderBoard": "",
      "createdDate": "",
      "createdBy": "Yigit",
    }
  ];
  Future<List<ParkourModel>> getParkours() async {
    var snapshot = await firebaseFirestore.collection("parkours").get();
    List<ParkourModel> parkours = [];
    for (var parkourAsMap in snapshot.docs) {
      parkours.add(ParkourModel.fromJson(parkourAsMap.data()));
    }
    return parkours;
  }

  void addAllParkours() async {
    var existingParkours = await firebaseFirestore.collection("parkous");
    //parkur var mı yok mu? id üzerinden bak.
    for (var parkourAsMap in parkourListAsMap) {
      addParkour(ParkourModel.fromJson(parkourAsMap));
    }
  }

  Future<List<File>> pickImages() async {
    List<File> imageFiles = [];

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withData: true,
      type: FileType.image,
    );
    if (result != null) {
      for (var item in result.files) {
        if (item.bytes != null) {
          // io.File file = await compressImage(item.path!);

          // imageFiles.add(

          //   FileModel(
          //   fileTypeExtension:
          //       item.extension == "svg" ? "svg+xml" : item.extension!,
          //   file: file,
          //   fileBytes: await file.readAsBytes(),
          //   fileName: item.name,
          // )

          //    );

          //  imageFiles.add(item);
        }
      }
    }
    return imageFiles;
  }

  void addParkour(ParkourModel parkourmodel) async {
    File? mapImage;

    parkourmodel.mapImageUrl = await uploadSingleFile(
        file: mapImage, childPath: "parkours/${parkourmodel.id}");

    var ref = firebaseFirestore.collection("parkours").doc(); //123 id

    parkourmodel.id = ref.id;

    await firebaseFirestore
        .collection("parkours")
        .doc(ref.id)
        .set(parkourmodel.toJson());
  }

  updateParkour(ParkourModel parkourmodel) async {
    await firebaseFirestore
        .collection("parkours")
        .doc(parkourmodel.id)
        .update(parkourmodel.toJson());
  }
}
