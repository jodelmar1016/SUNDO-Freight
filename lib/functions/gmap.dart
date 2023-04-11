import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Gmap {
  static String apiKey = 'AIzaSyCc7-GEEUjHx-yM0yClaSAmsuWH7H7wfck';

  static Future<String> getDistance(LatLng origin, LatLng destination) async {
    String url =
        "https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=${origin.latitude},${origin.longitude}&destinations=${destination.latitude},${destination.longitude}&key=$apiKey";

    var response = await http.get(Uri.parse(url));
    var jsonResponse = jsonDecode(response.body);

    String distanceText =
        jsonResponse["rows"][0]["elements"][0]["distance"]["text"];
    double distanceValue = jsonResponse["rows"][0]["elements"][0]["distance"]
            ["value"] /
        1000; // Convert meters to kilometers

    return distanceText;
  }

  static Future<String> getDuration(LatLng origin, LatLng destination) async {
    String url =
        "https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=${origin.latitude},${origin.longitude}&destinations=${destination.latitude},${destination.longitude}&key=$apiKey";

    var response = await http.get(Uri.parse(url));
    var jsonResponse = jsonDecode(response.body);

    String durationText =
        jsonResponse["rows"][0]["elements"][0]["duration"]["text"];
    double durationValue =
        jsonResponse["rows"][0]["elements"][0]["duration"]["value"];

    return durationText;
  }

  Future<String> getPlaceName(LatLng point) async {
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${point.latitude},${point.longitude}&key=$apiKey";

    var response = await http.get(Uri.parse(url));
    var jsonResponse = jsonDecode(response.body);

    if (jsonResponse["status"] == "OK") {
      String address = jsonResponse["results"][0]["formatted_address"];
      return address;
    } else {
      return "Unable to find address for the given location";
    }
  }
}
