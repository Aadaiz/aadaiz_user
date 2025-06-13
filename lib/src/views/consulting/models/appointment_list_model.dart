import 'dart:convert';

class AppointmentRes {
  bool? status;
  dynamic message;
  List<ConsultingAppointment>? data;

  AppointmentRes({
    this.status,
    this.message,
    this.data,
  });

  factory AppointmentRes.fromJson(String str) => AppointmentRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AppointmentRes.fromMap(Map<String, dynamic> json) => AppointmentRes(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ConsultingAppointment>.from(json["data"]!.map((x) => ConsultingAppointment.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class ConsultingAppointment {
  dynamic appointmentId;
  dynamic designerName;
  dynamic profileImage;
  dynamic date;
  dynamic time;
  dynamic status;
  dynamic amount;
  dynamic designImage;
  dynamic measurementSheet;
  dynamic zoomMeetingId;
  dynamic zoomJoinUrl;

  ConsultingAppointment({
    this.appointmentId,
    this.designerName,
    this.profileImage,
    this.date,
    this.time,
    this.status,
    this.amount,
    this.designImage,
    this.measurementSheet,
    this.zoomMeetingId,
    this.zoomJoinUrl,
  });

  factory ConsultingAppointment.fromJson(String str) => ConsultingAppointment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConsultingAppointment.fromMap(Map<String, dynamic> json) => ConsultingAppointment(
    appointmentId: json["appointment_id"],
    designerName: json["designer_name"],
    profileImage: json["profile_image"],
    date: json["date"],
    time: json["time"],
    status: json["status"],
    amount: json["amount"],
    designImage: json["design_image"],
    measurementSheet: json["measurement_sheet"],
    zoomMeetingId: json["zoom_meeting_id"],
    zoomJoinUrl: json["zoom_join_url"],
  );

  Map<String, dynamic> toMap() => {
    "appointment_id": appointmentId,
    "designer_name": designerName,
    "profile_image": profileImage,
    "date": date,
    "time": time,
    "status": status,
    "amount": amount,
    "design_image": designImage,
    "measurement_sheet": measurementSheet,
    "zoom_meeting_id": zoomMeetingId,
    "zoom_join_url": zoomJoinUrl,
  };
}
