import 'dart:convert';
import 'dart:developer';

import 'package:aadaiz_customer_crm/src/views/auth/model/signup_model.dart';
import 'package:aadaiz_customer_crm/src/views/auth/model/verify_otp_model.dart';
import 'package:aadaiz_customer_crm/src/views/auth/repository/auth_repository.dart';
import 'package:aadaiz_customer_crm/src/views/auth/ui/otp_screen.dart';
import 'package:aadaiz_customer_crm/src/views/auth/ui/register_screen.dart';
import 'package:aadaiz_customer_crm/src/views/dashboard/controller.dart';
import 'package:aadaiz_customer_crm/src/views/home/home_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../res/components/common_toast.dart';
import '../../customer_crm/screens/customer_dashboard.dart';
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
      await Get.to(()=>const OtpScreen(isLogin: false,));
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var fcmToken= prefs.getString('fcm_token');
     Map body = {
      "username": name.text,
      "mobile_number": mobile.text,
      "email": email.text,
      "age": age.text,
      "gender": genderValue.value,
      "otp_token": otpToken.value,
      "otp_code": otp.text,
       'fcm_token':fcmToken
    };
    VerifyOtpRes res = await repo.verifyOtp(body: jsonEncode(body));
    verifyLoading(false);

    if (res.success == true) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      log("User ID before save: ${res.data!.id}"); // Before saving

      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('token', '${res.data!.token}');
      await prefs.setString('user_id', res.data!.id.toString());

      log("User ID after save: ${prefs.getString('user_id')}");
      Get.offAll(() => Dashboard());


      name.clear();
      mobile.clear();
      email.clear();
      age.clear();
      genderValue.value = ''; // Reset gender value
      otp.clear();
      otpToken.value = '';


    } else {
      CommonToast.show(msg: "${res.message}");
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


  Future<void> verifyOtpLogin() async {
    verifyLoading(true);

    final prefs = await SharedPreferences.getInstance();
    final fcmToken = prefs.getString('fcm_token');

    final Map<String, dynamic> body = {
      "mobile_number": loginMobile.text.trim(),
      "otp_token": otpToken.value,
      "otp_code": otp.text.trim(),
      if (fcmToken != null) "fcm_token": fcmToken,
    };

    final VerifyOtpRes res =
    await repo.verifyOtpLogin(body: jsonEncode(body));

    verifyLoading(false);

    if (res.success == true) {
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('token', res.data?.token ?? '');
      await prefs.setString('user_id', res.data!.id.toString());

      log("User ID saved: ${prefs.getString('user_id')}");

      // Clear stack & go to Dashboard
      Get.offAll(() => Dashboard());

      // Clear controllers AFTER navigation
      loginMobile.clear();
      otp.clear();
      otpToken.value = '';
    } else {
      CommonToast.show(msg: res.message ?? "Login failed");
    }
  }



  ///Saving logging user
  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Get.offAll(() => Dashboard());
    } else {
      Get.offAll(() => const RegisterScreen());
    }
  }

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  ///Logout
 Future<dynamic> logOut() async {
   DashboardController.to.tabSelected.value=0;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    final fCMToken = await firebaseMessaging.getToken();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.setString('fcm_token',fCMToken!);

    // await FirebaseApi().initNotifications();
    //await _signOut();
    await Get.offAll(()=> const RegisterScreen());
  }
//  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<void> _signOut() async {
   // await googleSignIn.signOut();
    //await FirebaseAuth.instance.signOut();
  }
}