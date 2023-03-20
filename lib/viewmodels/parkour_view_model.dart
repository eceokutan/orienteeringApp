import 'package:check_point/models/file_model.dart';
import 'package:check_point/models/parkour_model.dart';
import 'package:check_point/service/parkour_service.dart';

class ParkourViewModel {
  ParkourViewModel._private();

  static final ParkourViewModel _instance = ParkourViewModel._private();

  factory ParkourViewModel() {
    return _instance;
  }

  List<FileModel> parkourImages = [];

  List<ParkourModel> parkours = [];

  Future<void> pickParkourImages() async {
    parkourImages = await ParkourService().pickParkourImages();
  }

  Future<String> uploadImage(FileModel file) async {
    return await ParkourService().uploadSingleFile(
        file: file.file, childPath: "parkourImages/${file.fileName}");
  }

  Future<void> addNewParkour(ParkourModel parkour) async {
    await ParkourService().addParkour(parkour);
  }

  Future<void> getParkours() async {
    parkours = await ParkourService().getParkours();
  }
}
