import 'dart:developer';

import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/models/appointment_list_model.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/models/consulting_available_slot_model.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/models/consulting_category_model.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/models/consulting_designer_model.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/models/consulting_details_model.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/repository/consulting_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConsultingController extends GetxController {
  static ConsultingController get to => Get.put(ConsultingController());
  var repo = ConsultingRepository();

  RxList<String> categoryListStatic =
      ['Men', 'Women', 'Girl-kid (1-12)', 'Boy-kid (1-12)'].obs;

  RxList<String> designerPrefsListStatic = ['Male', 'Female'].obs;

  RxList<String> dayList =
      [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday',
      ].obs;

  RxList<String> modeList = ['Online', 'Offline'].obs;

  RxInt pickedCategoryIndex = (-1).obs;
  RxInt pickedDesignerIndex = (-1).obs;
  RxInt pickedDayIndex = (-1).obs;

  RxString categoryId = ''.obs;
  RxString designer = ''.obs;
  RxString selectedDay = ''.obs;
  RxString selectedMode = ''.obs;

  var designerLoading = false.obs;
  var designerList = <Designer>[].obs;

  Future<dynamic> getDesigners() async {
    designerLoading(true);
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token") ?? '';
      final Map<String, dynamic> body = {
        "token": token,
        "category": categoryId.value.toLowerCase(),
        "day": selectedDay.value.substring(0, 3).toLowerCase(),
        "consultation_type": selectedMode.value.toLowerCase(),
        "designer_preference": designer.value.toLowerCase(),
      };
      final ConsultingDesignerRes res = await repo.getDesigners(body);
      if (res.status == true) {
        designerList.value = res.data?.data ?? [];
      } else {
        designerList.clear();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      designerLoading(false);
    }
  }

  var designerDetailLoading = false.obs;
  Rxn<DesignerDetailData> designerDetail = Rxn<DesignerDetailData>();

  Future<dynamic> getDesignerDetails(id) async {
    designerDetailLoading(true);
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token") ?? '';
      final DesignerDetailRes res = await repo.getDesignerDetails(id, token);
      if (res.status == true) {
        designerDetail.value = res.data;
      }
    } catch (e) {
      log(e.toString());
    } finally {
      designerDetailLoading(false);
    }
  }

  var scheduledLoading = false.obs;
  var scheduledList = <AppointmentData>[].obs;

  var completedLoading = false.obs;
  var completedList = <AppointmentData>[].obs;

  Future<void> getScheduledAppointments() async {
    scheduledLoading(true);
    try {
      final AppointmentRes res = await repo.getAppointments('scheduled');
      if (res.status == true) {
        scheduledList.value = res.data;
      } else {
        scheduledList.clear();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      scheduledLoading(false);
    }
  }

  Future<void> getCompletedAppointments() async {
    completedLoading(true);
    try {
      final AppointmentRes res = await repo.getAppointments('completed');
      if (res.status == true) {
        completedList.value = res.data;
      } else {
        completedList.clear();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      completedLoading(false);
    }
  }

  var updateBookingLoading = false.obs;

  Future<dynamic> cancelBooking({required int bookingId}) async {
    updateBookingLoading(true);
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token") ?? '';
      final Map<String, dynamic> body = {"token": token, "status": "cancelled"};
      final res = await repo.updateAppointment(bookingId, body);

      log('cancelBooking res => $res');
      log('cancelBooking status => ${res['status']}');

      if (res['status'] == true) {
        await CommonToast.show(msg: res['message'] ?? 'Booking cancelled');
        await getScheduledAppointments();
      } else {
        log('else block called');
        log(res['message']);
        await CommonToast.show(
          msg: res['message'] ?? 'Failed to cancel booking',
        );
      }

      return res;
    } catch (e) {
      log('catch => $e');
    } finally {
      updateBookingLoading(false);
    }
  }

  var joinCallDataLoading = false.obs;

  Future<dynamic> startVideoCall({required int bookingId}) async {
    joinCallDataLoading(true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token") ?? '';

      final body = {
        "token": token,
        "booking_id": bookingId,
        "type": "video_call",
      };

      final res = await repo.startVideoCall(bookingId, body);

      if (res['status'] == true) {
        CommonToast.show(
          msg: res['message'] ?? 'Video call initiated successfully',
        );
        return res;
      } else {
        CommonToast.show(msg: res['message'] ?? 'Failed to start video call');
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    } finally {
      joinCallDataLoading(false);
    }
  }
  Future<void> markVideoCallStarted({required int videoId}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token") ?? '';

      final body = {
        "token": token,
        "video_id": videoId.toString(),
      };

      await repo.videoCallStarted(body);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> markVideoCallEnded({required int videoId}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token") ?? '';

      final body = {
        "token": token,
        "video_id": videoId.toString(),
      };

      await repo.videoCallEnded(body);
    } catch (e) {
      log(e.toString());
    }
  }
  Future<dynamic> rescheduleBooking({
    required int bookingId,
    required String date,
    required String slotId,
    required String consultationType,
  }) async {
    updateBookingLoading(true);
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token") ?? '';
      final Map<String, dynamic> body = {
        "token": token,
        "status": "reschedule",
        "date": date,
        "time": slotId,
        "consultation_type": consultationType,
      };
      final res = await repo.updateAppointment(bookingId, body);
      if (res['status'] == true) {
        CommonToast.show(msg: res['message'] ?? 'Booking rescheduled');
        getScheduledAppointments();
      } else {
        CommonToast.show(msg: res['message'] ?? 'Failed to reschedule');
      }
      return res;
    } catch (e) {
      log(e.toString());
    } finally {
      updateBookingLoading(false);
    }
  }

  var bookingLoading = false.obs;
  Rxn<Map<String, dynamic>> bookingResult = Rxn();

  Future<dynamic> bookAppointment({
    required dynamic designerId,
    required String date,
    required dynamic slotId,
    required bool isOnline,
    String? contactName,
    String? contactMobile,
    String? area,
    String? city,
    String? state,
    String? landmark,
    String? pincode,
  }) async {
    bookingLoading(true);
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token") ?? '';

      final Map<String, dynamic> body = {
        "token": token,
        "designer_id": designerId,
        "date": date,
        "time": slotId,
        "consultation_type": isOnline ? "online" : "offline",
      };

      if (!isOnline) {
        body["contact_info[name]"] = contactName ?? '';
        body["contact_info[mobile_number]"] = contactMobile ?? '';
        body["address_info[area]"] = area ?? '';
        body["address_info[city]"] = city ?? '';
        body["address_info[state]"] = state ?? '';
        body["address_info[landmark]"] = landmark ?? '';
        body["address_info[pincode]"] = pincode ?? '';
      }

      final res = await repo.bookAppointment(body);
      bookingResult.value = res;
      return res;
    } catch (e) {
      log(e.toString());
    } finally {
      bookingLoading(false);
    }
  }

  var paymentLoading = false.obs;
  Rxn<Map<String, dynamic>> paymentOrder = Rxn();

  Future<dynamic> addPayment({required int amount}) async {
    paymentLoading(true);
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token") ?? '';
      final Map<String, dynamic> body = {"token": token, "amount": amount};
      final res = await repo.addPayment(body);
      if (res['status'] == true) {
        paymentOrder.value = res['data'];
      }
      return res;
    } catch (e) {
      log(e.toString());
    } finally {
      paymentLoading(false);
    }
  }

  var verifyPaymentLoading = false.obs;

  Future<dynamic> verifyPayment({
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
    required dynamic designerBookingId,
  }) async {
    verifyPaymentLoading(true);
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token") ?? '';
      final Map<String, dynamic> body = {
        "token": token,
        "razorpay_order_id": razorpayOrderId,
        "razorpay_payment_id": razorpayPaymentId,
        "razorpay_signature": razorpaySignature,
        "designer_booking_id": designerBookingId,
      };
      final res = await repo.verifyPayment(body);
      if (res['status'] == true) {
        CommonToast.show(msg: res['message'] ?? 'Payment verified successfully');
      } else {
        CommonToast.show(msg: res['message'] ?? 'Payment verification failed');
      }
      return res;
    } catch (e) {
      log(e.toString());
    } finally {
      verifyPaymentLoading(false);
    }
  }
}