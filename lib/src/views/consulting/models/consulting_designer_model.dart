import 'dart:convert';

class ConsultingDesignerRes {
  bool? status;
  dynamic message;
  DesignerPagination? data;

  ConsultingDesignerRes({
    this.status,
    this.message,
    this.data,
  });

  factory ConsultingDesignerRes.fromJson(String str) =>
      ConsultingDesignerRes.fromMap(json.decode(str));

  factory ConsultingDesignerRes.fromMap(Map<String, dynamic> json) =>
      ConsultingDesignerRes(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DesignerPagination.fromMap(json["data"]),
      );
}

class DesignerPagination {
  dynamic currentPage;
  List<Designer>? data;
  dynamic total;

  DesignerPagination({
    this.currentPage,
    this.data,
    this.total,
  });

  factory DesignerPagination.fromMap(Map<String, dynamic> json) =>
      DesignerPagination(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Designer>.from(
          json["data"].map((x) => Designer.fromMap(x)),
        ),
        total: json["total"],
      );
}

class Designer {
  dynamic id;
  dynamic accountType;
  dynamic email;
  dynamic name;
  dynamic gender;
  dynamic education;
  dynamic profilePhoto;
  dynamic mobileNumber;
  dynamic experience;
  dynamic consultationFee;
  dynamic consultationType;
  dynamic description;
  dynamic area;
  dynamic city;
  dynamic state;
  dynamic country;
  dynamic pincode;
  dynamic status;
  dynamic isAvailable;
  dynamic commissionPercentage;
  DateTime? createdAt;
  DateTime? updatedAt;

  Designer({
    this.id,
    this.accountType,
    this.email,
    this.name,
    this.gender,
    this.education,
    this.profilePhoto,
    this.mobileNumber,
    this.experience,
    this.consultationFee,
    this.consultationType,
    this.description,
    this.area,
    this.city,
    this.state,
    this.country,
    this.pincode,
    this.status,
    this.isAvailable,
    this.commissionPercentage,
    this.createdAt,
    this.updatedAt,
  });

  factory Designer.fromJson(String str) => Designer.fromMap(json.decode(str));

  factory Designer.fromMap(Map<String, dynamic> json) => Designer(
    id: json["id"],
    accountType: json["account_type"],
    email: json["email"],
    name: json["name"],
    gender: json["gender"],
    education: json["education"],
    profilePhoto: json["profile_photo"],
    mobileNumber: json["mobile_number"],
    experience: json["experience"],
    consultationFee: json["consultation_fee"],
    consultationType: json["consultation_type"],
    description: json["description"],
    area: json["area"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    pincode: json["pincode"],
    status: json["status"],
    isAvailable: json["is_available"],
    commissionPercentage: json["commission_percentage"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );
}