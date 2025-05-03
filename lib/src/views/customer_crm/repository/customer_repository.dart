import 'dart:convert';

import 'package:aadaiz_customer_crm/src/services/api_service.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/model/customer_orders.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/service/api_service_.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/http_services.dart';
import '../model/notification_model.dart';

class CustomerRepository {
  static final HttpHelper _http = HttpHelper();

  Future<dynamic> getOrders({required String filter, dynamic  search}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final response =
        await _http.get("${Api.crmOrders}?filter_by=$filter&keyword=${search??''}&token=$token");
    final OrdersData res = OrdersData.fromMap(jsonDecode(response));
    return res;
    //
  }



  Future<dynamic> getNotifications() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final response =
    await _http.get("${Api.notification}?token=$token");
    final NotificationRes res = NotificationRes.fromMap(jsonDecode(response));
    return res;
    //
  }
}
