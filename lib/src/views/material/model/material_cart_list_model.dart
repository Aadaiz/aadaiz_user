import 'dart:convert';

class MaterialCartListRes {
  bool? success;
  dynamic message;
  Data? data;

  MaterialCartListRes({
    this.success,
    this.message,
    this.data,
  });

  factory MaterialCartListRes.fromJson(String str) => MaterialCartListRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MaterialCartListRes.fromMap(Map<String, dynamic> json) => MaterialCartListRes(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message,
    "data": data?.toMap(),
  };
}

class Data {
  List<Item>? items;
  dynamic subtotal;
  dynamic discounts;
  dynamic taxAndCharges;
  dynamic deliveryCharges;
  dynamic total;

  Data({
    this.items,
    this.subtotal,
    this.discounts,
    this.taxAndCharges,
    this.deliveryCharges,
    this.total,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromMap(x))),
    subtotal: json["subtotal"],
    discounts: json["discounts"],
    taxAndCharges: json["tax_and_charges"],
    deliveryCharges: json["delivery_charges"],
    total: json["total"],
  );

  Map<String, dynamic> toMap() => {
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toMap())),
    "subtotal": subtotal,
    "discounts": discounts,
    "tax_and_charges": taxAndCharges,
    "delivery_charges": deliveryCharges,
    "total": total,
  };
}

class Item {
  dynamic id;
  dynamic sellerId;
  dynamic title;
  dynamic subtitle;
  dynamic category;
  dynamic image;
  dynamic color;
  dynamic price;
  dynamic aadaizPrice;
  dynamic meter;
  dynamic description;
  dynamic rating;
  dynamic status;
  dynamic peopleView;
  dynamic stockStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  Item({
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

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
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
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
