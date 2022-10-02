import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
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
  final List<PlaceLikelihood> _placeLikelihoods = [];
  Uint8List? _imageBytes;
  late PlacesClient _placesClient;

  @override
  void initState() {
    _setupClient();
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
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.grey,
                width: double.infinity,
                height: double.infinity,
                child: _imageBytes != null
                    ? Image.memory(_imageBytes!)
                    : const SizedBox.shrink(),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  ListView.separated(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                            "${_autocompletePredictions[index].description}"),
                      );
                    },
                    itemCount: _autocompletePredictions.length,
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                  ),
                  ListView.separated(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                            "(${_placeLikelihoods[index].likelihood?.toStringAsFixed(2)}): ${_placeLikelihoods[index].place?.address}"),
                      );
                    },
                    itemCount: _placeLikelihoods.length,
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future fetchAutocompletePredictions() async {
    if (await Places.isInitialized) {
      final request = FindAutocompletePredictionsRequest(
        query: 'Delhi',
        countries: ["in"],
        origin: LatLng(latitude: 28.3670, longitude: 79.4304),
        locationBias: LocationBias(
          southwest: LatLng(latitude: -33.880490, longitude: 151.184363),
          northeast: LatLng(latitude: -33.858754, longitude: 151.229596),
        ),
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

  Future fetchPhoto(String placeId) async {
    final placeResponse = await fetchPlace(placeId);
    final metaData = placeResponse?.place?.photoMetadatas;
    if (await Places.isInitialized && metaData != null && metaData.isNotEmpty) {
      final request = FetchPhotoRequest(photoMetaData: metaData[0]);
      _placesClient.fetchPhoto(request: request).then((response) {
        setState(() {
          _imageBytes = response?.imageBytes;
        });
      });
    }
  }

  Future<FetchPlaceResponse?> fetchPlace(String placeId) async {
    if (await Places.isInitialized) {
      final request = FetchPlaceRequest(
        placeId: placeId,
        placeFields: [Field.PHOTO_METADATAS],
      );

      return _placesClient.fetchPlace(request: request);
    }

    return null;
  }

  Future findCurrentPlace() async {
    if (await _permissionsGranted && await Places.isInitialized) {
      final request = FindCurrentPlaceRequest(
          placeFields: [Field.ADDRESS, Field.PHOTO_METADATAS, Field.ID]);
      _placesClient.findCurrentPlace(request: request).then((response) {
        setState(() {
          _placeLikelihoods.addAll(response?.placeLikelihoods ?? []);
        });
      });
    }
  }

  Future _setupClient() async {
    await Places.initialize(showLogs: true);
    _placesClient = Places.createClient();
    //fetchPlace("ChIJHZyasTQBoDkRj53m5ZpLdSM");
    //fetchAutocompletePredictions();
    fetchPhoto("ChIJHZyasTQBoDkRj53m5ZpLdSM");
    findCurrentPlace();
  }

  Future<bool> get _permissionsGranted async {
    return await Permission.locationWhenInUse.request().isGranted ||
        await Permission.locationAlways.request().isGranted;
  }
}
