import 'dart:convert';

import 'package:aadaiz/src/views/home/model/add_address_model.dart';

class AddressListRes {
  bool? success;
  String? message;
  List<Address>? data;

  AddressListRes({
    this.success,
    this.message,
    this.data,
  });

  factory AddressListRes.fromJson(String str) => AddressListRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddressListRes.fromMap(Map<String, dynamic> json) => AddressListRes(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Address>.from(json["data"]!.map((x) => Address.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}


