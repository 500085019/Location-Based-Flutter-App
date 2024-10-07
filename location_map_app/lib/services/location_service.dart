import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class LocationService {
  static Future<LatLng> getCoordinatesFromAddress(String address) async {
    List<Location> locations = await locationFromAddress(address);
    return LatLng(locations.first.latitude, locations.first.longitude);
  }
}
