import 'dart:convert';

class SupportListRes {
  bool? success;
  String? message;
  List<Datum>? data;

  SupportListRes({
    this.success,
    this.message,
    this.data,
  });

  factory SupportListRes.fromJson(String str) => SupportListRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SupportListRes.fromMap(Map<String, dynamic> json) => SupportListRes(
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
  int? id;
  int? userId;
  dynamic sellerId;
  dynamic tailorId;
  String? ticketNumber;
  String? title;
  String? description;
  String? type;
  String? status;
  String? attachment;
  int? deleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? date;

  Datum({
    this.id,
    this.userId,
    this.sellerId,
    this.tailorId,
    this.ticketNumber,
    this.title,
    this.description,
    this.type,
    this.status,
    this.attachment,
    this.deleted,
    this.createdAt,
    this.updatedAt,
    this.date,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    sellerId: json["seller_id"],
    tailorId: json["tailor_id"],
    ticketNumber: json["ticket_number"],
    title: json["title"],
    description: json["description"],
    type: json["type"],
    status: json["status"],
    attachment: json["attachment"],
    deleted: json["deleted"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    date: json["date"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "seller_id": sellerId,
    "tailor_id": tailorId,
    "ticket_number": ticketNumber,
    "title": title,
    "description": description,
    "type": type,
    "status": status,
    "attachment": attachment,
    "deleted": deleted,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "date": date,
  };
}
