import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/place_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(
      {this.initialLocation, this.isSelectingPlace = false, Key? key})
      : super(key: key);

  static const routName = '/map-screen';

  final PlaceLocation? initialLocation;
  final bool isSelectingPlace;
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;
  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your map'),
        actions: [
          if (widget.isSelectingPlace)
            IconButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
              icon: const Icon(Icons.check),
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(
              widget.initialLocation!.latitude,
              widget.initialLocation!.longitude,
            ),
            zoom: 16),
        onTap: widget.isSelectingPlace ? _selectLocation : null,
        markers: (_pickedLocation == null && widget.isSelectingPlace)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('marker-1'),
                  position: _pickedLocation ??
                      LatLng(widget.initialLocation!.latitude,
                          widget.initialLocation!.longitude),
                ),
              },
      ),
    );
  }
}
