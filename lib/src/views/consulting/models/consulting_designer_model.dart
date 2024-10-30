import 'dart:convert';

class ConsultingDesignerRes {
  bool? success;
  dynamic message;
  List<Designer>? data;

  ConsultingDesignerRes({
    this.success,
    this.message,
    this.data,
  });

  factory ConsultingDesignerRes.fromJson(String str) => ConsultingDesignerRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConsultingDesignerRes.fromMap(Map<String, dynamic> json) => ConsultingDesignerRes(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Designer>.from(json["data"]!.map((x) => Designer.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Designer {
  dynamic id;
  dynamic categoryId;
  dynamic designerPreferenceId;
  dynamic name;
  dynamic email;
  dynamic password;
  dynamic gender;
  dynamic category;
  dynamic profileImage;
  dynamic about;
  dynamic avgRate;
  dynamic totalRate;
  DateTime? createdAt;
  DateTime? updatedAt;

  Designer({
    this.id,
    this.categoryId,
    this.designerPreferenceId,
    this.name,
    this.email,
    this.password,
    this.gender,
    this.category,
    this.profileImage,
    this.about,
    this.avgRate,
    this.totalRate,
    this.createdAt,
    this.updatedAt,
  });

  factory Designer.fromJson(String str) => Designer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Designer.fromMap(Map<String, dynamic> json) => Designer(
    id: json["id"],
    categoryId: json["category_id"],
    designerPreferenceId: json["designer_preference_id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    gender: json["gender"],
    category: json["category"],
    profileImage: json["profile_image"],
    about: json["about"],
    avgRate: json["avg_rate"],
    totalRate: json["total_rate"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "category_id": categoryId,
    "designer_preference_id": designerPreferenceId,
    "name": name,
    "email": email,
    "password": password,
    "gender": gender,
    "category": category,
    "profile_image": profileImage,
    "about": about,
    "avg_rate": avgRate,
    "total_rate": totalRate,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
