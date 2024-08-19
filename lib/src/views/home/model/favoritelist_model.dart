import 'dart:convert';

class FavoriteListRes {
  dynamic success;
  dynamic message;
  Data? data;

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
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message,
    "data": data?.toMap(),
  };
}

class Data {
  dynamic currentPage;
  List<Favorites>? data;
  dynamic firstPageUrl;
  dynamic from;
  dynamic lastPage;
  dynamic lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  dynamic path;
  dynamic perPage;
  dynamic prevPageUrl;
  dynamic to;
  dynamic total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<Favorites>.from(json["data"]!.map((x) => Favorites.fromMap(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromMap(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toMap() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toMap())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Favorites {
  dynamic id;
  dynamic userId;
  dynamic patternId;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Patern? patern;

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
    id: json["id"],
    userId: json["user_id"],
    patternId: json["pattern_id"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    patern: json["patern"] == null ? null : Patern.fromMap(json["patern"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "pattern_id": patternId,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "patern": patern?.toMap(),
  };
}

class Patern {
  dynamic id;
  dynamic pCatId;
  dynamic filterCategoryId;
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
  dynamic weight;
  dynamic peopleView;
  DateTime? createdAt;
  DateTime? updatedAt;

  Patern({
    this.id,
    this.pCatId,
    this.filterCategoryId,
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
    this.weight,
    this.peopleView,
    this.createdAt,
    this.updatedAt,
  });

  factory Patern.fromJson(String str) => Patern.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Patern.fromMap(Map<String, dynamic> json) => Patern(
    id: json["id"],
    pCatId: json["p_cat_id"],
    filterCategoryId: json["filter_category_id"],
    title: json["title"],
    subTitle: json["sub_title"],
    description: json["description"],
    imageUrl: json["image_url"],
    price: json["price"],
    sizes: json["sizes"],
    specialCategory: json["special_category"],
    rating: json["rating"],
    gstPercentage: json["gst_percentage"],
    length: json["length"],
    breadth: json["breadth"],
    height: json["height"],
    weight: json["weight"],
    peopleView: json["people_view"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "p_cat_id": pCatId,
    "filter_category_id": filterCategoryId,
    "title": title,
    "sub_title": subTitle,
    "description": description,
    "image_url": imageUrl,
    "price": price,
    "sizes": sizes,
    "special_category": specialCategory,
    "rating": rating,
    "gst_percentage": gstPercentage,
    "length": length,
    "breadth": breadth,
    "height": height,
    "weight": weight,
    "people_view": peopleView,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Link {
  dynamic url;
  dynamic label;
  dynamic active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(String str) => Link.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Link.fromMap(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toMap() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
