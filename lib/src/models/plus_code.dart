class PlusCode {
  String? compoundCode;
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
}
