import 'dart:io';

import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position> getCurrentLocation() async {
    if (Platform.isAndroid || Platform.isIOS) {
      return await Geolocator.getCurrentPosition();
    }

    return Position(
      longitude: 77.2090,
      latitude: 28.6139,
      timestamp: DateTime.now(),
      accuracy: 1,
      altitude: 0,
      altitudeAccuracy: 1,
      heading: 0,
      headingAccuracy: 1,
      speed: 0,
      speedAccuracy: 1,
    );
  }
}
