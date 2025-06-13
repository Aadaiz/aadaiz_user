import 'dart:convert';

class MaterialFavoritesListRes {
  bool? success;
  dynamic message;
  Data? data;

  MaterialFavoritesListRes({
    this.success,
    this.message,
    this.data,
  });

  factory MaterialFavoritesListRes.fromJson(String str) => MaterialFavoritesListRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MaterialFavoritesListRes.fromMap(Map<String, dynamic> json) => MaterialFavoritesListRes(
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
  List<Datum>? data;
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
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
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

class Datum {
  dynamic id;
  dynamic userId;
  dynamic patternId;
  dynamic materialId;
  dynamic type;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Material? material;

  Datum({
    this.id,
    this.userId,
    this.patternId,
    this.materialId,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.material,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    patternId: json["pattern_id"],
    materialId: json["material_id"],
    type: json["type"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    material: json["material"] == null ? null : Material.fromMap(json["material"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "pattern_id": patternId,
    "material_id": materialId,
    "type": type,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "material": material?.toMap(),
  };
}

class Material {
  dynamic id;
  dynamic title;
  dynamic subtitle;
  dynamic category;
  dynamic image;
  dynamic color;
  dynamic price;
  dynamic aadaizPrice;
  dynamic meter;
  dynamic description;
  dynamic rating;
  dynamic status;
  dynamic peopleView;
  DateTime? createdAt;
  DateTime? updatedAt;

  Material({
    this.id,
    this.title,
    this.subtitle,
    this.category,
    this.image,
    this.color,
    this.price,
    this.aadaizPrice,
    this.meter,
    this.description,
    this.rating,
    this.status,
    this.peopleView,
    this.createdAt,
    this.updatedAt,
  });

  factory Material.fromJson(String str) => Material.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Material.fromMap(Map<String, dynamic> json) => Material(
    id: json["id"],
    title: json["title"],
    subtitle: json["subtitle"],
    category: json["category"],
    image: json["image"],
    color: json["color"],
    price: json["price"],
    aadaizPrice: json["aadaiz_price"],
    meter: json["meter"],
    description: json["description"],
    rating: json["rating"],
    status: json["status"],
    peopleView: json["people_view"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "subtitle": subtitle,
    "category": category,
    "image": image,
    "color": color,
    "price": price,
    "aadaiz_price": aadaizPrice,
    "meter": meter,
    "description": description,
    "rating": rating,
    "status": status,
    "people_view": peopleView,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Link {
  dynamic url;
  dynamic label;
  bool? active;

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
