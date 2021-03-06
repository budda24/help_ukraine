import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pomoc_ukrainie/app/globals/global_controler.dart';


class GelocationServices {
  var globalController = Get.find<GlobalController>();
   Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      /* await globalController.box.writeIfNull(user!.uid, false); */
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

   Future<Placemark> GetAddressFromLatLong() async {
    var position = await getGeoLocationPosition();
    late Placemark place;


    if (position.latitude != null || position.altitude != null) {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude)
              .then((value) {
        return value;
      });
      place = placemarks[0];
      /* to write in the form field */

    }
    return place;
  }
}
