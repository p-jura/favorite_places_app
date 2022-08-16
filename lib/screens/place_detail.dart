import 'package:favorite_places/models/place_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/places_provider.dart';
import '../screens/map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({Key? key}) : super(key: key);
  static const routName = '/place-detail-screen';
  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final String id = ModalRoute.of(context)!.settings.arguments as String;
    final selectedPlace =
        Provider.of<PlacesProvider>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              selectedPlace.location.adress!,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                onPrimary: colorTheme.onSecondary,
                primary: colorTheme.secondary),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => MapScreen(
                    initialLocation: PlaceLocation(
                        latitude: selectedPlace.location.latitude,
                        longitude: selectedPlace.location.longitude),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.map_outlined),
            label: const Text(
              'View on map',
            ),
          ),
        ],
      ),
    );
  }
}
