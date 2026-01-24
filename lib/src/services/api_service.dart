import 'config.dart';

class Api {
  ///Registration
  static const fcm = "${AppConfig.baseUrl}fcm_update";
  static const signUp = "${AppConfig.baseUrl}register";
  static const signIn = "${AppConfig.baseUrl}signin";
  static const verifyOtp = "${AppConfig.baseUrl}verify_otp";
  static const verifyOtpLogin = "${AppConfig.baseUrl}login_verify_otp";

  ///Home
  static const getBannerList = "${AppConfig.baseUrl}selfcustomize/banners";
  static const gender = "${AppConfig.baseUrl}selfcustomize/category_list";
  static const categoryData =
      "${AppConfig.baseUrl}selfcustomize/pattern_catlist";
  static const productList =
      "${AppConfig.baseUrl}selfcustomize/pattern_subcatlist";
  static const tailorList = "${AppConfig.baseUrl}selfcustomize/tailor_list";
  static const filter = "${AppConfig.baseUrl}selfcustomize/filter";
  static const address = "${AppConfig.baseUrl}selfcustomize/address";
  static const favorite = "${AppConfig.baseUrl}material/favourites";
  static const cart = "${AppConfig.baseUrl}selfcustomize/cart";
  static const coupon = "${AppConfig.baseUrl}selfcustomize/couponList";
  static const myOrder = "${AppConfig.baseUrl}selfcustomize/myOrders";
  static const placeOrder = "${AppConfig.baseUrl}material/placeOrder";

  static const reOrder = "${AppConfig.baseUrl}selfcustomize/reOrder";

  static const cancelOrder = "${AppConfig.baseUrl}selfcustomize/cancelOrder";
  static const review = "${AppConfig.baseUrl}selfcustomize/review";
  static const rating = "${AppConfig.baseUrl}selfcustomize/rating";

  ///matrial
  static const materialList = "${AppConfig.baseUrl}material/list";
  static const materialCategory = "${AppConfig.baseUrl}material/category";
  static const materialFavorite = "${AppConfig.baseUrl}material/favourites";
  static const materialAddtocart = "${AppConfig.baseUrl}material/addtocart";
  static const materialCartList = "${AppConfig.baseUrl}material/cartlist";

  ///profile
  static const profile = "${AppConfig.baseUrl}selfcustomize/profile";
  static const supportLists = "${AppConfig.baseUrl}selfcustomize/supportLists";
  static const  support = "${AppConfig.baseUrl}selfcustomize/support";
  static const uploadImage = "${AppConfig.baseUrl}upload-image";

  ///consulting
  static const consultingCategory =
      "${AppConfig.baseUrl}onlineconsult/category";
  static const consultingDesigner =
      "${AppConfig.baseUrl}onlineconsult/designers";
  static const consultingReview = "${AppConfig.baseUrl}onlineconsult/review";
  static const availableSlots =
      "${AppConfig.baseUrl}onlineconsult/available_slots";
  static const createAppointment =
      "${AppConfig.baseUrl}onlineconsult/appointments_create";
  static const consultingAppointment =
      "${AppConfig.baseUrl}onlineconsult/appointments_list";

  ///crm
  static const crmOrders = "${AppConfig.baseUrl}crm/customerOrders";
  static const ratings = "${AppConfig.baseUrl}crm/ratings";
  static const notification = "${AppConfig.baseUrl}selfcustomize/notification";
  static const callOthers ="${AppConfig.baseUrl}crm/callData";
  static const callEnded ="${AppConfig.baseUrl}messages/callEnded";
  static const superAdminAttendanceExport ="${AppConfig.baseUrl}crm/invoice";
  static const String chatList = 'http://52.2.234.121/aadaiz-crm-new/public/index.php/api/chatList';

}
