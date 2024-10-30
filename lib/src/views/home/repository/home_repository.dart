import 'dart:convert';
import 'package:aadaiz/src/views/home/model/add_cart_model.dart';
import 'package:aadaiz/src/views/home/model/add_favorite_model.dart';
import 'package:aadaiz/src/views/home/model/banner_model.dart';
import 'package:aadaiz/src/views/home/model/cartlist_model.dart';
import 'package:aadaiz/src/views/home/model/couponlist_model.dart';
import 'package:aadaiz/src/views/home/model/favoritelist_model.dart';
import 'package:aadaiz/src/views/home/model/filter_model.dart';
import 'package:aadaiz/src/views/home/model/my_order_model.dart';
import 'package:aadaiz/src/views/home/model/productlist_model.dart';
import 'package:aadaiz/src/views/home/model/review_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/api_service.dart';
import '../../../services/http_services.dart';
import '../model/add_address_model.dart';
import '../model/addresslist_model.dart';
import '../model/category_model.dart';
import '../model/gender_model.dart';
import '../model/order.dart';
import '../../profile/model/profile_model.dart';
import '../model/tailor_list_model.dart';

class HomeRepository{
  static final HttpHelper _http = HttpHelper();

 Future<dynamic> getBannerList() async {
   SharedPreferences prefs=await SharedPreferences.getInstance();
   var token=prefs.getString("token");
   var response = await _http.get("${Api.getBannerList}?token=$token");
   BannerListRes res  = BannerListRes.fromMap(jsonDecode(response));
   return res;
 }


  Future<dynamic> getGender() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    var response = await _http.get("${Api.gender}?token=$token");
    GenderRes res  = GenderRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> getCategoryData(id) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    var response = await _http.get("${Api.categoryData}?cat_id=$id&token=$token");
    CategoryDataRes res  = CategoryDataRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> getProductList({id, page,dynamic price,dynamic range, dynamic rating, dynamic filterCategory, dynamic keyword, dynamic bannerId}) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    var response = await _http.get("${Api.productList}?p_cat_id=$id&price=$price&price_range=$range&rating=$rating&filter_category_id=$filterCategory&keywords=$keyword&banner_id=$bannerId"
        "&token=$token&page=$page");
    ProductListRes res  = ProductListRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> getTailorList({id, page, dynamic city}) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    var response = await _http.get("${Api.tailorList}?p_sub_cat_id=$id&city=$city&token=$token&page=$page"
        "&token=$token&page=$page");
    TailorListRes res  = TailorListRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> getFilters() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    var response = await _http.get("${Api.filter}?token=$token");
    FilterRes res  = FilterRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> addressList(body) async {
    var response = await _http.post("${Api.address}",body,contentType: true);
    AddressListRes res  = AddressListRes.fromMap(jsonDecode(response));
    return res;
  }
///add, update and delete address
  Future<dynamic> address(body) async {
    var response = await _http.post(Api.address,body,contentType: true);
    AddAddressRes res  = AddAddressRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> favoriteList() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    var response = await _http.get("${Api.favorite}?token=$token");
    FavoriteListRes res  = FavoriteListRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> addFavorite(body) async {
    var response = await _http.post(Api.favorite,body,contentType: true);
    AddFavoriteRes res  = AddFavoriteRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> cartList(body) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    var response = await _http.post(Api.cart,body,contentType: true);
    CartListRes res  = CartListRes.fromMap(jsonDecode(response));
    return res;
  }

  ///add, update and delete cart
  Future<dynamic> addCart(body) async {
    var response = await _http.post(Api.cart,body,contentType: true);
    AddCartRes res  = AddCartRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> couponList() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    var response = await _http.get("${Api.coupon}?token=$token");
    CouponListRes res  = CouponListRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> myOrders(status,page) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    var response = await _http.get("${Api.myOrder}?status=$status&token=$token&page=$page");
    MyOrderListRes res  = MyOrderListRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> cancelOrder(body) async {
    var response = await _http.post(Api.cancelOrder,body,contentType: true);
    OrderRes res  = OrderRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> placeOrder(body) async {
    var response = await _http.post(Api.placeOrder,body,contentType: true);
    OrderRes res  = OrderRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> reviewList(value,id,page) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    var response = await _http.get("${Api.review}?action=list&$value=$id&token=$token&page=$page");
    ReviewListRes res  = ReviewListRes.fromMap(jsonDecode(response));
    return res;
  }

}

