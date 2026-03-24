import 'dart:convert';

class CartListRes {
  bool? success;
  dynamic message;
  Data? data;

  CartListRes({
    this.success,
    this.message,
    this.data,
  });

  factory CartListRes.fromJson(String str) => CartListRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CartListRes.fromMap(Map<String, dynamic> json) => CartListRes(
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

  ShippingAddress? shippingAddress;
  List<Item>? items;
  dynamic subTotalAmount;
  dynamic gstAmount;
  dynamic discountAmount;
  dynamic totalAmount;
  CouponDetails? couponDetails;

  Data({
    this.shippingAddress,
    this.items,
    this.subTotalAmount,
    this.gstAmount,
    this.discountAmount,
    this.totalAmount,
    this.couponDetails,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    shippingAddress: json["shippingAddress"] == null ? null : ShippingAddress.fromMap(json["shippingAddress"]),
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromMap(x))),
    subTotalAmount: json["subTotalAmount"],
    gstAmount: json["gstAmount"],
    discountAmount: json["discountAmount"],
    totalAmount: json["TotalAmount"],
    couponDetails: json["coupon_details"] == null ? null : CouponDetails.fromMap(json["coupon_details"]),  );

  Map<String, dynamic> toMap() => {
    "shippingAddress": shippingAddress?.toMap(),
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toMap())),
    "subTotalAmount": subTotalAmount,
    "gstAmount": gstAmount,
    "discountAmount": discountAmount,
    "TotalAmount": totalAmount,
    "coupon_details": couponDetails?.toMap(),
  };
}

class CouponDetails {
  int? id;
  String? couponType;
  String? couponCode;
  String? discount;

  CouponDetails({
    this.id,
    this.couponType,
    this.couponCode,
    this.discount,
  });

  factory CouponDetails.fromJson(String str) => CouponDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CouponDetails.fromMap(Map<String, dynamic> json) => CouponDetails(
    id: json["id"],
    couponType: json["coupon_type"],
    couponCode: json["coupon_code"],
    discount: json["discount"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "coupon_type": couponType,
    "coupon_code": couponCode,
    "discount": discount,
  };
}

class Item {
  dynamic cartId;
  dynamic patternId;
  dynamic price;
  dynamic quantity;
  Measurement? measurement;
  dynamic fabricMetre;
  dynamic size;
  Pattern? pattern;

  Item({
    this.cartId,
    this.patternId,
    this.price,
    this.quantity,
    this.measurement,
    this.fabricMetre,
    this.size,
    this.pattern,
  });

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
    cartId: json["cart_id"],
    patternId: json["pattern_id"],
    price: json["price"],
    quantity: json["quantity"],
    measurement: json["measurement"] == null ? null : Measurement.fromMap(json["measurement"]),
    fabricMetre: json["fabric_metre"],
    size: json["size"],
    pattern: json["pattern"] == null ? null : Pattern.fromMap(json["pattern"]),
  );

  Map<String, dynamic> toMap() => {
    "cart_id": cartId,
    "pattern_id": patternId,
    "price": price,
    "quantity": quantity,
    "measurement": measurement?.toMap(),
    "fabric_metre": fabricMetre,
    "size": size,
    "pattern": pattern?.toMap(),
  };
}

class Measurement {
  dynamic length;
  dynamic shoulder;
  dynamic chest;
  dynamic waist;
  dynamic hip;

  Measurement({
    this.length,
    this.shoulder,
    this.chest,
    this.waist,
    this.hip,
  });

  factory Measurement.fromJson(String str) => Measurement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Measurement.fromMap(Map<String, dynamic> json) => Measurement(
    length: json["length"],
    shoulder: json["shoulder"],
    chest: json["chest"],
    waist: json["waist"],
    hip: json["hip"],
  );

  Map<String, dynamic> toMap() => {
    "length": length,
    "shoulder": shoulder,
    "chest": chest,
    "waist": waist,
    "hip": hip,
  };
}

class Pattern {
  dynamic id;
  dynamic pCatId;
  dynamic price;
  dynamic title;
  dynamic image;
  dynamic subTitle;
  dynamic gstPercentage;
  dynamic length;
  dynamic breadth;
  dynamic height;
  dynamic rating;

  Pattern({
    this.id,
    this.pCatId,
    this.price,
    this.title,
    this.image,
    this.subTitle,
    this.gstPercentage,
    this.length,
    this.breadth,
    this.height,
    this.rating,
  });

  factory Pattern.fromJson(String str) => Pattern.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pattern.fromMap(Map<String, dynamic> json) => Pattern(
    id: json["id"],
    pCatId: json["p_cat_id"],
    price: json["price"],
    title: json["title"],
    image: json["image_url"],
    subTitle: json["sub_title"],
    gstPercentage: json["gst_percentage"],
    length: json["length"],
    breadth: json["breadth"],
    height: json["height"],
    rating: json["rating"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "p_cat_id": pCatId,
    "price": price,
    "title": title,
    "image_url": image,
    "sub_title": subTitle,
    "gst_percentage": gstPercentage,
    "length": length,
    "breadth": breadth,
    "height": height,
    "rating": rating,
  };
}

class ShippingAddress {
  dynamic id;
  dynamic name;
  dynamic address;
  dynamic landmark;
  dynamic city;
  dynamic state;
  dynamic pincode;

  ShippingAddress({
    this.id,
    this.name,
    this.address,
    this.landmark,
    this.city,
    this.state,
    this.pincode,
  });

  factory ShippingAddress.fromJson(String str) => ShippingAddress.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShippingAddress.fromMap(Map<String, dynamic> json) => ShippingAddress(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    landmark: json["landmark"],
    city: json["city"],
    state: json["state"],
    pincode: json["pincode"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "address": address,
    "landmark": landmark,
    "city": city,
    "state": state,
    "pincode": pincode,
  };
}
