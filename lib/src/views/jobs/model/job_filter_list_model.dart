import 'dart:convert';

class JobFilterListRes {
  bool? status;
  Data? data;
  String? message;

  JobFilterListRes({
    this.status,
    this.data,
    this.message,
  });

  factory JobFilterListRes.fromJson(String str) => JobFilterListRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory JobFilterListRes.fromMap(Map<String, dynamic> json) => JobFilterListRes(
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
  List<String>? salary;
  List<String>? type;
  List<Category>? category;

  Data({
    this.salary,
    this.type,
    this.category,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    salary: json["salary"] == null ? [] : List<String>.from(json["salary"]!.map((x) => x)),
    type: json["type"] == null ? [] : List<String>.from(json["type"]!.map((x) => x)),
    category: json["category"] == null ? [] : List<Category>.from(json["category"]!.map((x) => Category.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "salary": salary == null ? [] : List<dynamic>.from(salary!.map((x) => x)),
    "type": type == null ? [] : List<dynamic>.from(type!.map((x) => x)),
    "category": category == null ? [] : List<dynamic>.from(category!.map((x) => x.toMap())),
  };
}

class Category {
  int? id;
  String? adminJobId;
  String? jobCategory;
  DateTime? createdAt;
  DateTime? updatedAt;

  Category({
    this.id,
    this.adminJobId,
    this.jobCategory,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json["id"],
    adminJobId: json["admin_job_id"],
    jobCategory: json["job_category"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "admin_job_id": adminJobId,
    "job_category": jobCategory,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
