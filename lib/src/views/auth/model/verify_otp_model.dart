import 'dart:convert';

class VerifyOtpRes {
  dynamic success;
  dynamic message;
  Data? data;

  VerifyOtpRes({
    this.success,
    this.message,
    this.data,
  });

  factory VerifyOtpRes.fromJson(String str) =>
      VerifyOtpRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VerifyOtpRes.fromMap(Map<String, dynamic> json) => VerifyOtpRes(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message,
    "data": data?.toMap(),
  };
}

class Data {
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
  dynamic deleted;
 dynamic createdAt;
 dynamic updatedAt;
  dynamic token;

  Data({
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
    this.deleted,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
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
    deleted: json["deleted"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    token: json["token"],
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
    "deleted": deleted,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "token": token,
  };
}
