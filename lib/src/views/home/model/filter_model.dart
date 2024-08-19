import 'dart:convert';

class FilterRes {
  dynamic status;
  dynamic message;
  List<Category>? categories;

  FilterRes({
    this.status,
    this.message,
    this.categories,
  });

  factory FilterRes.fromJson(String str) => FilterRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FilterRes.fromMap(Map<String, dynamic> json) => FilterRes(
    status: json["status"],
    message: json["message"],
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toMap())),
  };
}

class Category {
  dynamic id;
  dynamic catName;
  List<PatternCategory>? patternCategories;

  Category({
    this.id,
    this.catName,
    this.patternCategories,
  });

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json["id"]??null,
    catName: json["cat_name"]??null,
    patternCategories: json["pattern_categories"] == null ? [] : List<PatternCategory>.from(json["pattern_categories"]!.map((x) => PatternCategory.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id??null,
    "cat_name": catName??null,
    "pattern_categories": patternCategories == null ? [] : List<dynamic>.from(patternCategories!.map((x) => x.toMap())),
  };
}

class PatternCategory {
  dynamic id;
  dynamic catName;
  dynamic catId;
  List<PatternFiltercategory>? patternFiltercategories;

  PatternCategory({
    this.id,
    this.catName,
    this.catId,
    this.patternFiltercategories,
  });

  factory PatternCategory.fromJson(String str) => PatternCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PatternCategory.fromMap(Map<String, dynamic> json) => PatternCategory(
    id: json["id"]??null,
    catName: json["cat_name"]??null,
    catId: json["cat_id"]??null,
    patternFiltercategories: json["pattern_filtercategories"] == null ? [] : List<PatternFiltercategory>.from(json["pattern_filtercategories"]!.map((x) => PatternFiltercategory.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id??null,
    "cat_name": catName??null,
    "cat_id": catId??null,
    "pattern_filtercategories": patternFiltercategories == null ? [] : List<dynamic>.from(patternFiltercategories!.map((x) => x.toMap())),
  };
}

class PatternFiltercategory {
  dynamic id;
  dynamic patternCategoriesId;
  dynamic image;
  dynamic name;

  PatternFiltercategory({
    this.id,
    this.patternCategoriesId,
    this.image,
    this.name,
  });

  factory PatternFiltercategory.fromJson(String str) => PatternFiltercategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PatternFiltercategory.fromMap(Map<String, dynamic> json) => PatternFiltercategory(
    id: json["id"]??null,
    patternCategoriesId: json["pattern_categories_id"]??null,
    image: json["image"]??null,
    name: json["name"]??null,
  );

  Map<String, dynamic> toMap() => {
    "id": id??null,
    "pattern_categories_id": patternCategoriesId??null,
    "image": image??null,
    "name": name??null,
  };
}
