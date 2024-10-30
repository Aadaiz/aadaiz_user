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
    id: json["id"]??null,
    username: json["username"]??null,
    email: json["email"]??null,
    mobileNumber: json["mobile_number"]??null,
    gender: json["gender"]??null,
    profileImage: json["profile_image"]??null,
    age: json["age"]??null,
    role: json["role"]??null,
    fcmToken: json["fcm_token"]??null,
    isVerify: json["is_verify"]??null,
    socialId: json["social_id"]??null,
    userWallet: json["user_wallet"]??null,
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id??null,
    "username": username??null,
    "email": email??null,
    "mobile_number": mobileNumber??null,
    "gender": gender??null,
    "profile_image": profileImage??null,
    "age": age??null,
    "role": role??null,
    "fcm_token": fcmToken??null,
    "is_verify": isVerify??null,
    "social_id": socialId??null,
    "user_wallet": userWallet??null,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
