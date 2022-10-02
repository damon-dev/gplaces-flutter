import 'dart:convert';
import 'dart:typed_data';

import 'package:collection/collection.dart';

/// The FetchPhotoResponse contains [Photo]
class FetchPhotoResponse {
  ///Returns the requested image data.
  final Uint8List? imageBytes;

  FetchPhotoResponse({this.imageBytes});

  factory FetchPhotoResponse.fromJson(Map<String, dynamic> json) {
    final bytes =
        (json["imageBytes"] as List<dynamic>?)?.map((e) => e as int).toList();

    return FetchPhotoResponse(
      imageBytes: bytes == null ? null : Uint8List.fromList(bytes),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'imageBytes': imageBytes,
      };

  static FetchPhotoResponse parseResult(String responseBody) {
    final parsed = json.decode(responseBody).cast<String, dynamic>();
    return FetchPhotoResponse.fromJson(parsed);
  }

  @override
  bool operator ==(o) =>
      o is FetchPhotoResponse &&
      const ListEquality().equals(o.imageBytes, imageBytes);

  @override
  int get hashCode => imageBytes.hashCode;
}
