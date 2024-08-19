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

  factory VerifyOtpRes.fromJson(String str) => VerifyOtpRes.fromMap(json.decode(str));

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
  dynamic username;
  dynamic email;
  dynamic mobileNumber;
  dynamic gender;
  dynamic age;
  dynamic role;
  dynamic isVerify;
  DateTime? updatedAt;
  DateTime? createdAt;
  dynamic id;
  dynamic token;

  Data({
    this.username,
    this.email,
    this.mobileNumber,
    this.gender,
    this.age,
    this.role,
    this.isVerify,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.token,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    username: json["username"]??null,
    email: json["email"]??null,
    mobileNumber: json["mobile_number"]??null,
    gender: json["gender"]??null,
    age: json["age"]??null,
    role: json["role"]??null,
    isVerify: json["is_verify"]??null,
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"]??null,
    token: json["token"]??null,
  );

  Map<String, dynamic> toMap() => {
    "username": username??null,
    "email": email??null,
    "mobile_number": mobileNumber??null,
    "gender": gender??null,
    "age": age??null,
    "role": role??null,
    "is_verify": isVerify??null,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id??null,
    "token": token??null,
  };
}
