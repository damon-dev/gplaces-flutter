# GPlaces

![tests](https://github.com/factoryplus/gplaces-flutter/actions/workflows/main.yml/badge.svg?branch=master)

## 👋 Introduction
**GPlaces** provides programmatic access to Google's database of local place and business information, as well as the device's current place.

It uses the [Places SDK for Android](https://developers.google.com/maps/documentation/places/android-sdk/overview) API on Android and the [Places SDK for iOS](https://developers.google.com/maps/documentation/places/ios-sdk/overview) on iOS.

## ⚡ Features
Help your customers explore where they are and what’s around them:

* **Place Autocomplete** automatically fills in the name and/or address of a place as users type.
* **Current Place** returns a list of places where the user’s device is last known to be located along with an indication of the relative likelihood for each place.
* **Place Details** return and display more detailed information about a place.
* **Place Photos** returns high-quality images of a place.

## 🚀 Installation
Include the latest **gplaces** in your `pubspec.yaml`
```yaml
dependencies:
  ...
  gplaces: ^0.0.1
  ...
```

## 🔑 Generate App key
1. Go to the Google Maps Platform > [Credentials page](https://console.cloud.google.com/projectselector2/google/maps-apis/credentials).
2. On the Credentials page, click Create credentials > API key. The API key created dialog displays your newly created API key.
3. Click Close.The new API key is listed on the Credentials page under API keys.(Remember to restrict the API key before using it in production.)

* For **Android** add it to `AndroidManifest.xml`:
```xml
<application>  
...  
<activity>  
.. </activity>

<meta-data android:name="com.google.android.geo.API_KEY" android:value="PASTE_YOUR_API_KEY_HERE"/>  
...  
</application>  
```

* For **iOS** add it to `Info.plist`:
```html
<key>GooglePlaceKey</key>
<string>PASTE_YOUR_API_KEY_HERE</string>
```

## 📑 Documentation & Example
* Checkout our GPlace [Usage documentation](doc/USAGE.md)
* Checkout our [Example Dart project](./example)

Issues & pull requests are more than welcome!
