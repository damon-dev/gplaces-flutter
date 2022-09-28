class Metadata {
  String? attributions;
  int? width;
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
