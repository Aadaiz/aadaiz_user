import 'dart:convert';

class MaterialListRes {
  bool? status;
  MaterialList? materialList;
  List<Datum>? peopleMostViewlist;

  MaterialListRes({
    this.status,
    this.materialList,
    this.peopleMostViewlist,
  });

  factory MaterialListRes.fromJson(String str) => MaterialListRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MaterialListRes.fromMap(Map<String, dynamic> json) => MaterialListRes(
    status: json["status"],
    materialList: json["materialList"] == null ? null : MaterialList.fromMap(json["materialList"]),
    peopleMostViewlist: json["peopleMostViewlist"] == null ? [] : List<Datum>.from(json["peopleMostViewlist"]!.map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "materialList": materialList?.toMap(),
    "peopleMostViewlist": peopleMostViewlist == null ? [] : List<dynamic>.from(peopleMostViewlist!.map((x) => x.toMap())),
  };
}

class MaterialList {
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

  MaterialList({
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

  factory MaterialList.fromJson(String str) => MaterialList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MaterialList.fromMap(Map<String, dynamic> json) => MaterialList(
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
  dynamic isLiked;

  Datum({
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
    this.isLiked,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
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
    isLiked: json["is_liked"],
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
    "is_liked": isLiked,
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

