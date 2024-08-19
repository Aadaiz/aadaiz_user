
import 'config.dart';

class Api {
  ///Registration
  static const  fcm = AppConfig.baseUrl + "fcm_update";
  static const signUp = AppConfig.baseUrl + "register";
  static const signIn = AppConfig.baseUrl + "signin";
  static const verifyOtp = AppConfig.baseUrl + "verify_otp";
  static const verifyOtpLogin = AppConfig.baseUrl + "login_verify_otp";



  ///Home
  static const getBannerList = AppConfig.baseUrl + "banners";
  static const gender = AppConfig.baseUrl + "category_list";
  static const categoryData = AppConfig.baseUrl + "pattern_catlist";
  static const productList = AppConfig.baseUrl + "pattern_subcatlist";
  static const filter = AppConfig.baseUrl + "filter";
  static const address = AppConfig.baseUrl + "address";
  static const favorite = AppConfig.baseUrl + "favourites";
  static const cart = AppConfig.baseUrl + "cart";
  static const coupon = AppConfig.baseUrl + "couponList";
  static const myOrder = AppConfig.baseUrl + "myOrders";
  static const placeOrder = AppConfig.baseUrl + "placeOrder";
  static const cancelOrder = AppConfig.baseUrl + "cancelOrder";
  static const review = AppConfig.baseUrl + "review";
  static const rating = AppConfig.baseUrl + "rating";
}