import 'dart:convert';

class AppointmentRes {
  bool? status;
  dynamic message;
  Data? data;

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
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "data": data?.toMap(),
  };
}

class Data {
  dynamic currentPage;
  List<ConsultingAppointment>? data;
  dynamic firstPageUrl;
  dynamic from;
  dynamic lastPage;
  dynamic lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  dynamic path;
  dynamic perPage;
  dynamic prevPageUrl;
  dynamic to;
  dynamic total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<ConsultingAppointment>.from(json["data"]!.map((x) => ConsultingAppointment.fromMap(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromMap(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toMap() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toMap())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class ConsultingAppointment {
  dynamic appointmentId;
  dynamic designerName;
  dynamic profileImage;
  dynamic category;
  dynamic date;
  dynamic time;
  dynamic status;
  dynamic zoomMeetingId;
  dynamic zoomJoinUrl;

  ConsultingAppointment({
    this.appointmentId,
    this.designerName,
    this.profileImage,
    this.category,
    this.date,
    this.time,
    this.status,
    this.zoomMeetingId,
    this.zoomJoinUrl,
  });

  factory ConsultingAppointment.fromJson(String str) => ConsultingAppointment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConsultingAppointment.fromMap(Map<String, dynamic> json) => ConsultingAppointment(
    appointmentId: json["appointment_id"]??null,
    designerName: json["designer_name"]??null,
    profileImage: json["profile_image"]??null,
    category: json["category"]??null,
    date: json["date"]??null,
    time: json["time"]??null,
    status: json["status"]??null,
    zoomMeetingId: json["zoom_meeting_id"]??null,
    zoomJoinUrl: json["zoom_join_url"]??null,
  );

  Map<String, dynamic> toMap() => {
    "appointment_id": appointmentId??null,
    "designer_name": designerName??null,
    "profile_image": profileImage??null,
    "category": category??null,
    "date": date??null,
    "time": time??null,
    "status": status??null,
    "zoom_meeting_id": zoomMeetingId??null,
    "zoom_join_url": zoomJoinUrl??null,
  };
}

class Link {
  dynamic url;
  dynamic label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(String str) => Link.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Link.fromMap(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toMap() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
