import 'dart:convert';

class AddAddressRes {
  bool? success;
  dynamic message;
  Address? address;

  AddAddressRes({
    this.success,
    this.message,
    this.address,
  });

  factory AddAddressRes.fromJson(String str) => AddAddressRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddAddressRes.fromMap(Map<String, dynamic> json) => AddAddressRes(
    success: json["success"],
    message: json["message"],
    address: json["address"] == null ? null : Address.fromMap(json["address"]),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message,
    "address": address?.toMap(),
  };
}

class Address {
  dynamic id;
  dynamic name;
  dynamic userId;
  dynamic address;
  dynamic landmark;
  dynamic city;
  dynamic state;
  dynamic country;
  dynamic pincode;
  dynamic mobile;
  dynamic role;
  dynamic isDefault;
  DateTime? createdAt;
  DateTime? updatedAt;

  Address({
    this.id,
    this.name,
    this.userId,
    this.address,
    this.landmark,
    this.city,
    this.state,
    this.country,
    this.pincode,
    this.mobile,
    this.role,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
    id: json["id"]??null,
    name: json["name"]??null,
    userId: json["user_id"]??null,
    address: json["address"]??null,
    landmark: json["landmark"]??null,
    city: json["city"]??null,
    state: json["state"]??null,
    country: json["country"]??null,
    pincode: json["pincode"]??null,
    mobile: json["mobile"]??null,
    role: json["role"]??null,
    isDefault: json["is_default"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id??null,
    "name": name??null,
    "user_id": userId??null,
    "address": address??null,
    "landmark": landmark??null,
    "city": city??null,
    "state": state??null,
    "country": country??null,
    "pincode": pincode??null,
    "mobile": mobile??null,
    "role": role??null,
    "is_default": isDefault,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
