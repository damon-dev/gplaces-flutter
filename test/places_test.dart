import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gplaces/gplaces.dart';
import 'package:gplaces/src/constants/plugin.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannel methodChannel = const MethodChannel(CHANNEL_NAME);
  methodChannel.setMockMethodCallHandler((call) async {
    switch (call.method) {
      case Methods.INITIALIZE:
        return Future(() => "Initialized");
      case Methods.IS_INITIALIZE:
        return Future(() => true);
    }
  });

  test(
    "provides programmatic access to Google's database of local place and business information, as well as the device's current place",
    () async {
      await Places.initialize();
    },
  );

  test(
    'Returns true if places is initialized',
    () async {
      final response = await Places.isInitialized;
      expect(response, true);
    },
  );
}
