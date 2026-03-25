import 'dart:convert';

class LikePostRes {
  bool? status;
  Data? data;
  String? message;

  LikePostRes({
    this.status,
    this.data,
    this.message,
  });

  factory LikePostRes.fromJson(String str) => LikePostRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LikePostRes.fromMap(Map<String, dynamic> json) => LikePostRes(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": data?.toMap(),
    "message": message,
  };
}

class Data {
  int? id;
  String? userId;
  String? postId;
  bool? isLiked;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.userId,
    this.postId,
    this.isLiked,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    postId: json["post_id"],
    isLiked: json["is_liked"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "post_id": postId,
    "is_liked": isLiked,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
