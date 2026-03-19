import 'dart:convert';

class EventRes {
  bool? status;
  Data? data;
  String? message;

  EventRes({
    this.status,
    this.data,
    this.message,
  });

  factory EventRes.fromJson(String str) => EventRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EventRes.fromMap(Map<String, dynamic> json) => EventRes(
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
  Event? yourEvent;
  Event? event;

  Data({
    this.yourEvent,
    this.event,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    yourEvent: json["your_event"] == null ? null : Event.fromMap(json["your_event"]),
    event: json["event"] == null ? null : Event.fromMap(json["event"]),
  );

  Map<String, dynamic> toMap() => {
    "your_event": yourEvent?.toMap(),
    "event": event?.toMap(),
  };
}

class Event {
  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Event({
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

  factory Event.fromJson(String str) => Event.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Event.fromMap(Map<String, dynamic> json) => Event(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
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

class Datum {
  int? id;
  String? userId;
  String? eventName;
  DateTime? startDate;
  String? startTime;
  DateTime? endDate;
  String? endTime;
  String? eventLocation;
  String? eventEmail;
  String? eventMobileNumber;
  String? eventStatus;
  String? eventCity;
  String? eventState;
  String? eventArea;
  String? eventPincode;
  String? eventCountry;
  String? eventImage;
  String? aboutEvent;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.userId,
    this.eventName,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    this.eventLocation,
    this.eventEmail,
    this.eventMobileNumber,
    this.eventStatus,
    this.eventCity,
    this.eventState,
    this.eventArea,
    this.eventPincode,
    this.eventCountry,
    this.eventImage,
    this.aboutEvent,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    eventName: json["event_name"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    startTime: json["start_time"],
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    endTime: json["end_time"],
    eventLocation: json["event_location"],
    eventEmail: json["event_email"],
    eventMobileNumber: json["event_mobile_number"],
    eventStatus: json["event_status"],
    eventCity: json["event_city"],
    eventState: json["event_state"],

    eventArea: json["event_area"],
    eventPincode: json["event_pincode"],
    eventCountry: json["event_country"],
    eventImage: json["event_image"],
    aboutEvent: json["about_event"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "event_name": eventName,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "start_time": startTime,
    "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "end_time": endTime,
    "event_location": eventLocation,
    "event_email": eventEmail,
    "event_mobile_number": eventMobileNumber,
    "event_status": eventStatus,
    "event_city": eventCity,
    "event_state": eventState,
    "event_area": eventArea,
    "event_pincode": eventPincode,
    "event_country": eventCountry,
    "event_image": eventImage,
    "about_event": aboutEvent,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class EventCityClass {
  int? id;
  String? name;
  int? stateId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? countryId;

  EventCityClass({
    this.id,
    this.name,
    this.stateId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.countryId,
  });

  factory EventCityClass.fromJson(String str) => EventCityClass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EventCityClass.fromMap(Map<String, dynamic> json) => EventCityClass(
    id: json["id"],
    name: json["name"],
    stateId: json["state_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    countryId: json["country_id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "state_id": stateId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "country_id": countryId,
  };
}

class Link {
  String? url;
  String? label;
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
