import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:places_autocomplete/places_autocomplete.dart';
import 'package:places_autocomplete/src/constants/plugin.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late PlacesClient placeClient;

  MethodChannel methodChannel = const MethodChannel(CHANNEL_NAME);
  methodChannel.setMockMethodCallHandler((call) async {
    switch (call.method) {
      case Methods.FETCH_PHOTO:
        return Future(
          () => jsonEncode(
            FetchPhotoResponse(
              imageBytes: Uint8List.fromList([1, 2]),
            ),
          ),
        );
      case Methods.FETCH_PLACE:
        return Future(
          () => jsonEncode(
            FetchPlaceResponse(place: Place(address: 'Address')),
          ),
        );
      case Methods.FIND_AUTO_COMPLETE_PREDICTIONS:
        return Future(
          () => jsonEncode(
            FindAutocompletePredictionsResponse(
              autocompletePredictions: [
                AutocompletePrediction(placeId: 'placeId')
              ],
            ),
          ),
        );
      case Methods.FIND_CURRENT_PLACE:
        return Future(
          () => jsonEncode(
            FindCurrentPlaceResponse(
              placeLikelihoods: [
                PlaceLikelihood(
                    likelihood: 0.2, place: Place(address: "address"))
              ],
            ),
          ),
        );
    }
  });

  setUp(() {
    Places.initialize(showLogs: false);
    placeClient = Places.createClient();
  });

  test(
    'Fetches a photo',
    () async {
      FetchPhotoRequest fetchPhotoRequest =
          FetchPhotoRequest(photoMetaData: Metadata());
      FetchPhotoResponse fetchPhotoResponse = FetchPhotoResponse(
        imageBytes: Uint8List.fromList([1, 2]),
      );

      final response = await placeClient.fetchPhoto(
        request: fetchPhotoRequest,
      );
      expect(response, fetchPhotoResponse);
    },
  );

  test(
    'Fetches the details of a place.',
    () async {
      FetchPlaceRequest fetchPlaceRequest =
          FetchPlaceRequest(placeId: 'placeId');
      FetchPlaceResponse fetchPlaceResponse = FetchPlaceResponse();

      final response = await placeClient.fetchPlace(
        request: fetchPlaceRequest,
      );
      expect(response, fetchPlaceResponse);
    },
  );

  test(
    'Fetches autocomplete predictions.',
    () async {
      FindAutocompletePredictionsRequest findAutocompletePredictionsRequest =
          FindAutocompletePredictionsRequest(query: "query");
      FindAutocompletePredictionsResponse findAutocompletePredictionsResponse =
          FindAutocompletePredictionsResponse(autocompletePredictions: [
        AutocompletePrediction(placeId: 'placeId'),
      ]);

      final response = await placeClient.findAutoCompletePredictions(
        request: findAutocompletePredictionsRequest,
      );

      expect(response, findAutocompletePredictionsResponse);
    },
  );

  test(
    "Fetches the approximate current location of the user's device.",
    () async {
      FindCurrentPlaceRequest findCurrentPlaceRequest =
          FindCurrentPlaceRequest(placeFields: [Field.ADDRESS]);
      FindCurrentPlaceResponse findCurrentPlaceResponse =
          FindCurrentPlaceResponse(
        placeLikelihoods: [
          PlaceLikelihood(
            likelihood: 0.2,
            place: Place(address: 'address'),
          )
        ],
      );

      final response = await placeClient.findCurrentPlace(
        request: findCurrentPlaceRequest,
      );

      expect(response, findCurrentPlaceResponse);
    },
  );
}
