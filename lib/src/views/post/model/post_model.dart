import 'dart:convert';

class ProfileModel {
  final String name;
  final String profileImage;
  final String coverImage;
  final String bio;
  final String followers;
  final String following;
  final List<String> posts;

  ProfileModel({
    required this.name,
    required this.profileImage,
    required this.coverImage,
    required this.bio,
    required this.followers,
    required this.following,
    required this.posts,
  });
}



class PostListRes {
  bool? status;
  Data? data;
  String? message;

  PostListRes({
    this.status,
    this.data,
    this.message,
  });

  factory PostListRes.fromJson(String str) => PostListRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostListRes.fromMap(Map<String, dynamic> json) => PostListRes(
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
  DatumUser? user;
  List<PostComment>? postComment;

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
    this.user,
    this.postComment,
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
    user: json["user"] == null ? null : DatumUser.fromMap(json["user"]),
    postComment: json["post_comment"] == null ? [] : List<PostComment>.from(json["post_comment"]!.map((x) => PostComment.fromMap(x))),
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
    "user": user?.toMap(),
    "post_comment": postComment == null ? [] : List<dynamic>.from(postComment!.map((x) => x.toMap())),
  };
}

class PostComment {
  int? id;
  String? userId;
  String? postId;
  String? comment;
  DateTime? createdAt;
  DateTime? updatedAt;
  PostCommentUser? user;

  PostComment({
    this.id,
    this.userId,
    this.postId,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory PostComment.fromJson(String str) => PostComment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostComment.fromMap(Map<String, dynamic> json) => PostComment(
    id: json["id"],
    userId: json["user_id"],
    postId: json["post_id"],
    comment: json["comment"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    user: json["user"] == null ? null : PostCommentUser.fromMap(json["user"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "post_id": postId,
    "comment": comment,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "user": user?.toMap(),
  };
}

class PostCommentUser {
  int? id;
  String? username;
  String? userProfileImage;


  PostCommentUser({
    this.id,
    this.username,
    this.userProfileImage,
  });

  factory PostCommentUser.fromJson(String str) => PostCommentUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostCommentUser.fromMap(Map<String, dynamic> json) => PostCommentUser(
    id: json["id"],
    username: json["username"],
    userProfileImage: json["profile_image"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "username": username,
    "profile_image": userProfileImage,
  };
}

class DatumUser {
  int? id;
  String? username;
  String? profileImage;

  DatumUser({
    this.id,
    this.username,
    this.profileImage,
  });

  factory DatumUser.fromJson(String str) => DatumUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DatumUser.fromMap(Map<String, dynamic> json) => DatumUser(
    id: json["id"],
    username: json["username"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "username": username,
    "profile_image": profileImage,
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




