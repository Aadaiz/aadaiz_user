import 'dart:convert';

class AddReviewRes {
  bool? status;
  List<dynamic>? data;
  dynamic message;

  AddReviewRes({
    this.status,
    this.data,
    this.message,
  });

  factory AddReviewRes.fromJson(String str) => AddReviewRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddReviewRes.fromMap(Map<String, dynamic> json) => AddReviewRes(
    status: json["status"],
    data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
    "message": message,
  };
}
