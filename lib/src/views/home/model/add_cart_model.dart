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
    id: json["id"],
    patternId: json["pattern_id"],
    price: json["price"],
    subTotalprice: json["sub_totalprice"],
    totalPrice: json["total_price"],
    quantity: json["quantity"],
    gstAmount: json["gst_amount"],
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
    id: json["id"],
    pCatId: json["p_cat_id"],
    price: json["price"],
    title: json["title"],
    subTitle: json["sub_title"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "p_cat_id": pCatId,
    "price": price,
    "title": title,
    "sub_title": subTitle,
  };
}
