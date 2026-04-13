import 'dart:convert';

class BuyAndSellCartList {
  bool? status;
  List<Datum>? data;
  String? message;

  BuyAndSellCartList({
    this.status,
    this.data,
    this.message,
  });

  factory BuyAndSellCartList.fromJson(String str) => BuyAndSellCartList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BuyAndSellCartList.fromMap(Map<String, dynamic> json) => BuyAndSellCartList(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "message": message,
  };
}

class Datum {
  int? id;
  String? userId;
  String? productId;
  String? price;
  DateTime? createdAt;
  DateTime? updatedAt;
  Product? product;

  Datum({
    this.id,
    this.userId,
    this.productId,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    productId: json["product_id"],
    price: json["price"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    product: json["product"] == null ? null : Product.fromMap(json["product"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "product_id": productId,
    "price": price,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "product": product?.toMap(),
  };
}

class Product {
  int? id;
  String? userId;
  String? productName;
  String? subProductName;
  String? category;
  String? subCategory;
  String? product;
  String? description;
  String? price;
  String? size;
  String? mobileNumber;
  String? sellArea;
  String? sellCity;
  String? sellState;
  String? sellCountry;
  String? sellPincode;
  String? status;
  dynamic orderStatus;
  String? productImage;
  String? productFrontImage;
  String? productBackImage;
  String? commissionPercentage;
  dynamic pickupLocation;
  DateTime? createdAt;
  DateTime? updatedAt;

  Product({
    this.id,
    this.userId,
    this.productName,
    this.subProductName,
    this.category,
    this.subCategory,
    this.product,
    this.description,
    this.price,
    this.size,
    this.mobileNumber,
    this.sellArea,
    this.sellCity,
    this.sellState,
    this.sellCountry,
    this.sellPincode,
    this.status,
    this.orderStatus,
    this.productImage,
    this.productFrontImage,
    this.productBackImage,
    this.commissionPercentage,
    this.pickupLocation,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    id: json["id"],
    userId: json["user_id"],
    productName: json["product_name"],
    subProductName: json["sub_product_name"],
    category: json["category"],
    subCategory: json["sub_category"],
    product: json["product"],
    description: json["description"],
    price: json["price"],
    size: json["size"],
    mobileNumber: json["mobile_number"],
    sellArea: json["sell_area"],
    sellCity: json["sell_city"],
    sellState: json["sell_state"],
    sellCountry: json["sell_country"],
    sellPincode: json["sell_pincode"],
    status: json["status"],
    orderStatus: json["order_status"],
    productImage: json["product_image"],
    productFrontImage: json["product_front_image"],
    productBackImage: json["product_back_image"],
    commissionPercentage: json["commission_percentage"],
    pickupLocation: json["pickup_location"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "product_name": productName,
    "sub_product_name": subProductName,
    "category": category,
    "sub_category": subCategory,
    "product": product,
    "description": description,
    "price": price,
    "size": size,
    "mobile_number": mobileNumber,
    "sell_area": sellArea,
    "sell_city": sellCity,
    "sell_state": sellState,
    "sell_country": sellCountry,
    "sell_pincode": sellPincode,
    "status": status,
    "order_status": orderStatus,
    "product_image": productImage,
    "product_front_image": productFrontImage,
    "product_back_image": productBackImage,
    "commission_percentage": commissionPercentage,
    "pickup_location": pickupLocation,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
