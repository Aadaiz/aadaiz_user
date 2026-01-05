import 'dart:convert';

/// =======================
/// MAIN RESPONSE MODEL
/// =======================
class MaterialCartListRes {
  bool? success;
  String? message;
  CartData? data;

  MaterialCartListRes({
    this.success,
    this.message,
    this.data,
  });

  factory MaterialCartListRes.fromJson(String str) =>
      MaterialCartListRes.fromMap(json.decode(str));

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message,
    "data": data?.toMap(),
  };

  factory MaterialCartListRes.fromMap(Map<String, dynamic> json) =>
      MaterialCartListRes(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : CartData.fromMap(json["data"]),
      );
}

/// =======================
/// CART DATA
/// =======================
class CartData {
  List<CartItem>? items;
  dynamic subtotal;
  dynamic discounts;
  dynamic taxAndCharges;
  dynamic deliveryCharges;
  String?couponCode;


  dynamic total;

  CartData({
    this.items,
    this.subtotal,
    this.discounts,
    this.taxAndCharges,
    this.deliveryCharges,
    this.total,
    this.couponCode
  });

  factory CartData.fromMap(Map<String, dynamic> json) => CartData(
    items: json["items"] == null
        ? []
        : List<CartItem>.from(
        json["items"].map((x) => CartItem.fromMap(x))),
    subtotal: json["subtotal"],
    discounts: json["discounts"],
    taxAndCharges: json["tax_and_charges"],
    deliveryCharges: json["delivery_charges"],
    total: json["total"],
    couponCode: json['couponCode']
  );

  Map<String, dynamic> toMap() => {
    "items": items == null
        ? []
        : List<dynamic>.from(items!.map((x) => x.toMap())),
    "subtotal": subtotal,
    "discounts": discounts,
    "tax_and_charges": taxAndCharges,
    "delivery_charges": deliveryCharges,
    "total": total,
    'couponCode':couponCode
  };
}

/// =======================
/// CART ITEM
/// =======================
class CartItem {
  Product? product;
  dynamic quantity;

  CartItem({
    this.product,
    this.quantity,
  });

  factory CartItem.fromMap(Map<String, dynamic> json) => CartItem(
    product:
    json["product"] == null ? null : Product.fromMap(json["product"]),
    quantity: json["quantity"],
  );

  Map<String, dynamic> toMap() => {
    "product": product?.toMap(),
    "quantity": quantity,
  };
}

/// =======================
/// PRODUCT MODEL
/// =======================
class Product {
  dynamic id;
  dynamic sellerId;
  String? title;
  String? subtitle;
  String? category;
  String? image;
  String? color;
  String? price;
  dynamic aadaizPrice;
  String? meter;
  String? description;
  dynamic rating;
  String? status;
  dynamic peopleView;
  String? stockStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  Product({
    this.id,
    this.sellerId,
    this.title,
    this.subtitle,
    this.category,
    this.image,
    this.color,
    this.price,
    this.aadaizPrice,
    this.meter,
    this.description,
    this.rating,
    this.status,
    this.peopleView,
    this.stockStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    id: json["id"],
    sellerId: json["seller_id"],
    title: json["title"],
    subtitle: json["subtitle"],
    category: json["category"],
    image: json["image"],
    color: json["color"],
    price: json["price"],
    aadaizPrice: json["aadaiz_price"],
    meter: json["meter"],
    description: json["description"],
    rating: json["rating"],
    status: json["status"],
    peopleView: json["people_view"],
    stockStatus: json["stock_status"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "seller_id": sellerId,
    "title": title,
    "subtitle": subtitle,
    "category": category,
    "image": image,
    "color": color,
    "price": price,
    "aadaiz_price": aadaizPrice,
    "meter": meter,
    "description": description,
    "rating": rating,
    "status": status,
    "people_view": peopleView,
    "stock_status": stockStatus,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
