import 'dart:convert';

import 'package:aadaiz_customer_crm/src/services/api_service.dart';
import 'package:aadaiz_customer_crm/src/services/http_services.dart';
import 'package:aadaiz_customer_crm/src/views/Event/model/event_model.dart';

class EventRepository {
  static final HttpHelper _http = HttpHelper();

  Future<EventRes> getEventData(
      String token,
      int page, {
        String? startDate,
        String? endDate,
        String? location,
        String? search,
      }) async {

    final Map<String, String> queryParams = {
      "token": token,
      "page": page.toString(),
    };

    if (startDate != null) {
      queryParams["start_date"] = startDate;
    }
    if (endDate != null) {
      queryParams["end_date"] = endDate;
    }
    if (location != null) {
      queryParams["city_name"] = location;
    }
    if (search != null) {
      queryParams["event_name"] = search.toLowerCase();
    }

    final uri = Uri.parse(Api.getEventData).replace(queryParameters: queryParams);

    final res = await _http.get(uri.toString());

    final EventRes response = EventRes.fromJson(res);
    return response;
  }
}

