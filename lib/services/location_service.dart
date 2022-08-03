import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position> determinePosition() async {
    //bool serviceEnabled;
    LocationPermission permission;

    //serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   await Geolocator.openLocationSettings();
    //   return Future.error('Location service are disable');
    // }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permission are permanently denied. we cannot request permission');
    }
    return await Geolocator.getCurrentPosition();
  }
}
