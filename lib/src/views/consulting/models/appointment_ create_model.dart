import 'dart:convert';

class AppointmentCreateRes {
  bool? status;
  String? message;
  Data? data;

  AppointmentCreateRes({
    this.status,
    this.message,
    this.data,
  });

  factory AppointmentCreateRes.fromJson(String str) => AppointmentCreateRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AppointmentCreateRes.fromMap(Map<String, dynamic> json) => AppointmentCreateRes(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "data": data?.toMap(),
  };
}

class Data {
  Appointment? appointment;

  Data({
    this.appointment,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    appointment: json["appointment"] == null ? null : Appointment.fromMap(json["appointment"]),
  );

  Map<String, dynamic> toMap() => {
    "appointment": appointment?.toMap(),
  };
}

class Appointment {
  int? userId;
  String? designerId;
  String? date;
  String? time;
  String? status;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Appointment({
    this.userId,
    this.designerId,
    this.date,
    this.time,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Appointment.fromJson(String str) => Appointment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Appointment.fromMap(Map<String, dynamic> json) => Appointment(
    userId: json["user_id"],
    designerId: json["designer_id"],
    date: json["date"],
    time: json["time"],
    status: json["status"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toMap() => {
    "user_id": userId,
    "designer_id": designerId,
    "date": date,
    "time": time,
    "status": status,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
