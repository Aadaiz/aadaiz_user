import 'dart:convert';

class BannerListRes {
  bool? success;
  dynamic message;
  List<Datum>? data;

  BannerListRes({
    this.success,
    this.message,
    this.data,
  });

  factory BannerListRes.fromJson(String str) => BannerListRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BannerListRes.fromMap(Map<String, dynamic> json) => BannerListRes(
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
  dynamic title;
  dynamic imageUrl;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  Datum({
    this.id,
    this.title,
    this.imageUrl,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"]??null,
    title: json["title"]??null,
    imageUrl: json["image_url"]??null,
    status: json["status"]??null,
    createdAt: json["created_at"]??null,
    updatedAt: json["updated_at"] ??null,
  );

  Map<String, dynamic> toMap() => {
    "id": id??null,
    "title": title??null,
    "image_url": imageUrl??null,
    "status": status??null,
    "created_at": createdAt??null,
    "updated_at": updatedAt??null,
  };
}
