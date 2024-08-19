import 'dart:convert';

class ProductListRes {
  bool? status;
  PatternList? patternList;
  PeopleMostViewlist? peopleMostViewlist;

  ProductListRes({
    this.status,
    this.patternList,
    this.peopleMostViewlist,
  });

  factory ProductListRes.fromJson(String str) => ProductListRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductListRes.fromMap(Map<String, dynamic> json) => ProductListRes(
    status: json["status"],
    patternList: json["patternList"] == null ? null : PatternList.fromMap(json["patternList"]),
    peopleMostViewlist: json["peopleMostViewlist"] == null ? null : PeopleMostViewlist.fromMap(json["peopleMostViewlist"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "patternList": patternList?.toMap(),
    "peopleMostViewlist": peopleMostViewlist?.toMap(),
  };
}

class PatternList {
  dynamic currentPage;
  List<PatternListDatum>? data;
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

  PatternList({
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

  factory PatternList.fromJson(String str) => PatternList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PatternList.fromMap(Map<String, dynamic> json) => PatternList(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<PatternListDatum>.from(json["data"]!.map((x) => PatternListDatum.fromMap(x))),
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

class PatternListDatum {
  dynamic id;
  dynamic pCatId;
  dynamic title;
  dynamic subTitle;
  dynamic price;
  dynamic imageUrl;
  dynamic sizes;
  dynamic description;
  dynamic rating;
  dynamic gstPercentage;
  dynamic length;
  dynamic breadth;
  dynamic height;
  dynamic isLiked;

  PatternListDatum({
    this.id,
    this.pCatId,
    this.title,
    this.subTitle,
    this.price,
    this.imageUrl,
    this.sizes,
    this.description,
    this.rating,
    this.gstPercentage,
    this.length,
    this.breadth,
    this.height,
    this.isLiked,
  });

  factory PatternListDatum.fromJson(String str) => PatternListDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PatternListDatum.fromMap(Map<String, dynamic> json) => PatternListDatum(
    id: json["id"]??null,
    pCatId: json["p_cat_id"]??null,
    title: json["title"]??null,
    subTitle: json["sub_title"]??null,
    price: json["price"]??null,
    imageUrl: json["image_url"]??null,
    sizes: json["sizes"]??null,
    description: json["description"]??null,
    rating: json["rating"]??null,
    gstPercentage: json["gst_percentage"]??null,
    length: json["length"]??null,
    breadth: json["breadth"]??null,
    height: json["height"]??null,
    isLiked: json["isLiked"]??null,
  );

  Map<String, dynamic> toMap() => {
    "id": id??null,
    "p_cat_id": pCatId??null,
    "title": title??null,
    "sub_title": subTitle??null,
    "price": price??null,
    "image_url": imageUrl??null,
    "sizes": sizes??null,
    "description": description??null,
    "rating": rating??null,
    "gst_percentage": gstPercentage??null,
    "length": length??null,
    "breadth": breadth??null,
    "height": height??null,
    "isLiked": isLiked??null,
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

class PeopleMostViewlist {
  dynamic currentPage;
  List<PatternListDatum>? data;
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

  PeopleMostViewlist({
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

  factory PeopleMostViewlist.fromJson(String str) => PeopleMostViewlist.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PeopleMostViewlist.fromMap(Map<String, dynamic> json) => PeopleMostViewlist(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<PatternListDatum>.from(json["data"]!.map((x) => PatternListDatum.fromMap(x))),
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


