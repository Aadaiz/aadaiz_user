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

  factory MaterialRes.fromJson(String str) =>
      MaterialRes.fromMap(json.decode(str));

  factory MaterialRes.fromMap(Map<String, dynamic> json) {
    return MaterialRes(
      success: json["success"],
      message: json["message"],

      /// 🔥 HANDLE BOTH [] AND {}
      data: json["data"] is Map<String, dynamic>
          ? Data.fromMap(json["data"])
          : null,
    );
  }
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
