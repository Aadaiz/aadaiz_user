import 'dart:convert';

class JobListRes {
  bool? status;
  List<Datum>? data;

  JobListRes({
    this.status,
    this.data,
  });

  factory JobListRes.fromJson(String str) => JobListRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory JobListRes.fromMap(Map<String, dynamic> json) => JobListRes(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Datum {
  int? id;
  String? jobTitle;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Subjob>? subjobs;

  Datum({
    this.id,
    this.jobTitle,
    this.createdAt,
    this.updatedAt,
    this.subjobs,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    jobTitle: json["job_title"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    subjobs: json["subjobs"] == null ? [] : List<Subjob>.from(json["subjobs"]!.map((x) => Subjob.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "job_title": jobTitle,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "subjobs": subjobs == null ? [] : List<dynamic>.from(subjobs!.map((x) => x.toMap())),
  };
}

class Subjob {
  int? id;
  String? adminJobId;
  String? jobCategory;
  DateTime? createdAt;
  DateTime? updatedAt;

  Subjob({
    this.id,
    this.adminJobId,
    this.jobCategory,
    this.createdAt,
    this.updatedAt,
  });

  factory Subjob.fromJson(String str) => Subjob.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Subjob.fromMap(Map<String, dynamic> json) => Subjob(
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
