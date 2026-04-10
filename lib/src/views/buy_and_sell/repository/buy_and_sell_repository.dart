import 'dart:convert';

import 'package:aadaiz_customer_crm/src/services/api_service.dart';
import 'package:aadaiz_customer_crm/src/services/http_services.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/model/buy_and_sell_list_model.dart';

class BuyAndSellRepository {
  static final HttpHelper _http = HttpHelper();
  Future<BuyAndSellListModel> getBuyAndSellList(String token,page) async {
    final res = await _http.get("${Api.getBuyAndSellList}?token=$token&page=$page");
    return BuyAndSellListModel.fromJson(res);
  }
  Future<Map<String, dynamic>> deleteBuyAndSell(String token,int id) async {
    final res = await _http.post("${Api.deleteBuyAndSell}/$id?token=$token", null);
    return jsonDecode(res);
  }
}