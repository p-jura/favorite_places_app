import 'package:favorite_places/models/place_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../helper/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({required this.onSelectPlace, Key? key})
      : super(key: key);
  final Function onSelectPlace;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  final initialLocation =
      const PlaceLocation(latitude: 37.4216863, longitude: -122.0842771);
  String? _previewImageUrl;
  PlaceLocation? _currentLocation;

  @override
  initState() {
    _getUserLocationNow();

    super.initState();
  }

  void _showImagePreview(double latitude, double longitude) {
    final staticpreviewImageUrl = LocationHelper.generateLocationImageHelper(
        latitude: latitude, longitude: longitude);
    setState(() {
      _previewImageUrl = staticpreviewImageUrl;
    });
  }

  Future<void> _getUserLocationNow() async {
    final LocationData locationData = await Location().getLocation();
    _currentLocation = PlaceLocation(
        latitude: locationData.latitude!, longitude: locationData.longitude!);
  }

  Future<void> _getUserLocation() async {
    try {
      final locData = await Location().getLocation();
      _showImagePreview(locData.latitude!, locData.longitude!);
    } catch (error) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(
          isSelectingPlace: true,
          initialLocation:
              _currentLocation == null ? initialLocation : _currentLocation!,
        ),
      ),
    ) as LatLng?;

    if (selectedLocation == null) {
      return;
    }
    _showImagePreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(
        latitude: selectedLocation.latitude,
        longitude: selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: colorTheme.primary)),
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          child: _previewImageUrl == null
              ? const Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                primary: colorTheme.secondary,
              ),
              onPressed: () {
                _getUserLocation();
              },
              icon: const Icon(Icons.location_on),
              label: const Text(
                'Current Location',
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                primary: colorTheme.secondary,
              ),
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map_outlined),
              label: const Text(
                'Select place on map',
              ),
            ),
          ],
        )
      ],
    );
  }
}
