import 'dart:convert';

class CouponListRes {
  bool? success;
  dynamic message;
  List<Coupon>? data;

  CouponListRes({
    this.success,
    this.message,
    this.data,
  });

  factory CouponListRes.fromJson(String str) => CouponListRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CouponListRes.fromMap(Map<String, dynamic> json) => CouponListRes(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Coupon>.from(json["data"]!.map((x) => Coupon.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Coupon {
  dynamic id;
  dynamic title;
  dynamic description;
  dynamic couponCode;
  dynamic imageUrl;

  Coupon({
    this.id,
    this.title,
    this.description,
    this.couponCode,
    this.imageUrl,
  });

  factory Coupon.fromJson(String str) => Coupon.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Coupon.fromMap(Map<String, dynamic> json) => Coupon(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    couponCode: json["coupon_code"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "description": description,
    "coupon_code": couponCode,
    "image_url": imageUrl,
  };
}
