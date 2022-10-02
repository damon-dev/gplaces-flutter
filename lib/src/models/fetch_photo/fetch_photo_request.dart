import 'package:gplaces/src/models/photo_metadatas.dart';

class FetchPhotoRequest {
  ///The [photoMetadata] of the image returned by the Place Photos service.
  final Metadata photoMetaData;

  ///The maximum width in pixels of the image returned
  ///by the Place Photos service.
  final int? maxWidth;

  ///The maximum height in pixels of the image returned
  ///by the Place Photos service.
  final int? maxHeight;

  FetchPhotoRequest({
    required this.photoMetaData,
    this.maxWidth,
    this.maxHeight,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'photoMetaData': photoMetaData.toJson(),
        'maxWidth': maxWidth,
        'maxHeight': maxHeight,
      };

  Map<String, dynamic> get arguments => <String, dynamic>{
        'photoRequest': toJson(),
      };
}
