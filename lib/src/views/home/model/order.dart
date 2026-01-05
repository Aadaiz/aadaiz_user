import 'dart:convert';

class OrderRes {
  bool? status;
  String? message;
  List<Order>? orders;

  OrderRes({
    this.status,
    this.message,
    this.orders,
  });

  factory OrderRes.fromJson(String str) =>
      OrderRes.fromMap(json.decode(str));

  factory OrderRes.fromMap(Map<String, dynamic> json) => OrderRes(
    status: json["status"],
    message: json["message"],
    orders: json["orders"] == null
        ? []
        : List<Order>.from(
        json["orders"].map((x) => Order.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "orders": orders == null
        ? []
        : List<dynamic>.from(orders!.map((x) => x.toMap())),
  };
}
class Order {
  dynamic orderId;
  dynamic sellerId;
  dynamic total;

  Order({
    this.orderId,
    this.sellerId,
    this.total,
  });

  factory Order.fromMap(Map<String, dynamic> json) => Order(
    orderId: json["order_id"],
    sellerId: json["seller_id"],
    total: json["total"],
  );

  Map<String, dynamic> toMap() => {
    "order_id": orderId,
    "seller_id": sellerId,
    "total": total,
  };
}
