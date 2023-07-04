import 'dart:developer';
import 'dart:io' as io;

import 'package:check_point/models/file_model.dart';
import 'package:check_point/models/parkour_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

class ParkourService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadSingleFile(
      {required io.File? file, required String childPath}) async {
    Reference firebaseStorageRef = firebaseStorage.ref().child(childPath);
    UploadTask uploadTask = firebaseStorageRef.putFile(file!);

    TaskSnapshot taskSnapshot = await uploadTask;

    String url = await taskSnapshot.ref.getDownloadURL();

    return url;
  }

  List<Map<String, dynamic>> parkourListAsMap = [];

  Future<List<ParkourModel>> getParkours() async {
    var snapshot = await firebaseFirestore.collection("parkours").get();

    List<ParkourModel> parkours = [];

    for (var parkourAsMap in snapshot.docs) {
      parkours.add(ParkourModel.fromJson(parkourAsMap.data()));
    }
    return parkours;
  }

  /*
  void addAllParkours() async {
    var existingParkours = firebaseFirestore.collection("parkous");
    //parkur var mı yok mu? id üzerinden bak.
    for (var parkourAsMap in parkourListAsMap) {
      addParkour(ParkourModel.fromJson(parkourAsMap));
    }
  }
  */

  Future<io.File> compressImage(String path) async {
    return await FlutterNativeImage.compressImage(path,
        quality: 30, percentage: 50);
  }

  Future<List<FileModel>> pickParkourImages() async {
    List<FileModel> imageFiles = [];

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withData: true,
      type: FileType.image,
    );
    if (result != null) {
      for (var item in result.files) {
        if (item.bytes != null) {
          io.File file = await compressImage(item.path!);

          imageFiles.add(FileModel(
            fileTypeExtension:
                item.extension == "svg" ? "svg+xml" : item.extension!,
            file: file,
            fileBytes: await file.readAsBytes(),
            fileName: item.name,
          ));
        }
      }
    }
    return imageFiles;
  }

  Future<void> addParkour(ParkourModel parkourmodel) async {
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
