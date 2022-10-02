class PlusCode {
  ///Returns the compound plus code, e.g. "9G8F+5W Zurich, Switzerland".
  String? compoundCode;

  ///Returns the geo plus code, e.g. "8FVC9G8F+5W".
  String? globalCode;

  PlusCode({
    this.compoundCode,
    this.globalCode,
  });

  factory PlusCode.fromJson(Map<String, dynamic> json) {
    return PlusCode(
      compoundCode: json["compoundCode"] as String?,
      globalCode: json["globalCode"] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'compoundCode': compoundCode,
        'globalCode': globalCode,
      };

  @override
  bool operator ==(other) =>
      other is PlusCode &&
      other.compoundCode == compoundCode &&
      other.globalCode == globalCode;

  @override
  int get hashCode => compoundCode.hashCode ^ globalCode.hashCode;
}
