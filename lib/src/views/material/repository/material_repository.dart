import 'dart:convert';

import 'package:aadaiz/src/views/material/model/category_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/api_service.dart';
import '../../../services/http_services.dart';

class MaterialRepository {
  static final HttpHelper _http = HttpHelper();

  Future<dynamic> getMaterialList({search, page}) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    var response = await _http.get("${Api.materialList}?search=$search&token=$token&page=$page");
    MaterialListRes res  = MaterialListRes.fromMap(jsonDecode(response));
    print('dferea ${response}');
    return res;
  }

}