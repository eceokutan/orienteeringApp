import 'package:geolocator/geolocator.dart';

class GpsService {
  GpsService._();

  static final GpsService _instance = GpsService._();

  factory GpsService() {
    return _instance;
  }

  Future isServiceEnabled() async {
    LocationPermission permission;

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      print(Future.error('Location services are disabled.'));
      return false;
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        print(Future.error('Location permissions are denied'));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      print(Future.error(
          'Location permissions are permanently denied, we cannot request permissions.'));
      return false;
    }
  }


  Future<Position> getLocation() async {
    await isServiceEnabled();

  Position  position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }
}
