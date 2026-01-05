import 'dart:convert';

import 'package:aadaiz_customer_crm/src/services/api_service.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/model/customer_orders.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/service/api_service_.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/http_services.dart';
import '../model/notification_model.dart';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';


class CustomerRepository {
  static final HttpHelper _http = HttpHelper();

  Future<dynamic> getOrders({
    required String filter,
    dynamic search,
    int page = 1,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final response = await _http.get(
      "${Api.crmOrders}?filter_by=$filter&keyword=${search ?? ''}&page=$page&token=$token",
    );

    final OrdersData res = OrdersData.fromMap(jsonDecode(response));
    return res;
  } Future<dynamic> ratings({
    required dynamic id,
    dynamic search,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    // search is now a JSON string
    final response = await _http.post(
      "${Api.ratings}/$id?token=$token",
      search,
    );

    return response;
  }




  Future<File?> superAdminExportData({
    required String token,
    required dynamic id,
  }) async {
    try {
      final dio = Dio();

      // ✅ Query parameters
      final params = {'token': token};

      // ✅ Body (only type)
      final body = {};

      log("📤 Export Params: $params");
      log("📦 Export Body: $body");

      // ✅ Storage path setup
      final downloadDir = Directory('/storage/emulated/0/Download');
      final fallbackDir = await getApplicationDocumentsDirectory();
      final saveDir = downloadDir.existsSync() ? downloadDir : fallbackDir;

      final response = await dio.post(
        "${Api.superAdminAttendanceExport}/$id",
        queryParameters: params,
        data: body,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final bytes = response.data;
        final contentType = response.headers.value('content-type') ?? '';
        String extension = '.pdf';

        if (contentType.contains(
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        )) {
          extension = '.xlsx';
        }

        final fileName =
            'Attendance_${DateTime.now().millisecondsSinceEpoch}$extension';
        final filePath = '${saveDir.path}/$fileName';

        final file = File(filePath);
        await file.writeAsBytes(bytes);

        log('✅ File saved: $filePath');
        return file;
      } else {
        throw Exception('Export failed: ${response.statusCode}');
      }
    } catch (e, st) {
      log('❌ Export Exception: $e');
      log(st.toString());
      throw Exception('Error exporting attendance');
    }
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
