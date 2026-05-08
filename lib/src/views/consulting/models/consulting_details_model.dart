import 'dart:convert';

class DesignerDetailRes {
  bool? status;
  String? message;
  DesignerDetailData? data;

  DesignerDetailRes({
    this.status,
    this.message,
    this.data,
  });

  factory DesignerDetailRes.fromJson(String str) =>
      DesignerDetailRes.fromMap(json.decode(str));

  factory DesignerDetailRes.fromMap(Map<String, dynamic> json) =>
      DesignerDetailRes(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DesignerDetailData.fromMap(json["data"]),
      );
}

class DesignerDetailData {
  dynamic designerId;
  dynamic name;
  dynamic profilePic;
  dynamic designation;
  dynamic consultationFee;
  dynamic area;
  dynamic city;
  dynamic state;
  dynamic country;
  dynamic pincode;
  dynamic specialization;
  List<Availability>? availability;

  DesignerDetailData({
    this.designerId,
    this.name,
    this.profilePic,
    this.designation,
    this.consultationFee,
    this.area,
    this.city,
    this.state,
    this.country,
    this.pincode,
    this.specialization,
    this.availability,
  });

  factory DesignerDetailData.fromMap(Map<String, dynamic> json) =>
      DesignerDetailData(
        designerId: json["designer_id"],
        name: json["name"],
        profilePic: json["profile_pic"],
        designation: json["designation"],
        consultationFee: json["consultation_fee"],
        area: json["area"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        pincode: json["pincode"],
        specialization: json["specialization"],
        availability: json["availability"] == null
            ? []
            : List<Availability>.from(
          json["availability"].map((x) => Availability.fromMap(x)),
        ),
      );
}

class Availability {
  dynamic day;
  List<Slot>? slots;

  Availability({
    this.day,
    this.slots,
  });

  factory Availability.fromMap(Map<String, dynamic> json) => Availability(
    day: json["day"],
    slots: json["slots"] == null
        ? []
        : List<Slot>.from(json["slots"].map((x) => Slot.fromMap(x))),
  );
}

class Slot {
  dynamic slotId;
  dynamic startTime;
  dynamic endTime;

  Slot({
    this.slotId,
    this.startTime,
    this.endTime,
  });

  factory Slot.fromMap(Map<String, dynamic> json) => Slot(
    slotId: json["slot_id"],
    startTime: json["start_time"],
    endTime: json["end_time"],
  );
}