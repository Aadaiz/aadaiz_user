import 'dart:convert';
import 'dart:developer';

import 'package:aadaiz_customer_crm/src/views/material/model/category_list_model.dart';
import 'package:aadaiz_customer_crm/src/views/material/model/filter_category.dart';
import 'package:aadaiz_customer_crm/src/views/material/model/material_cart_list_model.dart';
import 'package:aadaiz_customer_crm/src/views/material/model/material_category_model.dart';
import 'package:aadaiz_customer_crm/src/views/material/model/material_favorites_model.dart';
import 'package:aadaiz_customer_crm/src/views/material/model/material_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/api_service.dart';
import '../../../services/http_services.dart';

class MaterialRepository {
  static final HttpHelper _http = HttpHelper();

  Future<MaterialListRes> getMaterialList({
    String? search,
    String? priceLowHigh,
    int? page,
    String? category,
    String? color,
    String? minPrice,
    String? maxPrice,
    String? rating,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final Map<String, String> params = {};

    if (token != null) params['token'] = token;
    if (search != null && search.isNotEmpty) params['search'] = search;
    if (priceLowHigh != null) params['sort_by_price'] = priceLowHigh;
    if (page != null) params['page'] = page.toString();
    if (category != null) params['category'] = category;
    if (color != null) params['color'] = color;
    if (minPrice != null) params['min_price'] = minPrice;
    if (maxPrice != null) params['max_price'] = maxPrice;
    if (rating != null) params['rating'] = rating;

    final uri = Uri.parse(Api.materialList).replace(queryParameters: params);

    final response = await _http.get(uri.toString());
    return MaterialListRes.fromMap(jsonDecode(response));
  }


  Future<dynamic> getFilterCategory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final response = await _http.get("${Api.filterCategory}?token=$token");
    final FilterCategory res = FilterCategory.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> getMaterialCategory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await _http.get("${Api.materialCategory}?token=$token");
    final MaterialCategoryListRes res = MaterialCategoryListRes.fromMap(
      jsonDecode(response),
    );
    return res;
  }

  Future<dynamic> favourites({required dynamic body}) async {
    final response = await _http.post(
      Api.materialFavorite,
      body,
      contentType: true,
    );
    final MaterialRes res = MaterialRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> getFavorites({page}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await _http.get(
      "${Api.materialFavorite}?token=$token&page=$page",
    );
    final MaterialFavoritesListRes res = MaterialFavoritesListRes.fromMap(
      jsonDecode(response),
    );
    return res;
  }

  Future<dynamic> addToCart({required dynamic body}) async {
    final response = await _http.post(
      Api.materialAddtocart,
      body,
      contentType: true,
    );
    final MaterialRes res = MaterialRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<MaterialCartListRes> getCart({String? couponCode}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    /// Base URL
    String url = "${Api.materialCartList}?token=$token";

    /// Add coupon_code only if not null & not empty
    if (couponCode != null && couponCode.isNotEmpty) {
      url += "&coupon_code=$couponCode";
    }

    final response = await _http.get(url);
    return MaterialCartListRes.fromMap(jsonDecode(response));
  }
}
