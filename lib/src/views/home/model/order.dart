import 'dart:convert';

class OrderRes {
  dynamic status;
  List<dynamic>? data;
  dynamic message;


  OrderRes({
    this.status,
    this.data,
    this.message,
  });

  factory OrderRes.fromJson(String str) => OrderRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderRes.fromMap(Map<String, dynamic> json) => OrderRes(
    status: json["status"]??null,
    data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
    message: json["message"]??null,
  );

  Map<String, dynamic> toMap() => {
    "status": status??null,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
    "message": message??null,
  };
}
