import 'dart:convert';

import 'package:aadaiz_customer_crm/src/services/api_service.dart';
import 'package:aadaiz_customer_crm/src/services/http_services.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/models/appointment_list_model.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/models/consulting_available_slot_model.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/models/consulting_category_model.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/models/consulting_designer_model.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/models/consulting_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConsultingRepository {
  static final HttpHelper _http = HttpHelper();

  Future<dynamic> getCategory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await _http.get("${Api.consultingCategory}?token=$token");
    final ConsultingCategoryRes res = ConsultingCategoryRes.fromMap(
      jsonDecode(response),
    );
    return res;
  }

  Future<dynamic> getDesigners(Map<String, dynamic> body) async {
    final response = await _http.get(
      "${Api.consultingDesigner}"
      "?token=${body['token']}"
      "&category=${body['category']}"
      "&day=${body['day']}"
      "&consultation_type=${body['consultation_type']}"
      "&designer_preference=${body['designer_preference']}",
    );
    final ConsultingDesignerRes res = ConsultingDesignerRes.fromMap(
      jsonDecode(response),
    );
    return res;
  }

  Future<dynamic> getAvailableSlots(id, date) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await _http.get(
      "${Api.availableSlots}?designer_id=$id&date=$date&token=$token",
    );
    final AppointmentAvailableRes res = AppointmentAvailableRes.fromMap(
      jsonDecode(response),
    );
    return res;
  }

  Future<dynamic> getDesignerDetails(id, token) async {
    final response = await _http.get("${Api.designerDetails}/$id?token=$token");
    final DesignerDetailRes res = DesignerDetailRes.fromMap(
      jsonDecode(response),
    );
    return res;
  }

  Future<dynamic> getAppointments(status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await _http.get(
      "${Api.consultingAppointment}?status=$status&token=$token",
    );
    final AppointmentRes res = AppointmentRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> bookAppointment(Map<String, dynamic> body) async {
    final response = await _http.post(Api.createAppointment, jsonEncode(body));
    return jsonDecode(response);
  }

  Future<dynamic> updateAppointment(
    int bookingId,
    Map<String, dynamic> body,
  ) async {
    final response = await _http.post(
      "${Api.updateAppointment}/$bookingId",
      jsonEncode(body),
    );
    return jsonDecode(response);
  }

  Future<dynamic> startVideoCall(
    int bookingId,
    Map<String, dynamic> body,
  ) async {
    final response = await _http.post(
      "${Api.startVideoCall}/$bookingId",
      jsonEncode(body),
    );
    return jsonDecode(response);
  }

  Future<dynamic> addPayment(Map<String, dynamic> body) async {
    final response = await _http.post(
      Api.addPaymentConsultant,
      jsonEncode(body),
    );
    return jsonDecode(response);
  }
  Future<dynamic> videoCallStarted(Map<String, dynamic> body) async {
    final response = await _http.post(
      Api.videoCallStarted,
      jsonEncode(body),
    );
    return jsonDecode(response);
  }

  Future<dynamic> videoCallEnded(Map<String, dynamic> body) async {
    final response = await _http.post(
      Api.videoCallEnded,
      jsonEncode(body),
    );
    return jsonDecode(response);
  }
  Future<dynamic> verifyPayment(Map<String, dynamic> body) async {
    final response = await _http.post(
      Api.verifyPaymentConsultant,
      jsonEncode(body),
    );
    return jsonDecode(response);
  }
}
