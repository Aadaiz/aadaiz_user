import 'dart:convert';

class ReviewListRes {
  bool? status;
  Data? data;
  List<int>? ratingCounts;
  dynamic totalRatings;
  double? averageRating;
  dynamic message;

  ReviewListRes({
    this.status,
    this.data,
    this.ratingCounts,
    this.totalRatings,
    this.averageRating,
    this.message,
  });

  factory ReviewListRes.fromJson(String str) => ReviewListRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReviewListRes.fromMap(Map<String, dynamic> json) => ReviewListRes(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
    ratingCounts: json["ratingCounts"] == null ? [] : List<int>.from(json["ratingCounts"]!.map((x) => x)),
    totalRatings: json["totalRatings"],
    averageRating: json["averageRating"]?.toDouble(),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": data?.toMap(),
    "ratingCounts": ratingCounts == null ? [] : List<dynamic>.from(ratingCounts!.map((x) => x)),
    "totalRatings": totalRatings,
    "averageRating": averageRating,
    "message": message,
  };
}

class Data {
  dynamic currentPage;
  List<Review>? data;
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
    data: json["data"] == null ? [] : List<Review>.from(json["data"]!.map((x) => Review.fromMap(x))),
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

class Review {
  dynamic id;
  dynamic userId;
  dynamic rating;
  dynamic comment;
  dynamic images;
  dynamic date;
  dynamic time;
  User? user;

  Review({
    this.id,
    this.userId,
    this.rating,
    this.comment,
    this.images,
    this.date,
    this.time,
    this.user,
  });

  factory Review.fromJson(String str) => Review.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Review.fromMap(Map<String, dynamic> json) => Review(
    id: json["id"]??null,
    userId: json["user_id"]??null,
    rating: json["rating"]??null,
    comment: json["comment"]??null,
    images: json["images"],
    date: json["date"]??null,
    time: json["time"]??null,
    user: json["user"] == null ? null : User.fromMap(json["user"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id??null,
    "user_id": userId??null,
    "rating": rating??null,
    "comment": comment??null,
    "images": images??null,
    "date": date??null,
    "time": time??null,
    "user": user?.toMap(),
  };
}

class User {
  dynamic id;
  dynamic username;
  dynamic profile;

  User({
    this.id,
    this.username,
    this.profile,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"]??null,
    username: json["username"]??null,
    profile: json["profile"]??null,
  );

  Map<String, dynamic> toMap() => {
    "id": id??null,
    "username": username??null,
    "profile": profile??null,
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
