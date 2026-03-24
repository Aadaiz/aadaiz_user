import 'dart:convert';

import 'package:aadaiz_customer_crm/src/services/api_service.dart';
import 'package:aadaiz_customer_crm/src/services/http_services.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/models/appointment_list_model.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/models/consulting_available_slot_model.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/models/consulting_category_model.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/models/consulting_designer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConsultingRepository {
  static final HttpHelper _http = HttpHelper();

  Future<dynamic> getCategory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await _http.get("${Api.consultingCategory}?token=$token");
    final ConsultingCategoryRes res = ConsultingCategoryRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> getDesigners(id,designer) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await _http.get("${Api.consultingDesigner}?category_id=$id&designer_preference=$designer&token=$token");
    final ConsultingDesignerRes res = ConsultingDesignerRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> getAvailableSlots(id,date) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await _http.get("${Api.availableSlots}?designer_id=$id&date=$date&token=$token");
    final AppointmentAvailableRes res = AppointmentAvailableRes.fromMap(jsonDecode(response));
    return res;
  }


  Future<dynamic> getAppointments(status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await _http.get("${Api.consultingAppointment}?status=$status&token=$token");
    final AppointmentRes res = AppointmentRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> createAppointment(body) async {
    final response = await _http.post(Api.createAppointment, body);
    return jsonDecode(response);
  }
}