import 'dart:convert';

class GenderRes {
  bool? success;
  dynamic message;
  List<Datum>? data;

  GenderRes({
    this.success,
    this.message,
    this.data,
  });

  factory GenderRes.fromJson(String str) => GenderRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GenderRes.fromMap(Map<String, dynamic> json) => GenderRes(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Datum {
  dynamic id;
  dynamic catName;
  dynamic imageUrl;

  Datum({
    this.id,
    this.catName,
    this.imageUrl,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"]??null,
    catName: json["cat_name"]??null,
    imageUrl: json["image_url"]??null,
  );

  Map<String, dynamic> toMap() => {
    "id": id??null,
    "cat_name": catName??null,
  "image_url": imageUrl??null,
  };
}
