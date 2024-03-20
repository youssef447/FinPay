import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<dynamic> getPosition() async {
    ///Returns a [Future] indicating if the user allows the App to access the device's location.

    bool enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      var check = await Geolocator.checkPermission();

      if (check == LocationPermission.denied) {
        var permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again
          return 'Location permissions are denied';
        }

        if (permission == LocationPermission.deniedForever) {
          // Permissions are denied forever, handle appropriately.
          return 'Location permissions are permanently denied, we cannot request permissions.';
        }
      }
    }
    if(!enabled) {
    //  return 'Location is Disabled';
    return;
    }

    //now i'm sure i got the permission
    //get location..returns LocationData object
    var currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true);
    return currentLocation;
  }

  Future<String> getAddress() async {
    try {
      final response = await getPosition();
      if (response is String) {
        return response;
      } else {
        List<Placemark> placemark = await placemarkFromCoordinates(
          response.latitude,
          response.longitude,
        );

        String country = placemark[0].country!;

        String state = placemark[0].administrativeArea!;
        String city = state.split(" ")[0];
        //String street = placemark[0].street!;
        return '$city, $country';
      }
    } catch (e) {
      return Future.value(e.toString());
    }
  }
}
