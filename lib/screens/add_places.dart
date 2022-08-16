// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';

import '../providers/places_provider.dart';
import '../widgets/image_input.dart';
import '../models/place_model.dart';
import '../widgets/location_input.dart';
import '../constants/constatns.dart';

class AddPlacesScreen extends StatefulWidget {
  const AddPlacesScreen({Key? key}) : super(key: key);
  static const routName = '/add_places';
  @override
  State<AddPlacesScreen> createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends State<AddPlacesScreen> {
  File? _pickedImage;
  PlaceLocation? _pickedLocation;
  String? _formFieldTitle;
  // ignore: prefer_final_fields
  var _formKey = GlobalKey<FormState>();

  void _selectImage(File pickImage) {
    _pickedImage = pickImage;
  }

  void _selectPlace({required double latitude, required double longitude}) {
    _pickedLocation = PlaceLocation(latitude: latitude, longitude: longitude);
  }

  void _savePlace() {
    if (_pickedImage == null || _pickedLocation == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error'),
          content: const Text(
              'You cant save the file. Error coused by image file is missing'),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
      return;
    }
    _formKey.currentState!.save();
    Provider.of<PlacesProvider>(context, listen: false)
        .addPlace(_formFieldTitle!, _pickedImage!, _pickedLocation!);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: defoultGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          flexibleSpace: Container(
              decoration: const BoxDecoration(gradient: apBarDefoultGradient)),
          title: const Text('Add a new place'),
        ),
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Title',
                          ),
                          validator: (value) {
                            try {
                              if (value!.isEmpty) {
                                return 'Enter a title';
                              }
                            } catch (error) {
                              return 'Null value';
                            }
                            return null;
                          },
                          onSaved: (titleValue) {
                            _formFieldTitle = titleValue;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ImageInput(onSelectImage: _selectImage),
                        const SizedBox(
                          height: 10,
                        ),
                        LocationInput(
                          onSelectPlace: _selectPlace,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF89B73A),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
              ),
              onPressed: () {
                _formKey.currentState!.validate();
                _savePlace();
              },
              clipBehavior: Clip.hardEdge,
              icon: const Icon(Icons.add),
              label: const Text(
                'Add Places',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
