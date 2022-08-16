// ignore_for_file: prefer_final_fields

import 'package:flutter/foundation.dart';
import 'dart:io';
import '../models/place_model.dart';
import '../helper/db_helper.dart';
import '../helper/location_helper.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  Future<void> addPlace(String pickedTitle, File pickedImage,
      PlaceLocation pickedLocation) async {
    final pickedLocationAdress = await LocationHelper.getPlaceAdress(
        pickedLocation.latitude, pickedLocation.longitude);

    final newPlace = Place(
      id: DateTime.now().toIso8601String(),
      title: pickedTitle,
      image: pickedImage,
      location: PlaceLocation(
        adress: pickedLocationAdress,
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
      ),
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'imagePath': newPlace.image.path,
      'loc_langitude': newPlace.location.latitude,
      'loc_longitude': newPlace.location.longitude,
      'loc_adress': newPlace.location.adress!,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['imagePath']),
            location: PlaceLocation(
              latitude: item['loc_langitude'],
              longitude: item['loc_longitude'],
              adress: item['loc_adress'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
