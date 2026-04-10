import 'dart:convert';

class PostChatList {
  bool? status;
  List<Datum>? data;

  PostChatList({
    this.status,
    this.data,
  });

  factory PostChatList.fromJson(String str) => PostChatList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostChatList.fromMap(Map<String, dynamic> json) => PostChatList(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Datum {
  int? conversationId;
  User? user;
  String? lastMessage;
  DateTime? lastMessageTime;

  Datum({
    this.conversationId,
    this.user,
    this.lastMessage,
    this.lastMessageTime,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    conversationId: json["conversation_id"],
    user: json["user"] == null ? null : User.fromMap(json["user"]),
    lastMessage: json["last_message"],
    lastMessageTime: json["last_message_time"] == null ? null : DateTime.parse(json["last_message_time"]),
  );

  Map<String, dynamic> toMap() => {
    "conversation_id": conversationId,
    "user": user?.toMap(),
    "last_message": lastMessage,
    "last_message_time": lastMessageTime?.toIso8601String(),
  };
}

class User {
  int? id;
  String? username;
  String? email;
  String? mobileNumber;
  String? gender;
  String? profileImage;
  int? age;
  String? role;
  String? bio;
  String? fcmToken;
  int? isVerify;
  dynamic socialId;
  String? userWallet;
  String? token;
  int? deleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.username,
    this.email,
    this.mobileNumber,
    this.gender,
    this.profileImage,
    this.age,
    this.role,
    this.bio,
    this.fcmToken,
    this.isVerify,
    this.socialId,
    this.userWallet,
    this.token,
    this.deleted,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    mobileNumber: json["mobile_number"],
    gender: json["gender"],
    profileImage: json["profile_image"],
    age: json["age"],
    role: json["role"],
    bio: json["bio"],
    fcmToken: json["fcm_token"],
    isVerify: json["is_verify"],
    socialId: json["social_id"],
    userWallet: json["user_wallet"],
    token: json["token"],
    deleted: json["deleted"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "username": username,
    "email": email,
    "mobile_number": mobileNumber,
    "gender": gender,
    "profile_image": profileImage,
    "age": age,
    "role": role,
    "bio": bio,
    "fcm_token": fcmToken,
    "is_verify": isVerify,
    "social_id": socialId,
    "user_wallet": userWallet,
    "token": token,
    "deleted": deleted,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
