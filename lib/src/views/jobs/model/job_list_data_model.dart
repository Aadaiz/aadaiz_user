import 'dart:convert';

class JobListResponse {
  bool? status;
  Data? data;
  String? message;

  JobListResponse({
    this.status,
    this.data,
    this.message,
  });

  factory JobListResponse.fromJson(String str) => JobListResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory JobListResponse.fromMap(Map<String, dynamic> json) => JobListResponse(
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
  AppliedJobs? ourJobs;
  AppliedJobs? recentJobs;
  AppliedJobs? appliedJobs;
  AppliedJobs? myJobApplicants;

  Data({
    this.ourJobs,
    this.recentJobs,
    this.appliedJobs,
    this.myJobApplicants,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    ourJobs: json["our_jobs"] == null ? null : AppliedJobs.fromMap(json["our_jobs"]),
    recentJobs: json["recent_jobs"] == null ? null : AppliedJobs.fromMap(json["recent_jobs"]),
    appliedJobs: json["applied_jobs"] == null ? null : AppliedJobs.fromMap(json["applied_jobs"]),
    myJobApplicants: json["my_job_applicants"] == null ? null : AppliedJobs.fromMap(json["my_job_applicants"]),
  );

  Map<String, dynamic> toMap() => {
    "our_jobs": ourJobs?.toMap(),
    "recent_jobs": recentJobs?.toMap(),
    "applied_jobs": appliedJobs?.toMap(),
    "my_job_applicants": myJobApplicants?.toMap(),
  };
}

class AppliedJobs {
  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  AppliedJobs({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory AppliedJobs.fromJson(String str) => AppliedJobs.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AppliedJobs.fromMap(Map<String, dynamic> json) => AppliedJobs(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromMap(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toMap() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toMap())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  int? id;
  String? userId;
  String? jobTitle;
  String? jobCategory;
  String? jobType;
  String? numberOfOpenings;
  String? jobCity;
  String? jobArea;
  String? jobState;
  String? jobCountry;
  String? jobPincode;
  String? gender;
  String? qualification;
  String? isFresher;
  String? minExp;
  String? maxExp;
  String? salaryFrom;
  String? salaryTo;
  String? jobDescription;
  String? jobStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool?applyNow;
  User? user;
  dynamic adminJob;
  dynamic adminJobCategory;
  List<Job>? jobBenefit;
  List<Job>? jobSkill;
  List<Job>? jobRequirement;

  Datum({
    this.id,
    this.userId,
    this.jobTitle,
    this.jobCategory,
    this.jobType,
    this.numberOfOpenings,
    this.jobCity,
    this.jobArea,
    this.jobState,
    this.jobCountry,
    this.jobPincode,
    this.gender,
    this.qualification,
    this.isFresher,
    this.minExp,
    this.maxExp,
    this.salaryFrom,
    this.salaryTo,
    this.jobDescription,
    this.jobStatus,
    this.createdAt,
    this.updatedAt,
    this.applyNow,
    this.user,
    this.adminJob,
    this.adminJobCategory,
    this.jobBenefit,
    this.jobSkill,
    this.jobRequirement,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    jobTitle: json["job_title"],
    jobCategory: json["job_category"],
    jobType: json["job_type"],
    numberOfOpenings: json["number_of_openings"],
    jobCity: json["job_city"],
    jobArea: json["job_area"],
    jobState: json["job_state"],
    jobCountry: json["job_country"],
    jobPincode: json["job_pincode"],
    gender: json["gender"],
    qualification: json["qualification"],
    isFresher: json["is_fresher"],
    minExp: json["min_exp"],
    maxExp: json["max_exp"],
    salaryFrom: json["salary_from"],
    salaryTo: json["salary_to"],
    jobDescription: json["job_description"],
    jobStatus: json["job_status"],
    applyNow: json["apply_now"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    user: json["user"] == null ? null : User.fromMap(json["user"]),
    adminJob: json["admin_job"],
    adminJobCategory: json["admin_job_category"],
    jobBenefit: json["job_benefit"] == null ? [] : List<Job>.from(json["job_benefit"]!.map((x) => Job.fromMap(x))),
    jobSkill: json["job_skill"] == null ? [] : List<Job>.from(json["job_skill"]!.map((x) => Job.fromMap(x))),
    jobRequirement: json["job_requirement"] == null ? [] : List<Job>.from(json["job_requirement"]!.map((x) => Job.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "job_title": jobTitle,
    "job_category": jobCategory,
    "job_type": jobType,
    "number_of_openings": numberOfOpenings,
    "job_city": jobCity,
    "job_area": jobArea,
    "job_state": jobState,
    "job_country": jobCountry,
    "job_pincode": jobPincode,
    "gender": gender,
    "qualification": qualification,
    "is_fresher": isFresher,
    "min_exp": minExp,
    "max_exp": maxExp,
    "salary_from": salaryFrom,
    "salary_to": salaryTo,
    "job_description": jobDescription,
    "job_status": jobStatus,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "apply_now": applyNow,
    "user": user?.toMap(),
    "admin_job": adminJob,
    "admin_job_category": adminJobCategory,
    "job_benefit": jobBenefit == null ? [] : List<dynamic>.from(jobBenefit!.map((x) => x.toMap())),
    "job_skill": jobSkill == null ? [] : List<dynamic>.from(jobSkill!.map((x) => x.toMap())),
    "job_requirement": jobRequirement == null ? [] : List<dynamic>.from(jobRequirement!.map((x) => x.toMap())),
  };
}

class Job {
  int? id;
  String? jobId;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? requirements;

  Job({
    this.id,
    this.jobId,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.requirements,
  });

  factory Job.fromJson(String str) => Job.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Job.fromMap(Map<String, dynamic> json) => Job(
    id: json["id"],
    jobId: json["job_id"],
    name: json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    requirements: json["requirements"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "job_id": jobId,
    "name": name,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "requirements": requirements,
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

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(String str) => Link.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Link.fromMap(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toMap() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
