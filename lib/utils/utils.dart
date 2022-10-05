import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sra_qatra/services/location_service.dart';

class Utils {
  static final Connectivity _connectivity = Connectivity();
  static displaySnackbar(value, context) {
    var snackBar = SnackBar(
      content: Text(value),
      backgroundColor: const Color.fromRGBO(244, 66, 54, 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // static Future<Position> getPosition(context) async {
  //   Position? position;
  //   try {
  //     position = await LocationService.determinePosition();
  //   } on LocationServiceDisabledException catch (e) {
  //     displaySnackbar(e.toString(), context);
  //   }
  //   return position!;
  // }

  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static Future<bool> checkConnection() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}
