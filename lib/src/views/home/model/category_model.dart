import 'dart:convert';

class CategoryDataRes {
  dynamic status;
  dynamic message;
  dynamic specialPatternText;
  CatDetails? catDetails;
  List<Datum>? data;
  List<SpecialPattern>? specialPatterns;

  CategoryDataRes({
    this.status,
    this.message,
    this.catDetails,
    this.data,
    this.specialPatternText,
    this.specialPatterns,
  });

  factory CategoryDataRes.fromJson(String str) => CategoryDataRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryDataRes.fromMap(Map<String, dynamic> json) => CategoryDataRes(
    status: json["status"],
    message: json["message"],
    specialPatternText: json["special_pattern_text"],
    catDetails: json["cat_details"] == null ? null : CatDetails.fromMap(json["cat_details"]),
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    specialPatterns: json["special_patterns"] == null ? [] : List<SpecialPattern>.from(json["special_patterns"]!.map((x) => SpecialPattern.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "special_pattern_text": specialPatternText,
    "cat_details": catDetails?.toMap(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "special_patterns": specialPatterns == null ? [] : List<dynamic>.from(specialPatterns!.map((x) => x.toMap())),
  };
}

class CatDetails {
  dynamic id;
  dynamic catName;
  dynamic imageUrl;
  dynamic slideImageUrl;
  dynamic catId;

  CatDetails({
    this.id,
    this.catName,
    this.imageUrl,
    this.slideImageUrl,
    this.catId,
  });

  factory CatDetails.fromJson(String str) => CatDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CatDetails.fromMap(Map<String, dynamic> json) => CatDetails(
    id: json["id"],
    catName: json["cat_name"],
    imageUrl: json["image_url"],
    slideImageUrl: json["slide_image_url"],
    catId: json["cat_id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "cat_name": catName,
    "image_url": imageUrl,
    "slide_image_url": slideImageUrl,
    "cat_id": catId,
  };
}

class Datum {
  dynamic id;
  dynamic catId;
  dynamic imageUrl;
  dynamic catName;

  Datum({
    this.id,
    this.catId,
    this.imageUrl,
    this.catName,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    catId: json["cat_id"],
    imageUrl: json["image_url"],
    catName: json["cat_name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "cat_id": catId,
    "image_url": imageUrl,
    "cat_name": catName,
  };
}

class SpecialPattern {
  dynamic id;
  dynamic pCatId;
  dynamic title;
  dynamic subTitle;
  dynamic imageUrl;

  SpecialPattern({
    this.id,
    this.pCatId,
    this.title,
    this.subTitle,
    this.imageUrl,
  });

  factory SpecialPattern.fromJson(String str) => SpecialPattern.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SpecialPattern.fromMap(Map<String, dynamic> json) => SpecialPattern(
    id: json["id"],
    pCatId: json["p_cat_id"],
    title: json["title"],
    subTitle: json["sub_title"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "p_cat_id": pCatId,
    "title": title,
    "sub_title": subTitle,
    "image_url": imageUrl,
  };
}
