import 'dart:async';
import 'dart:convert';

import 'package:aadaiz/src/res/components/common_toast.dart';
import 'package:aadaiz/src/views/home/model/banner_model.dart';
import 'package:aadaiz/src/views/home/model/banner_model.dart' as banner;
import 'package:aadaiz/src/views/home/model/gender_model.dart';
import 'package:aadaiz/src/views/home/model/gender_model.dart' as gender;
import 'package:aadaiz/src/views/home/model/review_list_model.dart';
import 'package:aadaiz/src/views/home/repository/home_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../order/coupon.dart';
import '../model/add_address_model.dart';
import '../model/add_cart_model.dart';
import '../model/add_favorite_model.dart';
import '../model/addresslist_model.dart';
import '../model/cartlist_model.dart';
import '../model/category_model.dart';
import '../model/couponlist_model.dart';
import '../model/couponlist_model.dart' as coupon;
import '../model/favoritelist_model.dart';
import '../model/filter_model.dart';
import '../model/my_order_model.dart';
import '../model/my_order_model.dart' as order;
import '../model/order.dart';
import '../model/productlist_model.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.put(HomeController());
  var repo = HomeRepository();

  var listIndex=0.obs;

  var bannerLoading = false.obs;
  var bannerList = <banner.Datum>[].obs;

  Future<dynamic> getBannerList() async {
    bannerLoading(true);
    BannerListRes res = await repo.getBannerList();
    if (res.success == true) {
      bannerLoading(false);
      bannerList.value = res.data!;
    } else {
      bannerList.clear();
    }
  }

  var genderLoading = false.obs;
  var genderList = <gender.Datum>[].obs;

  Future<dynamic> getGender() async {
    genderLoading(true);
    GenderRes res = await repo.getGender();
    if (res.success == true) {
      genderLoading(false);
      genderList.value = res.data!;
    } else {
      genderList.clear();
    }
  }

  var categoryDataLoading = false.obs;
  var categoryData = CategoryDataRes().obs;
  List specialPatternText =[].obs;

  Future<dynamic> getCategoryData(id) async {
    categoryDataLoading(true);
    CategoryDataRes res = await repo.getCategoryData(id);
    if (res.status == true) {
      categoryDataLoading(false);
      categoryData.value = res;
      specialPatternText =  categoryData.value.specialPatternText.split(',');
    } else {}
  }
  
  

  final currentPage = 1.obs;
  final totalPages = 1.obs;
  var productList = <PatternListDatum>[].obs;
  var peopleMostViewList = <PatternListDatum>[].obs;
  var likeList = [].obs;
  var priceRange = ''.obs;
  var price = 'asc'.obs;
  var rating = ''.obs;
  var filterCategory = ''.obs;
  var bannerId = ''.obs;
  var catId = ''.obs;

  Future<dynamic> getProductList({bool isRefresh = false,dynamic id}) async {
    if (isRefresh) {
      currentPage.value = 1;
      productList.clear();
      peopleMostViewList.clear();
      likeList.clear();
    //  keyword='';
    } else {
      currentPage.value++;
    }
    ProductListRes res = await repo.getProductList(id:id??catId,page:currentPage.value,price:price??"" ,range: priceRange,rating: rating,
        filterCategory:filterCategory ,keyword:search.text??'' , bannerId:bannerId);
    if (res.status == true) {
      totalPages.value = res.patternList!.lastPage;
      peopleMostViewList.value = res.peopleMostViewlist!.data!;
      if (res.patternList!.data!.isNotEmpty) {
        if (isRefresh) {
          productList.value = res.patternList!.data!;
          likeList.value = List.generate(productList.value.length, (i)=>productList.value[i].isLiked??false);
        } else {
          final newItems = res.patternList!.data ?? [];
          productList.addAll(newItems);
          likeList.value = List.generate(productList.value.length, (i)=>productList.value[i].isLiked??false);
        }
      }
    } else {}
    return true;
  }

  var filterListLoading=false.obs;
  var filterList =  <Category>[].obs;
  
  Future<dynamic> getFilterList() async {
    filterListLoading(true);
    FilterRes res = await repo.getFilters();
    print('dsafdad res ${res}');
    if(res.status==true){
      filterListLoading(false);
      filterList.value=res.categories!;
      print('dsafdad${filterList.value}');
    }else{
      filterList.clear();
    }
  }

  var addressListLoading=false.obs;
  var addressList =  <Address>[].obs;
  List isDefaultList = [].obs;
  Future<dynamic> getAddressList() async {
    isDefaultList.clear();
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    addressListLoading(true);
    Map body = {
      'action':'list',
      'token':'$token',
    };
    AddressListRes res = await repo.addressList(jsonEncode(body));
    if(res.success==true){
      addressList.value = res.data!;
      isDefaultList = List.generate(
          HomeController.to.addressList.value.length, (index) =>
      HomeController.to.addressList.value[index].isDefault==1?true:false);
      addressListLoading(false);
    }else{
      addressList.clear();
    }
  }

