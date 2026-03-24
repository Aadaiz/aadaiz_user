import 'dart:convert';

class ProfileRes {
  bool? status;
  dynamic message;
  User? user;

  ProfileRes({
    this.status,
    this.message,
    this.user,
  });

  factory ProfileRes.fromJson(String str) => ProfileRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfileRes.fromMap(Map<String, dynamic> json) => ProfileRes(
    status: json["status"],
    message: json["message"],
    user: json["user"] == null ? null : User.fromMap(json["user"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "user": user?.toMap(),
  };
}

class User {
  dynamic id;
  dynamic username;
  dynamic email;
  dynamic mobileNumber;
  dynamic gender;
  dynamic profileImage;
  dynamic age;
  dynamic role;
  dynamic fcmToken;
  dynamic isVerify;
  dynamic socialId;
  dynamic userWallet;
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
    this.fcmToken,
    this.isVerify,
    this.socialId,
    this.userWallet,
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
    fcmToken: json["fcm_token"],
    isVerify: json["is_verify"],
    socialId: json["social_id"],
    userWallet: json["user_wallet"],
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
    "fcm_token": fcmToken,
    "is_verify": isVerify,
    "social_id": socialId,
    "user_wallet": userWallet,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
