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
      // Location services are not enabled
      return false;
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied
        // you can try requesting permissions again
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever
      return false;
    }
  }

  Future<Position> getLocation() async {
    await isServiceEnabled();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    print("lat${position.latitude}");
    print("long${position.longitude}");
    return position;
  }

  getDistance(Position currentPosition, double checkPointPositionlatitude,
      double checkPointPositionlongitude) {
    return Geolocator.distanceBetween(
        currentPosition.latitude,
        currentPosition.longitude,
        checkPointPositionlatitude,
        checkPointPositionlongitude);
  }
}
