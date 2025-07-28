import 'dart:convert';

import 'package:aadaiz_customer_crm/src/views/material/model/category_list_model.dart';
import 'package:aadaiz_customer_crm/src/views/material/model/material_cart_list_model.dart';
import 'package:aadaiz_customer_crm/src/views/material/model/material_category_model.dart';
import 'package:aadaiz_customer_crm/src/views/material/model/material_favorites_model.dart';
import 'package:aadaiz_customer_crm/src/views/material/model/material_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/api_service.dart';
import '../../../services/http_services.dart';

class MaterialRepository {
  static final HttpHelper _http = HttpHelper();

  Future<dynamic> getMaterialList({search,priceLowHigh, page}) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    var response = await _http.get("${Api.materialList}?search=$search&sort_by_price=${priceLowHigh??""}&token=$token&page=$page");
    MaterialListRes res  = MaterialListRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> getMaterialCategory() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    var response = await _http.get("${Api.materialCategory}?token=$token");
    MaterialCategoryListRes res  = MaterialCategoryListRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> favourites({required dynamic body}) async {
    var response = await _http.post(Api.materialFavorite, body, contentType: true);
    MaterialRes res = MaterialRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> getFavorites({ page}) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    var response = await _http.get("${Api.materialFavorite}?token=$token&page=$page");
    MaterialFavoritesListRes res  = MaterialFavoritesListRes.fromMap(jsonDecode(response));
    return res;
  }
  Future<dynamic> addToCart({required dynamic body}) async {
    var response = await _http.post(Api.materialAddtocart, body, contentType: true);
    MaterialRes res = MaterialRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> getCart() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    var response = await _http.get("${Api.materialCartList}?token=$token");
    MaterialCartListRes res  = MaterialCartListRes.fromMap(jsonDecode(response));
    return res;
  }
}