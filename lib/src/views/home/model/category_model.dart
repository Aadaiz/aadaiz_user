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
    specialPatternText: json["special_pattern_text"]??null,
    catDetails: json["cat_details"] == null ? null : CatDetails.fromMap(json["cat_details"]),
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    specialPatterns: json["special_patterns"] == null ? [] : List<SpecialPattern>.from(json["special_patterns"]!.map((x) => SpecialPattern.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "special_pattern_text": specialPatternText??null,
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
    id: json["id"]??null,
    catName: json["cat_name"]??null,
    imageUrl: json["image_url"]??null,
    slideImageUrl: json["slide_image_url"]??null,
    catId: json["cat_id"]??null,
  );

  Map<String, dynamic> toMap() => {
    "id": id??null,
    "cat_name": catName??null,
    "image_url": imageUrl??null,
    "slide_image_url": slideImageUrl??null,
    "cat_id": catId??null,
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
    id: json["id"]??null,
    catId: json["cat_id"]??null,
    imageUrl: json["image_url"]??null,
    catName: json["cat_name"]??null,
  );

  Map<String, dynamic> toMap() => {
    "id": id??null,
    "cat_id": catId??null,
    "image_url": imageUrl??null,
    "cat_name": catName??null,
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
    id: json["id"]??null,
    pCatId: json["p_cat_id"]??null,
    title: json["title"]??null,
    subTitle: json["sub_title"]??null,
    imageUrl: json["image_url"]??null,
  );

  Map<String, dynamic> toMap() => {
    "id": id??null,
    "p_cat_id": pCatId??null,
    "title": title??null,
    "sub_title": subTitle??null,
    "image_url": imageUrl??null,
  };
}
