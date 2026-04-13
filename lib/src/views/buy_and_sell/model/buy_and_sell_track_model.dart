
import 'dart:convert';

class BuyAndSellTrackModel {
  bool? status;
  TrackData? data;
  String? message;

  BuyAndSellTrackModel({this.status, this.data, this.message});

  factory BuyAndSellTrackModel.fromJson(String str) =>
      BuyAndSellTrackModel.fromMap(json.decode(str));

  factory BuyAndSellTrackModel.fromMap(Map<String, dynamic> json) =>
      BuyAndSellTrackModel(
        status: json["status"],
        data: json["data"] == null ? null : TrackData.fromMap(json["data"]),
        message: json["message"],
      );
}

class TrackData {
  int? orderItemId;
  String? awbCode;
  String? status;
  List<TrackingEvent>? payload;

  TrackData({this.orderItemId, this.awbCode, this.status, this.payload});

  factory TrackData.fromMap(Map<String, dynamic> json) {
    List<TrackingEvent> events = [];
    try {
      final raw = json["payload"];
      List<dynamic> decoded = raw is String ? jsonDecode(raw) : raw;
      events = decoded.map((e) => TrackingEvent.fromMap(e)).toList();
    } catch (_) {}

    return TrackData(
      orderItemId: json["order_item_id"],
      awbCode: json["awb_code"],
      status: json["status"],
      payload: events,
    );
  }
}

class TrackingEvent {
  String? status;
  String? activity;
  String? location;
  String? date;

  TrackingEvent({this.status, this.activity, this.location, this.date});

  factory TrackingEvent.fromMap(Map<String, dynamic> json) => TrackingEvent(
    status: json["status"] ?? json["Status"] ?? '',
    activity: json["activity"] ?? json["Activity"] ?? '',
    location: json["location"] ?? json["Location"] ?? '',
    date: json["date"] ?? json["Date"] ?? '',
  );
}