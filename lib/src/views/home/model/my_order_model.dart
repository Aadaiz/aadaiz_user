import 'dart:convert';

class MyOrderListRes {
  bool? status;
  Data? data;
  dynamic message;

  MyOrderListRes({
    this.status,
    this.data,
    this.message,
  });

  factory MyOrderListRes.fromJson(String str) => MyOrderListRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyOrderListRes.fromMap(Map<String, dynamic> json) => MyOrderListRes(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": data?.toMap(),
    "message": message,
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
  dynamic orderId;
  dynamic rating;
  dynamic patternId;
  dynamic patternTitle;
  dynamic patternSubtitle;
  dynamic patternImage;
  dynamic patternPrice;
  dynamic cancelHours;
  dynamic cancelStatus;
  dynamic orderStatus;
  dynamic size;
  dynamic fabricMetre;
  dynamic measurement;
  PatternDetails? patternDetails;
  Viewlist? viewlist;

  Datum({
    this.orderId,
    this.rating,
    this.patternId,
    this.patternTitle,
    this.patternSubtitle,
    this.patternImage,
    this.patternPrice,
    this.cancelHours,
    this.cancelStatus,
    this.orderStatus,
    this.size,
    this.fabricMetre,
    this.measurement,
    this.patternDetails,
    this.viewlist,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    orderId: json["order_id"]??null,
    rating: json["rating"]??null,
    patternId: json["pattern_id"]??null,
    patternTitle: json["pattern_title"]??null,
    patternSubtitle: json["pattern_subtitle"]??null,
    patternImage: json["pattern_image"]??null,
    patternPrice: json["pattern_price"]??null,
    cancelHours: json["cancel_hours"]??null,
    cancelStatus: json["cancel_status"]??null,
    orderStatus: json["order_status"]??null,
    size: json["size"]??null,
    fabricMetre: json["fabric_metre"]??null,
    measurement: json["measurement"]??null,
    patternDetails: json["pattern_details"] == null ? null : PatternDetails.fromMap(json["pattern_details"]),
    viewlist: json["viewlist"] == null ? null : Viewlist.fromMap(json["viewlist"]),
  );

  Map<String, dynamic> toMap() => {
    "order_id": orderId??null,
    "rating": rating??null,
    "pattern_id": patternId??null,
    "pattern_title": patternTitle??null,
    "pattern_subtitle": patternSubtitle??null,
    "pattern_image": patternImage??null,
    "pattern_price": patternPrice??null,
    "cancel_hours": cancelHours??null,
    "cancel_status": cancelStatus??null,
    "order_status": orderStatus??null,
    "size": size??null,
    "fabric_metre": fabricMetre??null,
    "measurement": measurement??null,
    "pattern_details": patternDetails?.toMap(),
    "viewlist": viewlist?.toMap(),
  };
}

class PatternDetails {
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

  PatternDetails({
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

  factory PatternDetails.fromJson(String str) => PatternDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PatternDetails.fromMap(Map<String, dynamic> json) => PatternDetails(
    id: json["id"]??null,
    pCatId: json["p_cat_id"]??null,
    filterCategoryId: json["filter_category_id"]??null,
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
    weight: json["weight"]??null,
    peopleView: json["people_view"]??null,
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id??null,
    "p_cat_id": pCatId??null,
    "filter_category_id": filterCategoryId??null,
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
    "weight": weight??null,
    "people_view": peopleView??null,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Viewlist {
  dynamic currentPage;
  List<PatternDetails>? data;
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

  Viewlist({
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

  factory Viewlist.fromJson(String str) => Viewlist.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Viewlist.fromMap(Map<String, dynamic> json) => Viewlist(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<PatternDetails>.from(json["data"]!.map((x) => PatternDetails.fromMap(x))),
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
