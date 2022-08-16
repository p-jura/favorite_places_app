import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places_provider.dart';
import './screens/places_list.dart';
import './screens/add_places.dart';
import './screens/place_detail.dart';
import './constants/constatns.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PlacesProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: const Locale('pl'),
        title: 'Favorite Places',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          textTheme: defoultTextTheme,
        ),
        home: const PlacesListScreen(),
        routes: {
          AddPlacesScreen.routName: (ctx) => const AddPlacesScreen(),
          PlaceDetailScreen.routName: (ctx) => const PlaceDetailScreen(),
        },
      ),
    );
  }
}
