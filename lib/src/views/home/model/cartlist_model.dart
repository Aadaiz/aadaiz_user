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
  List<dynamic>? couponDetails;

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
    subTotalAmount: json["subTotalAmount"]??null,
    gstAmount: json["gstAmount"]??null,
    discountAmount: json["discountAmount"]??null,
    totalAmount: json["TotalAmount"]??null,
    couponDetails: json["coupon_details"] == null ? [] : List<dynamic>.from(json["coupon_details"]!.map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "shippingAddress": shippingAddress?.toMap(),
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toMap())),
    "subTotalAmount": subTotalAmount??null,
    "gstAmount": gstAmount??null,
    "discountAmount": discountAmount??null,
    "TotalAmount": totalAmount??null,
    "coupon_details": couponDetails == null ? [] : List<dynamic>.from(couponDetails!.map((x) => x)),
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
    cartId: json["cart_id"]??null,
    patternId: json["pattern_id"]??null,
    price: json["price"]??null,
    quantity: json["quantity"]??null,
    measurement: json["measurement"] == null ? null : Measurement.fromMap(json["measurement"]),
    fabricMetre: json["fabric_metre"]??null,
    size: json["size"]??null,
    pattern: json["pattern"] == null ? null : Pattern.fromMap(json["pattern"]),
  );

  Map<String, dynamic> toMap() => {
    "cart_id": cartId??null,
    "pattern_id": patternId??null,
    "price": price??null,
    "quantity": quantity??null,
    "measurement": measurement?.toMap(),
    "fabric_metre": fabricMetre??null,
    "size": size??null,
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
    length: json["length"]??null,
    shoulder: json["shoulder"]??null,
    chest: json["chest"]??null,
    waist: json["waist"]??null,
    hip: json["hip"]??null,
  );

  Map<String, dynamic> toMap() => {
    "length": length??null,
    "shoulder": shoulder??null,
    "chest": chest??null,
    "waist": waist??null,
    "hip": hip??null,
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
    id: json["id"]??null,
    pCatId: json["p_cat_id"]??null,
    price: json["price"]??null,
    title: json["title"]??null,
    image: json["image_url"]??null,
    subTitle: json["sub_title"]??null,
    gstPercentage: json["gst_percentage"]??null,
    length: json["length"]??null,
    breadth: json["breadth"]??null,
    height: json["height"]??null,
    rating: json["rating"]??null,
  );

  Map<String, dynamic> toMap() => {
    "id": id??null,
    "p_cat_id": pCatId??null,
    "price": price??null,
    "title": title??null,
    "image_url": image??null,
    "sub_title": subTitle??null,
    "gst_percentage": gstPercentage??null,
    "length": length??null,
    "breadth": breadth??null,
    "height": height??null,
    "rating": rating??null,
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
    id: json["id"]??null,
    name: json["name"]??null,
    address: json["address"]??null,
    landmark: json["landmark"]??null,
    city: json["city"]??null,
    state: json["state"]??null,
    pincode: json["pincode"]??null,
  );

  Map<String, dynamic> toMap() => {
    "id": id??null,
    "name": name??null,
    "address": address??null,
    "landmark": landmark??null,
    "city": city??null,
    "state": state??null,
    "pincode": pincode??null,
  };
}
