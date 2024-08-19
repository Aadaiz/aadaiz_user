import 'dart:convert';

import 'package:aadaiz/src/views/auth/model/signup_model.dart';
import 'package:aadaiz/src/views/auth/model/verify_otp_model.dart';
import 'package:aadaiz/src/views/auth/repository/auth_repository.dart';
import 'package:aadaiz/src/views/auth/ui/otp_screen.dart';
import 'package:aadaiz/src/views/auth/ui/register_screen.dart';
import 'package:aadaiz/src/views/dashboard/controller.dart';
import 'package:aadaiz/src/views/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../res/components/common_toast.dart';
import '../../dashboard/dashboard.dart';

class AuthController extends GetxController{
  static AuthController get to => Get.put(AuthController());
  var repo = AuthRepository();

  RxString genderValue = ''.obs;

  var signUpLoading=false.obs;
  var otpToken=''.obs;
  final TextEditingController email = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController loginMobile = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController otp = TextEditingController();

 Future<dynamic> signUp() async {
    signUpLoading(true);
    final Map<String, dynamic> body = <String, dynamic>{
      "username": name.text,
      "mobile_number": mobile.text,
      "email": email.text,
      "age": age.text,
      "gender": genderValue.value,
    };
    SignUpRes res = await repo.signUp(body: jsonEncode(body));
    signUpLoading(false);
    if(res.success==true){
      otpToken.value= res.data!.otpToken;
      await Get.to(()=>const OtpScreen(isLogin: false));
     // Get.to(()=>const SignupOtpScreen());
    }else{
      // if(res.data!.email!=null) {
         CommonToast.show(msg: "${res.message}");
      // }else{
      //   CommonToast.show(msg: "${res.data!.phoneNumber}");
      // }
    }
  }
  var verifyLoading=false.obs;

  Future<dynamic> verifyOtp(context) async {
    verifyLoading(true);
     Map body = {
      "username": name.text,
      "mobile_number": mobile.text,
      "email": email.text,
      "age": age.text,
      "gender": genderValue.value,
      "otp_token": otpToken.value,
      "otp_code": otp.text,
    };
    VerifyOtpRes res = await repo.verifyOtp(body: jsonEncode(body));
    verifyLoading(false);
    if(res.success==true){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('token', '${res.data!.token}');
      await Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
        const Dashboard(), // Navigate to home if logged in
      ));

    }else{
      CommonToast.show(msg: "${res.message}");
      // if(res.data!.email!=null) {
      //   CommonToast.show(msg: "${res.data!.email}");
      // }else{
      //   CommonToast.show(msg: "${res.data!.mobileNumber}");
      // }
    }
  }

var loginLoading = false.obs;

  Future<dynamic> login({required dynamic mobile}) async {
    loginLoading(true);
    final Map<String, dynamic> body = <String, dynamic>{
      "mobile_number": "${loginMobile.text}"
    };
    SignUpRes res = await repo.signIn(body: jsonEncode(body));
    loginLoading(false);
    print('logina fdf dsa${res}');
    if(res.success==true){
      otpToken.value= res.data!.otpToken;
      await Get.to(()=>const OtpScreen(isLogin: true,));
    }else{
      // if(res.data!.email!=null) {
         CommonToast.show(msg: "${res.message}");
      // }else{
      //   CommonToast.show(msg: "${res.data!.phoneNumber}");
      // }
    }
  }


  Future<dynamic> verifyOtpLogin(context) async {
    verifyLoading(true);
    Map body = {
      "mobile_number": loginMobile.text,
      "otp_token": otpToken.value,
      "otp_code": otp.text,
    };
    VerifyOtpRes res = await repo.verifyOtpLogin(body: jsonEncode(body));
    verifyLoading(false);
    if(res.success==true){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('token', '${res.data!.token}');
      await Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
        const Dashboard(), // Navigate to home if logged in
      ));

    }else{
      CommonToast.show(msg: "${res.message}");
      // if(res.data!.email!=null) {
      //   CommonToast.show(msg: "${res.data!.email}");
      // }else{
      //   CommonToast.show(msg: "${res.data!.mobileNumber}");
      // }
    }
  }


  ///Saving logging user
  Future<void> checkLoginStatus(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      await Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
        const Dashboard(), // Navigate to home if logged in
      ));
    } else{
      await  Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
        const RegisterScreen(), // Navigate to login if not logged in
      ));
    }
  }
  ///Logout
 Future<dynamic> logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    DashboardController.to.tabSelected.value=0;
    // await FirebaseApi().initNotifications();
    //await _signOut();
    await Get.offAll(()=> const RegisterScreen());
  }
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<void> _signOut() async {
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
}