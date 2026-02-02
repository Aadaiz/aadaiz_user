import 'dart:convert';

class FilterCategory {
  bool? status;
  List<String>? colors;
  List<Category>? categories;

  FilterCategory({
    this.status,
    this.colors,
    this.categories,
  });

  factory FilterCategory.fromJson(String str) => FilterCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FilterCategory.fromMap(Map<String, dynamic> json) => FilterCategory(
    status: json["status"],
    colors: json["colors"] == null ? [] : List<String>.from(json["colors"]!.map((x) => x)),
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "colors": colors == null ? [] : List<dynamic>.from(colors!.map((x) => x)),
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toMap())),
  };
}

class Category {
  String? category;
  String? image;

  Category({
    this.category,
    this.image,
  });

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    category: json["category"],
    image: json["image"],
  );

  Map<String, dynamic> toMap() => {
    "category": category,
    "image": image,
  };
}
