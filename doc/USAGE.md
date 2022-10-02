# Example Usage

## Initialization

```Dart
Future initialization() async {
  //Initialize Places SDK
  await Places.initialize();
  //Provide places client that exposes the Places API methods
  _placesClient = Places.createClient();
}
```

## Methods

#### Fetches autocomplete predictions

```Dart
Future fetchAutoCompletePredictions() async {
  //check whether the Places is initialized or not before using
  if(Places.isInitialized) {
    final request = FindCurrentPlaceRequest(
        placeFields: [Field.ADDRESS, Field.PHOTO_METADATAS, Field.ID]);
    _placeClient.findCurrentPlace(request: request).then((response) {
      ...
    });
  }
}
```

#### Fetches the details of a place.

```Dart
Future fetchPlaceDetails(String placeId, List<Field> fields) async {
  //check whether the Places is initialized or not before using
  if(Places.isInitialized) {
    final request = FetchPlaceRequest(
      placeId: placeId,
      placeFields: fields,
    );
    _placeClient.fetchPlace(request: request).then((response) {
      ...
    });
  }
}
```

#### Fetches the photo of a place

```Dart
Future fetchPlaceDetails() async {
  //check whether the Places is initialized or not before using
  if(Places.isInitialized) {
    //First fetch place details with required parameter Field.PHOTO_METADATAS
    final placeResponse = await fetchPlaceDetails("placeId", [Field.PHOTO_METADATAS]);
    final metaData = placeResponse?.place?.photoMetadatas;

    final request = FetchPhotoRequest(photoMetaData: metaData[0]);
    _placesClient.fetchPhoto(request: request).then((response) {
      ...
    });
  }
}
```

#### Fetches the approximate current location of the user's device.

Note: If your app does not use PlacesClient.findCurrentPlace(), explicitly remove the ACCESS_FINE_LOCATION permission introduced by the library by adding the following to your manifest:
```xml
<manifest ... xmlns:tools="http://schemas.android.com/tools">
    ...
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" tools:node="remove"/>
    ...
</manifest>
```
#### Requesting location authorization for iOS
For iOS your app must request permission to use location services. Add the NSLocationWhenInUseUsageDescription key to your Info.plist file, to define the string informing the user why you need the location services. For example:
```html
<key>NSLocationWhenInUseUsageDescription</key>
<string>Show your location on the map</string>
```

```Dart
Future fetchCurrentLocation(List<Field> fields) async {
  //check whether the Places is initialized or not before using
  //check required location permissions
  if (await _permissionsGranted && await Places.isInitialized) {
    final request = FindCurrentPlaceRequest(
        placeFields: [Field.ADDRESS, Field.PHOTO_METADATAS, Field.ID]);
    _placesClient.findCurrentPlace(request: request).then((response) {
      ...
    });
  }
}
```

### For more information,

- [See Example Application](/example/lib/main.dart).