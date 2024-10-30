import 'dart:convert';

class AppointmentAvailableRes {
  bool? success;
  dynamic message;
  List<AvailableSlot>? data;

  AppointmentAvailableRes({
    this.success,
    this.message,
    this.data,
  });

  factory AppointmentAvailableRes.fromJson(String str) => AppointmentAvailableRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AppointmentAvailableRes.fromMap(Map<String, dynamic> json) => AppointmentAvailableRes(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<AvailableSlot>.from(json["data"]!.map((x) => AvailableSlot.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class AvailableSlot {
  dynamic id;
  dynamic time;
  DateTime? createdAt;
  DateTime? updatedAt;

  AvailableSlot({
    this.id,
    this.time,
    this.createdAt,
    this.updatedAt,
  });

  factory AvailableSlot.fromJson(String str) => AvailableSlot.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AvailableSlot.fromMap(Map<String, dynamic> json) => AvailableSlot(
    id: json["id"]??null,
    time: json["time"]??null,
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id??null,
    "time": time??null,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
