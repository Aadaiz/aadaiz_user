import 'dart:convert';

class PostViewDetail {
  bool? status;
  Data? data;
  String? message;

  PostViewDetail({
    this.status,
    this.data,
    this.message,
  });

  factory PostViewDetail.fromJson(String str) => PostViewDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostViewDetail.fromMap(Map<String, dynamic> json) => PostViewDetail(
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
  User? user;
  List<PostComment>? postComment;

  Data({
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

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
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
    user: json["user"] == null ? null : User.fromMap(json["user"]),
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
    "post_comment": postComment == null ? [] : List<dynamic>.from(postComment!.map((x) => x)),
  };
}

class User {
  int? id;
  String? username;
  String? profileImage;

  User({
    this.id,
    this.username,
    this.profileImage,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
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