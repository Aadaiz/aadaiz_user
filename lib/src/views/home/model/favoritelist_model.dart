import 'dart:convert';

class FavoriteListRes {
  bool? success;
  dynamic message;
  List<Favorites>? data;

  FavoriteListRes({
    this.success,
    this.message,
    this.data,
  });

  factory FavoriteListRes.fromJson(String str) => FavoriteListRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FavoriteListRes.fromMap(Map<String, dynamic> json) => FavoriteListRes(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Favorites>.from(json["data"]!.map((x) => Favorites.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Favorites {
  dynamic id;
  dynamic userId;
  dynamic patternId;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Pattern? patern;

  Favorites({
    this.id,
    this.userId,
    this.patternId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.patern,
  });

  factory Favorites.fromJson(String str) => Favorites.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Favorites.fromMap(Map<String, dynamic> json) => Favorites(
    id: json["id"]??null,
    userId: json["user_id"]??null,
    patternId: json["pattern_id"]??null,
    status: json["status"]??null,
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    patern: json["patern"] == null ? null : Pattern.fromMap(json["patern"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id??null,
    "user_id": userId??null,
    "pattern_id": patternId??null,
    "status": status??null,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "patern": patern?.toMap(),
  };
}

class Pattern {
  dynamic id;
  dynamic pCatId;
  dynamic title;
  dynamic subTitle;
  dynamic description;
  dynamic imageUrl;
  dynamic price;
  dynamic sizes;
  dynamic specialCategory;
  dynamic rating;
  dynamic gstPercentage;
  dynamic length;
  dynamic breadth;
  dynamic height;
  dynamic peopleView;
  DateTime? createdAt;
  DateTime? updatedAt;

  Pattern({
    this.id,
    this.pCatId,
    this.title,
    this.subTitle,
    this.description,
    this.imageUrl,
    this.price,
    this.sizes,
    this.specialCategory,
    this.rating,
    this.gstPercentage,
    this.length,
    this.breadth,
    this.height,
    this.peopleView,
    this.createdAt,
    this.updatedAt,
  });

  factory Pattern.fromJson(String str) => Pattern.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pattern.fromMap(Map<String, dynamic> json) => Pattern(
    id: json["id"]??null,
    pCatId: json["p_cat_id"]??null,
    title: json["title"]??null,
    subTitle: json["sub_title"]??null,
    description: json["description"]??null,
    imageUrl: json["image_url"]??null,
    price: json["price"]??null,
    sizes: json["sizes"]??null,
    specialCategory: json["special_category"]??null,
    rating: json["rating"]??null,
    gstPercentage: json["gst_percentage"]??null,
    length: json["length"]??null,
    breadth: json["breadth"]??null,
    height: json["height"]??null,
    peopleView: json["people_view"]??null,
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id??null,
    "p_cat_id": pCatId??null,
    "title": title??null,
    "sub_title": subTitle??null,
    "description": description??null,
    "image_url": imageUrl??null,
    "price": price??null,
    "sizes": sizes??null,
    "special_category": specialCategory??null,
    "rating": rating??null,
    "gst_percentage": gstPercentage??null,
    "length": length??null,
    "breadth": breadth??null,
    "height": height??null,
    "people_view": peopleView??null,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
