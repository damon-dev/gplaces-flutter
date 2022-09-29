import 'dart:async';

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
  final List<AutocompletePrediction> _autocompletePredictions = [];
  late PlacesClient _placesClient;

  @override
  void initState() {
    Places.initialize();
    _placesClient = Places.createClient();
    _fetchAutocompletePredictions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('gplaces'),
        ),
        body: ListView.separated(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Text("${_autocompletePredictions[index].description}"),
            );
          },
          itemCount: _autocompletePredictions.length,
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ),
      ),
    );
  }

  Future _fetchAutocompletePredictions() async {
    if (await Places.isInitialized) {
      final request = FindAutocompletePredictionsRequest(
        query: 'Delhi',
        countries: ["in"],
      );

      _placesClient
          .findAutoCompletePredictions(request: request)
          .then((response) {
        setState(() {
          _autocompletePredictions
              .addAll(response?.autocompletePredictions ?? []);
        });
      });
    }
  }
}
