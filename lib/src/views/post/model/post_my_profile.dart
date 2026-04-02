import 'dart:convert';

class MyPostProfile {
  bool? status;
  Data? data;
  String? message;

  MyPostProfile({
    this.status,
    this.data,
    this.message,
  });

  factory MyPostProfile.fromJson(String str) =>
      MyPostProfile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyPostProfile.fromMap(Map<String, dynamic> json) =>
      MyPostProfile(
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
  DataUser? user;
  Posts? posts;
  SavedPosts? savedPosts;

  Data({
    this.user,
    this.posts,
    this.savedPosts,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : DataUser.fromMap(json["user"]),
    posts: json["posts"] == null ? null : Posts.fromMap(json["posts"]),
    savedPosts: json["saved_posts"] == null
        ? null
        : SavedPosts.fromMap(json["saved_posts"]),
  );

  Map<String, dynamic> toMap() => {
    "user": user?.toMap(),
    "posts": posts?.toMap(),
    "saved_posts": savedPosts?.toMap(),
  };
}

class Posts {
  int? currentPage;
  List<PostsDatum>? data;
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
    data: json["data"] == null
        ? []
        : List<PostsDatum>.from(
        json["data"]!.map((x) => PostsDatum.fromMap(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null
        ? []
        : List<Link>.from(json["links"]!.map((x) => Link.fromMap(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toMap() => {
    "current_page": currentPage,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toMap())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null
        ? []
        : List<dynamic>.from(links!.map((x) => x.toMap())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class PostsDatum {
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

  PostsDatum({
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

  factory PostsDatum.fromJson(String str) =>
      PostsDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostsDatum.fromMap(Map<String, dynamic> json) => PostsDatum(
    id: json["id"],
    userId: json["user_id"]?.toString(),
    postImage: json["post_image"],
    caption: json["caption"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    likesCount: json["likes_count"],
    commentsCount: json["comments_count"],
    isLiked: json["is_liked"],
    isSaved: json["is_saved"],
    user: json["user"] == null ? null : DatumUser.fromMap(json["user"]),
    postComment: json["post_comment"] == null
        ? []
        : List<PostComment>.from(
        json["post_comment"]!.map((x) => PostComment.fromMap(x))),
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
    "post_comment": postComment == null
        ? []
        : List<dynamic>.from(postComment!.map((x) => x.toMap())),
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

  factory PostComment.fromJson(String str) =>
      PostComment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostComment.fromMap(Map<String, dynamic> json) => PostComment(
    id: json["id"],
    userId: json["user_id"]?.toString(),
    postId: json["post_id"]?.toString(),
    comment: json["comment"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    user: json["user"] == null
        ? null
        : PostCommentUser.fromMap(json["user"]),
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

  PostCommentUser({
    this.id,
    this.username,
  });

  factory PostCommentUser.fromJson(String str) =>
      PostCommentUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostCommentUser.fromMap(Map<String, dynamic> json) =>
      PostCommentUser(
        id: json["id"],
        username: json["username"],
      );

  Map<String, dynamic> toMap() => {
    "id": id,
    "username": username,
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

  factory DatumUser.fromJson(String str) =>
      DatumUser.fromMap(json.decode(str));

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

class SavedPosts {
  int? currentPage;
  List<SavedPostsDatum>? data;
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

  SavedPosts({
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

  factory SavedPosts.fromJson(String str) =>
      SavedPosts.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SavedPosts.fromMap(Map<String, dynamic> json) => SavedPosts(
    currentPage: json["current_page"],
    data: json["data"] == null
        ? []
        : List<SavedPostsDatum>.from(
        json["data"]!.map((x) => SavedPostsDatum.fromMap(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null
        ? []
        : List<Link>.from(json["links"]!.map((x) => Link.fromMap(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toMap() => {
    "current_page": currentPage,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toMap())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null
        ? []
        : List<dynamic>.from(links!.map((x) => x.toMap())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class SavedPostsDatum {
  int? id;
  String? userId;
  String? postId;
  String? isSaved;
  DateTime? createdAt;
  DateTime? updatedAt;
  Post? post;

  SavedPostsDatum({
    this.id,
    this.userId,
    this.postId,
    this.isSaved,
    this.createdAt,
    this.updatedAt,
    this.post,
  });

  factory SavedPostsDatum.fromJson(String str) =>
      SavedPostsDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SavedPostsDatum.fromMap(Map<String, dynamic> json) =>
      SavedPostsDatum(
        id: json["id"],
        userId: json["user_id"]?.toString(),
        postId: json["post_id"]?.toString(),
        isSaved: json["is_saved"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        post: json["post"] == null ? null : Post.fromMap(json["post"]),
      );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "post_id": postId,
    "is_saved": isSaved,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "post": post?.toMap(),
  };
}

class Post {
  int? id;
  String? userId;
  String? postImage;
  String? caption;
  DateTime? createdAt;
  DateTime? updatedAt;
  DatumUser? user;
  List<PostComment>? postComment;

  Post({
    this.id,
    this.userId,
    this.postImage,
    this.caption,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.postComment,
  });

  factory Post.fromJson(String str) => Post.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Post.fromMap(Map<String, dynamic> json) => Post(
    id: json["id"],
    userId: json["user_id"]?.toString(),
    postImage: json["post_image"],
    caption: json["caption"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    user: json["user"] == null ? null : DatumUser.fromMap(json["user"]),
    postComment: json["post_comment"] == null
        ? []
        : List<PostComment>.from(
        json["post_comment"]!.map((x) => PostComment.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "post_image": postImage,
    "caption": caption,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "user": user?.toMap(),
    "post_comment": postComment == null
        ? []
        : List<dynamic>.from(postComment!.map((x) => x.toMap())),
  };
}

class DataUser {
  int? id;
  String? username;
  String? bio;
  String? profileImage;
  int? followersCount;
  int? followingCount;

  DataUser({
    this.id,
    this.username,
    this.bio,
    this.profileImage,
    this.followersCount,
    this.followingCount,
  });

  factory DataUser.fromJson(String str) =>
      DataUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataUser.fromMap(Map<String, dynamic> json) => DataUser(
    id: json["id"],
    username: json["username"],
    bio: json["bio"],
    profileImage: json["profile_image"],
    followersCount: json["followers_count"],
    followingCount: json["following_count"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "username": username,
    "bio": bio,
    "profile_image": profileImage,
    "followers_count": followersCount,
    "following_count": followingCount,
  };
}