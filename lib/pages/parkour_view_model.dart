import 'package:check_point/models/parkour_model.dart';
import 'package:check_point/service/parkour_service.dart';

class ParkourViewModel {
  ParkourViewModel._private();

  static final ParkourViewModel _instance = ParkourViewModel._private();

  factory ParkourViewModel() {
    return _instance;
  }

  List<ParkourModel> parkours = [];
  Future<void> getParkours() async {
    parkours = await ParkourService().getParkours();

    ParkourViewModel();
  }
}
