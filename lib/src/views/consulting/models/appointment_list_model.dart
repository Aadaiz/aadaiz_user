class AppointmentRes {
  final bool? status;
  final String? message;
  final List<AppointmentData> data;

  AppointmentRes({this.status, this.message, required this.data});

  factory AppointmentRes.fromMap(Map<String, dynamic> map) {
    return AppointmentRes(
      status: map['status'],
      message: map['message'],
      data: map['data'] != null
          ? List<AppointmentData>.from(
          (map['data'] as List).map((x) => AppointmentData.fromMap(x)))
          : [],
    );
  }
}

class AppointmentData {
  final int? id;
  final String? userId;
  final String? designerId;
  final String? date;
  final String? time;
  final String? amount;
  final String? duration;
  final String? status;
  final String? consultationType;
  final String? name;
  final String? mobileNumber;
  final String? area;
  final String? city;
  final String? state;
  final String? landmark;
  final String? pincode;
  final bool? isCancelled;
  final bool? isReschedule;
  final AppointmentDesigner? designer;
  final List<BookingImage> designerbookingImage;

  AppointmentData({
    this.id,
    this.userId,
    this.designerId,
    this.date,
    this.time,
    this.amount,
    this.duration,
    this.status,
    this.consultationType,
    this.name,
    this.mobileNumber,
    this.area,
    this.city,
    this.state,
    this.landmark,
    this.pincode,
    this.isCancelled,
    this.isReschedule,
    this.designer,
    required this.designerbookingImage,
  });

  factory AppointmentData.fromMap(Map<String, dynamic> map) {
    return AppointmentData(
      id: map['id'],
      userId: map['user_id']?.toString(),
      designerId: map['designer_id']?.toString(),
      date: map['date'],
      time: map['time']?.toString(),
      amount: map['amount']?.toString(),
      duration: map['duration']?.toString(),
      status: map['status'],
      consultationType: map['consultation_type'],
      name: map['name'],
      mobileNumber: map['mobile_number'],
      area: map['area'],
      city: map['city'],
      state: map['state'],
      landmark: map['landmark'],
      pincode: map['pincode'],
      isCancelled: map['is_cancelled'],
      isReschedule: map['is_reschedule'],
      designer: map['designer'] != null
          ? AppointmentDesigner.fromMap(map['designer'])
          : null,
      designerbookingImage: map['designerbooking_image'] != null
          ? List<BookingImage>.from(
          (map['designerbooking_image'] as List)
              .map((x) => BookingImage.fromMap(x)))
          : [],
    );
  }
}

class AppointmentDesigner {
  final int? id;
  final String? name;
  final String? gender;
  final String? profilePhoto;
  final String? mobileNumber;
  final String? consultationFee;
  final String? consultationType;
  final String? description;
  final String? experience;

  AppointmentDesigner({
    this.id,
    this.name,
    this.gender,
    this.profilePhoto,
    this.mobileNumber,
    this.consultationFee,
    this.consultationType,
    this.description,
    this.experience,
  });

  factory AppointmentDesigner.fromMap(Map<String, dynamic> map) {
    return AppointmentDesigner(
      id: map['id'],
      name: map['name'],
      gender: map['gender'],
      profilePhoto: map['profile_photo'],
      mobileNumber: map['mobile_number'],
      consultationFee: map['consultation_fee']?.toString(),
      consultationType: map['consultation_type'],
      description: map['description'],
      experience: map['experience']?.toString(),
    );
  }
}

class BookingImage {
  final int? id;
  final String? bookingId;
  final String? image;

  BookingImage({this.id, this.bookingId, this.image});

  factory BookingImage.fromMap(Map<String, dynamic> map) {
    return BookingImage(
      id: map['id'],
      bookingId: map['booking_id']?.toString(),
      image: map['image'],
    );
  }
}