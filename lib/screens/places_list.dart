import 'package:favorite_places/screens/add_places.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places_provider.dart';
import '../screens/place_detail.dart';
import '../constants/constatns.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: defoultGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: apBarDefoultGradient),
          ),
          title: const Text(
            'Your Favorite places',
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlacesScreen.routName);
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<PlacesProvider>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(
                  strokeWidth: 5,
                ))
              : Consumer<PlacesProvider>(
                  child: Center(
                    child: Text('No favorit places yet, please add some.',
                        style: defoultTextTheme.headline6),
                  ),
                  builder: (context, placesProvider, child) => placesProvider
                          .items.isEmpty
                      ? child!
                      : ListView.builder(
                          itemCount: placesProvider.items.length,
                          itemBuilder: (ctx, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3.0, horizontal: 8),
                            child: ListTile(
                              tileColor: defoultColorScheme.background,
                              leading: CircleAvatar(
                                backgroundImage: FileImage(
                                    placesProvider.items[index].image),
                              ),
                              title: Text(placesProvider.items[index].title),
                              subtitle: Text(
                                  placesProvider.items[index].location.adress!,
                                  maxLines: 1),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    PlaceDetailScreen.routName,
                                    arguments: placesProvider.items[index].id);
                              },
                            ),
                          ),
                        ),
                ),
        ),
      ),
    );
  }
}
