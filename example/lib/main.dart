import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:places_autocomplete/places_autocomplete.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //List<PlacePrediction>? _predictions = [];
  final _placesAutocompletePlugin = PlacesAutocomplete();

  @override
  void initState() {
    super.initState();
    //_setupPredictions();
    _setupDetails();
  }

  /*Future _setupPredictions() async {
    await _placesAutocompletePlugin.initializePlaces();
    if (await _placesAutocompletePlugin.isInitialized) {
      _predictions = (await _placesAutocompletePlugin.getPredictions(
            query: 'Phonix Bareilly',
            countries: ["in"],
          ))
              ?.predictions ??
          [];
      print(_predictions);
    }
  }*/

  Future _setupDetails() async {
    await _placesAutocompletePlugin.initializePlaces();
    if (await _placesAutocompletePlugin.isInitialized) {
      final details = await _placesAutocompletePlugin.getPlaceDetails(
        placeId: "ChIJHZyasTQBoDkRj53m5ZpLdSM",
        fields: [Field.PHOTO_METADATAS, Field.TYPES],
      );

      if (kDebugMode) {
        print(jsonEncode(details?.details));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const Center(
          child: Text('Places initialized'),
        ),
      ),
    );
  }
}
