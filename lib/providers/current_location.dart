import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class TRVUCurrentLocation with ChangeNotifier {
  double latitude = 25.2923;
  double longitude = 55.3711;

  TRVUCurrentLocation({required latitude, required longitude});

  Future<void> getCurrentLocation() async {
    Location currentLocationObj = Location();

    bool _serviceEnabled = await currentLocationObj.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await currentLocationObj.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    PermissionStatus _permissionGranted =
        await currentLocationObj.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await currentLocationObj.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData currentLocation = await currentLocationObj.getLocation();
    longitude = currentLocation.longitude!;
    latitude = currentLocation.latitude!;
    notifyListeners();
  }

  void setToCoordinates(LatLng newLocation) {
    longitude = newLocation.longitude;
    latitude = newLocation.latitude;
    notifyListeners();
  }
}
