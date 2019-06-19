//import 'package:geolocator/geolocator.dart';
//
import 'package:geocoder/geocoder.dart';

Future<String> locationNameOfCoordinates(
    {double latitude, double longitude}) async {
  var placemark = await Geocoder.local
      .findAddressesFromCoordinates(Coordinates(latitude, longitude));
  return placemark.first.addressLine;
}
