import 'dart:convert';

class ConsultingCategoryRes {
  bool? success;
  dynamic message;
  List<ConsultingCategory>? data;

  ConsultingCategoryRes({
    this.success,
    this.message,
    this.data,
  });

  factory ConsultingCategoryRes.fromJson(String str) => ConsultingCategoryRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConsultingCategoryRes.fromMap(Map<String, dynamic> json) => ConsultingCategoryRes(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ConsultingCategory>.from(json["data"]!.map((x) => ConsultingCategory.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class ConsultingCategory {
  dynamic id;
  dynamic name;
  dynamic imageUrl;
  dynamic type;
  dynamic createdAt;
  dynamic updatedAt;

  ConsultingCategory({
    this.id,
    this.name,
    this.imageUrl,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory ConsultingCategory.fromJson(String str) => ConsultingCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConsultingCategory.fromMap(Map<String, dynamic> json) => ConsultingCategory(
    id: json["id"],
    name: json["name"],
    imageUrl: json["image_url"],
    type: json["type"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "image_url": imageUrl,
    "type": type,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
