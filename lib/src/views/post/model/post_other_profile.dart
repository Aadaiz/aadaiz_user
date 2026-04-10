import 'dart:convert';

class OtherProfileRes {
  bool? status;
  Data? data;
  String? message;

  OtherProfileRes({
    this.status,
    this.data,
    this.message,
  });

  factory OtherProfileRes.fromJson(String str) => OtherProfileRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OtherProfileRes.fromMap(Map<String, dynamic> json) => OtherProfileRes(
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
  User? user;
  Posts? posts;

  Data({
    this.user,
    this.posts,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : User.fromMap(json["user"]),
    posts: json["posts"] == null ? null : Posts.fromMap(json["posts"]),
  );

  Map<String, dynamic> toMap() => {
    "user": user?.toMap(),
    "posts": posts?.toMap(),
  };
}

class Posts {
  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Posts({
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

  factory Posts.fromJson(String str) => Posts.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Posts.fromMap(Map<String, dynamic> json) => Posts(
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
  int? id;
  String? userId;
  String? postImage;
  String? caption;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? likesCount;
  int? commentsCount;
  bool? isLiked;
  bool? isSaved;

  Datum({
    this.id,
    this.userId,
    this.postImage,
    this.caption,
    this.createdAt,
    this.updatedAt,
    this.likesCount,
    this.commentsCount,
    this.isLiked,
    this.isSaved,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    postImage: json["post_image"],
    caption: json["caption"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    likesCount: json["likes_count"],
    commentsCount: json["comments_count"],
    isLiked: json["is_liked"],
    isSaved: json["is_saved"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "post_image": postImage,
    "caption": caption,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "likes_count": likesCount,
    "comments_count": commentsCount,
    "is_liked": isLiked,
    "is_saved": isSaved,
  };
}

class Link {
  String? url;
  String? label;
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

class User {
  int? id;
  String? username;
  String? profileImage;
  int? followersCount;
  int? followingCount;
  bool? isFollowing;
  String? bio;
  dynamic conversationId;


  User({
    this.id,
    this.username,
    this.profileImage,
    this.followersCount,
    this.followingCount,
    this.isFollowing,
    this.bio,
    this.conversationId,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    profileImage: json["profile_image"],
    followersCount: json["followers_count"],
    followingCount: json["following_count"],
    isFollowing: json["is_following"],
    bio: json["bio"],
    conversationId: json["conversation_id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "username": username,
    "profile_image": profileImage,
    "followers_count": followersCount,
    "following_count": followingCount,
    "is_following": isFollowing,
    "bio": bio,
    "conversation_id": conversationId,

  };
}
