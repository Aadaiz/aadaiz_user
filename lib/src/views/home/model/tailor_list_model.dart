import 'dart:convert';

class TailorListRes {
  bool? success;
  Data? data;

  TailorListRes({
    this.success,
    this.data,
  });

  factory TailorListRes.fromJson(String str) => TailorListRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TailorListRes.fromMap(Map<String, dynamic> json) => TailorListRes(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
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
  dynamic accountType;
  dynamic shopName;
  dynamic image;
  dynamic email;
  dynamic mobileNumber;
  Category? category;
  dynamic whatUDone;
  dynamic aadharCard;
  dynamic houseNo;
  dynamic street;
  dynamic pincode;
  dynamic city;
  dynamic landmark;
  dynamic latitude;
  dynamic longitude;
  dynamic accountNumber;
  dynamic confirmAccountNumber;
  dynamic ifscCode;
  dynamic isDefault;
  dynamic avgRate;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.accountType,
    this.shopName,
    this.image,
    this.email,
    this.mobileNumber,
    this.category,
    this.whatUDone,
    this.aadharCard,
    this.houseNo,
    this.street,
    this.pincode,
    this.city,
    this.landmark,
    this.latitude,
    this.longitude,
    this.accountNumber,
    this.confirmAccountNumber,
    this.ifscCode,
    this.isDefault,
    this.avgRate,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    accountType: json["account_type"],
    shopName: json["shop_name"],
    image: json["image"]??'',
    email: json["email"],
    mobileNumber: json["mobile_number"],
    category: json["category"] == null ? null : Category.fromMap(json["category"]),
    whatUDone: json["what_u_done"],
    aadharCard: json["aadhar_card"],
    houseNo: json["house_no"],
    street: json["street"],
    pincode: json["pincode"],
    city: json["city"],
    landmark: json["landmark"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    accountNumber: json["account_number"],
    confirmAccountNumber: json["confirm_account_number"],
    ifscCode: json["ifsc_code"],
    isDefault: json["is_default"],
    avgRate: json["avg_rate"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "account_type": accountType,
    "shop_name": shopName,
    "image": image??"",
    "email": email,
    "mobile_number": mobileNumber,
    "category": category?.toMap(),
    "what_u_done": whatUDone,
    "aadhar_card": aadharCard,
    "house_no": houseNo,
    "street": street,
    "pincode": pincode,
    "city": city,
    "landmark": landmark,
    "latitude": latitude,
    "longitude": longitude,
    "account_number": accountNumber,
    "confirm_account_number": confirmAccountNumber,
    "ifsc_code": ifscCode,
    "is_default": isDefault,
    "avg_rate": avgRate,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Category {
  dynamic filterCategoryId;
  dynamic price;

  Category({
    this.filterCategoryId,
    this.price,
  });

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    filterCategoryId: json["filter_category_id"],
    price: json["price"],
  );

  Map<String, dynamic> toMap() => {
    "filter_category_id": filterCategoryId,
    "price": price,
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
