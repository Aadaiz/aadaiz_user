import 'dart:convert';

import 'package:aadaiz_customer_crm/src/views/profile/model/support_list.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/api_service.dart';
import '../../../services/http_services.dart';
import '../model/profile_model.dart';
import '../model/add_image.dart';

class ProfileRepository {
  static final HttpHelper _http = HttpHelper();


  Future<dynamic> profile() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    var response = await _http.get("${Api.profile}?token=$token");
    ProfileRes res  = ProfileRes.fromMap(jsonDecode(response));
    return res;
  }


  Future<dynamic> updateProfile(body) async {
    var response = await _http.post(Api.profile,body,contentType: true);
    ProfileRes res  = ProfileRes.fromMap(jsonDecode(response));
    return res;
  }


  Future uploadImage({
    image
  }) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    String fileNames = '';
    if (image != '') {
      fileNames = image.toString().split('/').last;
    }
    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          image.toString(),
          filename: fileNames.toString(),
          // contentType: MediaType(
          //   "image",
          //   "jpg",
          // ),
        ),
      });
      formData.fields.forEach((field) {
        print('afdafd ${field.value}');
      });

      Response response = await dio.post(
          '${Api.uploadImage}',
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
        var response = e.response;
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
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    var response = await _http.get("${Api.supportLists}?token=$token");
    SupportListRes res  = SupportListRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> addSupport(body) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    var response = await _http.post(Api.support,body,contentType: true);
    return jsonDecode(response);
  }

}