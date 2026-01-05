import 'dart:convert';

class ChatList {
  bool? status;
  List<Datum>? data;

  ChatList({
    this.status,
    this.data,
  });

  factory ChatList.fromJson(String str) => ChatList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChatList.fromMap(Map<String, dynamic> json) => ChatList(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Datum {
  int? orderId;
  String? customerName;
  String? lastMessage;
  DateTime? createdAt;

  Datum({
    this.orderId,
    this.customerName,
    this.lastMessage,
    this.createdAt,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    orderId: json["order_id"],
    customerName: json["customer_name"],
    lastMessage: json["last_message"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toMap() => {
    "order_id": orderId,
    "customer_name": customerName,
    "last_message": lastMessage,
    "created_at": createdAt?.toIso8601String(),
  };
}
