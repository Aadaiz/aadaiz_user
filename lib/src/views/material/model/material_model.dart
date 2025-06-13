import 'dart:convert';

class MaterialRes {
  bool? success;
  String? message;
  Data? data;

  MaterialRes({
    this.success,
    this.message,
    this.data,
  });

  factory MaterialRes.fromJson(String str) => MaterialRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MaterialRes.fromMap(Map<String, dynamic> json) => MaterialRes(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message,
    "data": data?.toMap(),
  };
}

class Data {
  Data();

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
  );

  Map<String, dynamic> toMap() => {
  };
}
