import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final locationProvider = ChangeNotifierProvider((ref) => LocationProvider());

class LocationProvider extends ChangeNotifier {
  double latitude = 0.0;
  double longitude = 0.0;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitude = position.latitude;
      longitude = position.longitude;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
