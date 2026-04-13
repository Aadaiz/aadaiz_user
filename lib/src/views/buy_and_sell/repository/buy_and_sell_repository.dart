import 'dart:convert';

import 'package:aadaiz_customer_crm/src/services/api_service.dart';
import 'package:aadaiz_customer_crm/src/services/http_services.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/model/buy_and_sell_cart_list_model.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/model/buy_and_sell_list_model.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/model/buy_and_sell_track_model.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/model/buy_and_sell_whishlist_model.dart';

class BuyAndSellRepository {
  static final HttpHelper _http = HttpHelper();
  Future<BuyAndSellListModel> getBuyAndSellList(
    String token,
    page,
    String? category,
  ) async {
    final res = await _http.get(
      "${Api.getBuyAndSellList}?token=$token&page=$page&category=$category",
    );
    return BuyAndSellListModel.fromJson(res);
  }

  Future<Map<String, dynamic>> deleteBuyAndSell(String token, int id) async {
    final res = await _http.post(
      "${Api.deleteBuyAndSell}/$id?token=$token",
      null,
    );
    return jsonDecode(res);
  }

  Future<Map<String, dynamic>> addToCart(dynamic body, int id) async {
    final res = await _http.post("${Api.addToCart}/$id", body);
    return jsonDecode(res);
  }

  Future<BuyAndSellCartList> getBuyAndSellCartList(String token) async {
    final res = await _http.get("${Api.getBuyAndSellCartList}?token=$token");
    return BuyAndSellCartList.fromJson(res);
  }

  Future<Map<String, dynamic>> removeFromCart(dynamic body, int id) async {
    final res = await _http.post("${Api.removeFromCart}/$id", body);
    return jsonDecode(res);
  }

  Future<Map<String, dynamic>> buyAndSellCheckOut(dynamic body) async {
    final res = await _http.post(Api.buyAndSellCheckOut, body);
    return jsonDecode(res);
  }

  Future<Map<String, dynamic>> cancelOrder(dynamic body) async {
    final res = await _http.post(Api.buyAndSellCancelOrder, body);
    return jsonDecode(res);
  }

  Future<BuyAndSellTrackModel> trackOrder(dynamic awbCode) async {
    final res = await _http.get("${Api.buyAndSellTrackOrder}/$awbCode");
    return BuyAndSellTrackModel.fromJson(res);
  }

  Future<Map<String, dynamic>> addToWishlist(dynamic body,dynamic id) async {
    final res = await _http.post("${Api.buyAndSellAddToWishlist}/$id", body);
    return jsonDecode(res);
  }

  Future<BuyAndSellWishlistModel> getWishlist(dynamic token) async {
    final res = await _http.get("${Api.buyAndSellGetWishlist}?token=$token");
    return BuyAndSellWishlistModel.fromJson(res);
  }
}
