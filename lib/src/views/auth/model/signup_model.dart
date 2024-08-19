import 'dart:convert';

class SignUpRes {
  dynamic success;
  dynamic message;
  Data? data;

  SignUpRes({
    this.success,
    this.message,
    this.data,
  });

  factory SignUpRes.fromJson(String str) => SignUpRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SignUpRes.fromMap(Map<String, dynamic> json) => SignUpRes(
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
  dynamic mobileNumber;
  dynamic otpCode;
  dynamic otpToken;
  DateTime? updatedAt;
  DateTime? createdAt;
  dynamic id;

  Data({
    this.mobileNumber,
    this.otpCode,
    this.otpToken,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    mobileNumber: json["mobile_number"]??null,
    otpCode: json["otp_code"]??null,
    otpToken: json["otp_token"]??null,
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toMap() => {
    "mobile_number": mobileNumber??null,
    "otp_code": otpCode??null,
    "otp_token": otpToken??null,
    "updated_at": updatedAt,
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
