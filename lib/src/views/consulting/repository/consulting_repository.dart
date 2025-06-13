import 'dart:convert';
import 'package:aadaiz_customer_crm/src/views/consulting/models/appointment_list_model.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/models/consulting_available_slot_model.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/models/consulting_designer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/api_service.dart';
import '../../../services/http_services.dart';
import '../models/appointment_ create_model.dart';
import '../models/consulting_category_model.dart';

class ConsultingRepository {
  static final HttpHelper _http = HttpHelper();

  Future<dynamic> getCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await _http.get("${Api.consultingCategory}?token=$token");
    ConsultingCategoryRes res = ConsultingCategoryRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> getDesigners(id,designer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await _http.get("${Api.consultingDesigner}?category_id=$id&designer_preference=$designer&token=$token");
    ConsultingDesignerRes res = ConsultingDesignerRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> getAvailableSlots(id,date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await _http.get("${Api.availableSlots}?designer_id=$id&date=$date&token=$token");
    AppointmentAvailableRes res = AppointmentAvailableRes.fromMap(jsonDecode(response));
    return res;
  }


  Future<dynamic> getAppointments(status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await _http.get("${Api.consultingAppointment}?status=$status&token=$token");
    AppointmentRes res = AppointmentRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> createAppointment(body) async {
    var response = await _http.post(Api.createAppointment, body, contentType: true);
    return jsonDecode(response);
  }
}