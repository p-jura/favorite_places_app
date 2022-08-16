import 'dart:convert';

import 'package:http/http.dart' as http;

// ignore: constant_identifier_names
const GOOGLE_API_KEY = 'PASTE_YOUR_API_KEY';

class LocationHelper {
  static String generateLocationImageHelper(
      {required double latitude, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=12&size=600x300&key=$GOOGLE_API_KEY&markers=color:red%7Clabel:C%7C$latitude,$longitude';
  }

  static Future<String> getPlaceAdress(
      double latitude, double longitude) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$GOOGLE_API_KEY');

    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
