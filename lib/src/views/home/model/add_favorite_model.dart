import 'dart:convert';

class AddFavoriteRes {
  dynamic success;
  dynamic message;
  Data? data;

  AddFavoriteRes({
    this.success,
    this.message,
    this.data,
  });

  factory AddFavoriteRes.fromJson(String str) => AddFavoriteRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddFavoriteRes.fromMap(Map<String, dynamic> json) => AddFavoriteRes(
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
  dynamic id;
  dynamic userId;
  dynamic patternId;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.userId,
    this.patternId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"]??null,
    userId: json["user_id"]??null,
    patternId: json["pattern_id"]??null,
    status: json["status"]??null,
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id??null,
    "user_id": userId??null,
    "pattern_id": patternId??null,
    "status": status??null,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
