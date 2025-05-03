import 'dart:convert';

import 'package:aadaiz_customer_crm/src/services/http_services.dart';
import 'package:aadaiz_customer_crm/src/views/auth/model/signup_model.dart';
import 'package:aadaiz_customer_crm/src/views/auth/model/verify_otp_model.dart';

import '../../../services/api_service.dart';

class AuthRepository{
  static final HttpHelper _http = HttpHelper();

  Future<dynamic> signUp({required dynamic body}) async{
    var response =await _http.post(Api.signUp, body,contentType: true);
    SignUpRes res = SignUpRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> signIn({required dynamic body}) async{
    var response =await _http.post(Api.signIn, body,contentType: true);
    SignUpRes res = SignUpRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> verifyOtp({required dynamic body}) async{
    var response =await _http.post(Api.verifyOtp, body,contentType: true);
    VerifyOtpRes res = VerifyOtpRes.fromMap(jsonDecode(response));
    return res;
  }
  Future<dynamic> verifyOtpLogin({required dynamic body}) async{
    var response =await _http.post(Api.verifyOtpLogin, body,contentType: true);
    VerifyOtpRes res = VerifyOtpRes.fromMap(jsonDecode(response));
    return res;
  }
}