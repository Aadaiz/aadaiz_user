import 'dart:convert';

class AddCartRes {
  dynamic success;
  dynamic message;
  Data? data;

  AddCartRes({
    this.success,
    this.message,
    this.data,
  });

  factory AddCartRes.fromJson(String str) => AddCartRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddCartRes.fromMap(Map<String, dynamic> json) => AddCartRes(
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
  dynamic id;
  dynamic patternId;
  dynamic price;
  dynamic subTotalprice;
  dynamic totalPrice;
  dynamic quantity;
  dynamic gstAmount;
  Pattern? pattern;

  Data({
    this.id,
    this.patternId,
    this.price,
    this.subTotalprice,
    this.totalPrice,
    this.quantity,
    this.gstAmount,
    this.pattern,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"]??null,
    patternId: json["pattern_id"]??null,
    price: json["price"]??null,
    subTotalprice: json["sub_totalprice"]??null,
    totalPrice: json["total_price"]??null,
    quantity: json["quantity"]??null,
    gstAmount: json["gst_amount"]??null,
    pattern: json["pattern"] == null ? null : Pattern.fromMap(json["pattern"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "pattern_id": patternId,
    "price": price,
    "sub_totalprice": subTotalprice,
    "total_price": totalPrice,
    "quantity": quantity,
    "gst_amount": gstAmount,
    "pattern": pattern?.toMap(),
  };
}

class Pattern {
  dynamic id;
  dynamic pCatId;
  dynamic price;
  dynamic title;
  dynamic subTitle;

  Pattern({
    this.id,
    this.pCatId,
    this.price,
    this.title,
    this.subTitle,
  });

  factory Pattern.fromJson(String str) => Pattern.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pattern.fromMap(Map<String, dynamic> json) => Pattern(
    id: json["id"]??null,
    pCatId: json["p_cat_id"]??null,
    price: json["price"]??null,
    title: json["title"]??null,
    subTitle: json["sub_title"]??null,
  );

  Map<String, dynamic> toMap() => {
    "id": id??null,
    "p_cat_id": pCatId??null,
    "price": price??null,
    "title": title??null,
    "sub_title": subTitle??null,
  };
}
