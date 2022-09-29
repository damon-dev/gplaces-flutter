class Metadata {
  ///Returns the attributions that must be shown to the user
  ///if this photo is displayed.
  ///The attributions in HTML format, or an empty String if there are none.
  String? attributions;

  ///Returns the maximum width in which this photo is available.
  int? width;

  ///Returns the maximum height in which this photo is available.
  int? height;

  Metadata({
    this.attributions,
    this.width,
    this.height,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      attributions: json['attributions'] as String?,
      width: json['width'] as int?,
      height: json['height'] as int?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'attributions': attributions,
        'width': width,
        'height': height,
      };
}