TextEditingController name = TextEditingController();
TextEditingController mobile = TextEditingController();
TextEditingController landmark = TextEditingController();
TextEditingController city = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController state = TextEditingController();
TextEditingController zipCode = TextEditingController();
TextEditingController country = TextEditingController();

  var addressLoading=false.obs;
  Future<dynamic> address(action,{dynamic addressId,dynamic isDefault}) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    addressLoading(true);
    Map body = {
      'name':'${name.text}',
      'address':'${addressController.text}',
      'landmark':'${landmark.text}',
      'city':'${city.text}',
      'state':'${state.text}',
      'country':'${country.text}',
      'pincode':'${zipCode.text}',
      'mobile':'${mobile.text}',
      'is_default':'$isDefault',
      'action':'$action',
      'address_id':'$addressId',
      'token':'$token',
    };
    AddAddressRes res = await repo.address(jsonEncode(body));
    if(res.success==true){
      addressLoading(false);
      await getAddressList();
      Get.back();
    }else{
      addressLoading(false);
      CommonToast.show(msg: '${res!.message}');
    }
  }


  var favoriteList =<Favorites>[].obs;


  final favoriteCurrentPage = 1.obs;
  final favoriteTotalPages = 1.obs;

  Future<dynamic> getFavouriteList({bool isRefresh = false}) async{
    if (isRefresh) {
      favoriteCurrentPage.value = 1;
      favoriteList.clear();
    } else {
      favoriteTotalPages.value++;
    }
    FavoriteListRes res = await repo.favoriteList();
    if(res.success==true){
      favoriteTotalPages.value=res.data!.lastPage;
      if(res.data!.data!.isNotEmpty){
        if(isRefresh){
          favoriteList.value = res.data!.data!;
        }else{
          final newItems = res.data!.data ?? [];
          favoriteList.addAll(newItems);
        }
      }else{
        favoriteList.clear();
      }
    }else{

    }
    return true;
  }

  Future<dynamic> addFavorite(id) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    Map body ={
      'pattern_id': '$id',
      'token': '$token',
    };
    AddFavoriteRes res = await repo.addFavorite(jsonEncode(body));
  }


  var cartListLoading=false.obs;
  var cartList =CartListRes().obs;
  List itemValues = [].obs;

  Future<dynamic> getCartList({dynamic code, dynamic apply}) async {
    itemValues.clear();
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    cartListLoading(true);
    Map body = {
      'action':'list',
      'coupon_apply':'$apply',
      'coupon_code':'$code',
      'token':'$token',
    };
    CartListRes res = await repo.cartList(jsonEncode(body));
    if(res.success==true){
      cartListLoading(false);
      cartList.value = res;
      itemValues = List.generate(
          HomeController.to.cartList.value.data!.items!.length, (index) => 1);
    }else{
    }
  }


  TextEditingController length =  TextEditingController();
  TextEditingController shoulder =  TextEditingController();
  TextEditingController chest =  TextEditingController();
  TextEditingController waist =  TextEditingController();
  TextEditingController hip =  TextEditingController();

  var cartLoading=false.obs;

  Future<dynamic> cart({
 required   dynamic action,
     dynamic id,
     dynamic price,
     dynamic gst,
     dynamic quantity,
     dynamic size,
      dynamic cartId,
  }) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    cartLoading(true);
    Map body = {
      'pattern_id':'$id',
      'fabric_metre':'1',
      'size':'$size',
      'quantity':'$quantity',
      'price':'$price',
      'gst_percentage':'$gst',
      'measurement':{
        'length':'${length.text}',
        'shoulder':'${shoulder.text}',
        'chest':'${chest.text}',
        'waist':'${waist.text}',
        'hip':'${hip.text}',
      },
      'action':'$action',
      'cart_id':'$cartId',
      'coupon_apply':'',
      'coupon_code':'',
      'token':'$token',
    };
    AddCartRes res = await repo.addCart(jsonEncode(body));
    if(res.success==true){
      cartLoading(false);
    }else{

    }
  }

  var cartCountLoading = false.obs;

  void increment(int index) {
    cartCountLoading(true);
      HomeController.to.itemValues[index]++;
    cartCountLoading(false);
  }

  void decrement(int index) {
    cartCountLoading(true);
      if (HomeController.to.itemValues[index] > 1) {
        HomeController.to.itemValues[index]--;
      }
    cartCountLoading(false);
  }

  var couponListLoading=false.obs;
  var couponList =<coupon.Coupon>[].obs;

  Future<dynamic> getCouponList() async {
    couponListLoading(true);
    CouponListRes res = await repo.couponList();
    if(res.success==true){
      couponListLoading(false);
      couponList.value = res.data!;
    }
  }



  var myOrderListLoading=false.obs;
  final orderCurrentPage = 1.obs;
  final orderTotalPages = 1.obs;
  var myOrderList =<order.Datum>[].obs;

  Future<dynamic> getMyOrdersList({bool isRefresh = false,dynamic status}) async {
    if (isRefresh) {
      orderCurrentPage.value = 1;
      myOrderList.clear();
    } else {
      orderCurrentPage.value++;
    }
    MyOrderListRes res = await repo.myOrders(status,orderCurrentPage.value);
    if(res.status==true){
      orderTotalPages.value = res.data!.lastPage;
      if(res.data!.data!.isNotEmpty){
        if(isRefresh){
          myOrderList.value= res.data!.data!;
        }else{
          final newItems = res.data!.data??[];
          myOrderList.addAll(newItems);
        }
      }else{
        myOrderList.clear();
      }
    }else{

    }
    return true;
  }

  Future<dynamic>  cancelOrder() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    Map body ={
      'order_id':'',
      'token':'$token',
    };
    OrderRes res = await repo.cancelOrder(jsonEncode(body));
  }

  final reviewCurrentPage = 1.obs;
  final reviewTotalPages = 1.obs;
  var reviewList = <Review>[].obs;
  var totalRating = ''.obs;
  var averageRating = 0.0.obs;
  RxList ratingCount = [].obs;
  var reviewLoading =false.obs;

 Future<dynamic> getReviewList({bool isRefresh= false,dynamic id}) async {
    if(isRefresh){
      reviewCurrentPage.value=1;
      ratingCount.clear();
      reviewList.clear();
    }else{
      reviewCurrentPage.value++;
    }
    reviewLoading(true);
    ReviewListRes res = await repo.reviewList(id);
    if(res.status==true){
      reviewLoading(false);
      reviewTotalPages.value=res.data!.lastPage!;
      totalRating.value=res.totalRatings.toString();
      averageRating.value=res.averageRating!;
      for(var i=0;i<res.ratingCounts!.length;i++){
        ratingCount.add(res.ratingCounts![i]);
      }
      if(res.data!.data!.isNotEmpty){
        if(isRefresh){
          reviewList.value = res.data!.data!;
        }else{
          final newItems = res.data!.data ?? [];
          reviewList.addAll(newItems);
        }
      }else{
        reviewList.clear();
      }
    }else{

    }
    return true;
  }



  TextEditingController search = TextEditingController();
}
