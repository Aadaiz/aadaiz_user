import 'dart:convert';

import 'package:aadaiz_customer_crm/src/services/api_service.dart';
import 'package:aadaiz_customer_crm/src/services/http_services.dart';
import 'package:aadaiz_customer_crm/src/views/profile/model/add_image.dart';
import 'package:aadaiz_customer_crm/src/views/profile/model/profile_model.dart';
import 'package:aadaiz_customer_crm/src/views/profile/model/support_list.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository {
  static final HttpHelper _http = HttpHelper();


  Future<dynamic> profile() async {
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    final token=prefs.getString("token");
    final response = await _http.get("${Api.profile}?token=$token");
    final ProfileRes res  = ProfileRes.fromMap(jsonDecode(response));
    return res;
  }


  Future<dynamic> updateProfile(body) async {
    final response = await _http.post(Api.profile,body);
    final ProfileRes res  = ProfileRes.fromMap(jsonDecode(response));
    return res;
  }


  Future uploadImage({
    image
  }) async
  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    String fileNames = '';
    if (image != '') {
      fileNames = image.toString().split('/').last;
    }
    try {
      final Dio dio = Dio();
      final FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          image.toString(),
          filename: fileNames.toString(),
          // contentType: MediaType(
          //   "image",
          //   "jpg",
          // ),
        ),
      });
      for (final field in formData.fields) {
        print('afdafd ${field.value}');
      }

      final Response response = await dio.post(
          Api.uploadImage,
          data: formData,
          options: Options(headers: {
            "Accept": "application/json",
          }));
      print('api ${Api.uploadImage} body $formData response $response');
      // body: data,
      // headers: {
      //   "Accept": "application/json",
      //   'Authorization': 'Bearer $token',
      // });

      // var jsonresponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AddImage.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      if (e is DioException) {
        final response = e.response;
        if (response != null) {
          // print('Request failed with status code ${response.statusCode}');
          // print('Error response: ${response.data}');
        } else {
          //  print('Request failed with an error');
        }
      } else {
        //  print('Error: $e');
      }
    }
  }
  Future<dynamic> supportLists() async {
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    final token=prefs.getString("token");
    final response = await _http.get("${Api.supportLists}?token=$token");
    final SupportListRes res  = SupportListRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> addSupport(body) async {
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    final token=prefs.getString("token");
    final response = await _http.post(Api.support,body);
    return jsonDecode(response);
  }

}