import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/services/api_service.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/model/buy_and_sell_list_model.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/repository/buy_and_sell_repository.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/app_components/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class BuyAndSellController extends GetxController {
  TextEditingController productName = TextEditingController();

  TextEditingController subProductName = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController st = TextEditingController();
  TextEditingController pin = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController land = TextEditingController();
  TextEditingController mob = TextEditingController();
  TextEditingController acc = TextEditingController();
  TextEditingController conacc = TextEditingController();
  TextEditingController ifsc = TextEditingController();
  final BuyAndSellRepository repo = BuyAndSellRepository();
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isPrice = false.obs;

  RxList<String> categoryList = ['Men', 'Women', 'Girl-Kid', 'Boy-Kid'].obs;
  RxString selectedCategory = ''.obs;
  Rx<File?> image1 = Rx<File?>(null);
  Rx<File?> image2 = Rx<File?>(null);
  Rx<File?> image3 = Rx<File?>(null);
  RxString urlImage1 = ''.obs;
  RxString urlImage2 = ''.obs;
  RxString urlImage3 = ''.obs;

  final ImagePicker _picker = ImagePicker();

  Future<void> showDialogImage(context, {required int picture}) {
    return showDialog(
      context: context,
      builder: (context) {
        var sel = 0;
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: 95.0.wp,
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Please Choose',
                          style: GoogleFonts.dmSans(
                            fontSize: 14.0.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.cancel,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.0.hp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              sel = 1;
                              openCamera(camera: false, picture: picture);
                            });
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.image,
                                size: 50,
                                color:
                                    sel == 1
                                        ? AppColors.projectcolor
                                        : Colors.grey,
                              ),
                              SizedBox(height: 1.0.hp),
                              Text(
                                'Gallery',
                                style: GoogleFonts.dmSans(
                                  fontSize: 11.0.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              sel = 2;
                              openCamera(camera: true, picture: picture);
                            });
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.camera_alt_rounded,
                                size: 50,
                                color:
                                    sel == 2
                                        ? AppColors.projectcolor
                                        : Colors.grey,
                              ),
                              SizedBox(height: 1.0.hp),
                              Text(
                                'Camera',
                                style: GoogleFonts.dmSans(
                                  fontSize: 11.0.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.0.hp),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> openCamera({required bool camera, required int picture}) async {
    Get.back();

    final pickedFile = await _picker.pickImage(
      source: camera ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 1000,
      maxHeight: 1000,
    );

    if (pickedFile == null) return;

    final File file = File(pickedFile.path);

    if (picture == 1) {
      image1.value = file;
    } else if (picture == 2) {
      image2.value = file;
    } else if (picture == 3) {
      image3.value = file;
    }
  }

  var addBuyAndSellLoading = false.obs;
  Future<void> addBuyAndSell(bool? isEdit, {dynamic id}) async {
    try {
      addBuyAndSellLoading.value = true;

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final uri = Uri.parse(
        isEdit == true ? "${Api.updateBuyAndSell}/$id" : Api.addBuyAndSell,
      );

      final request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = 'Bearer $token';

      request.fields['product_name'] = productName.text;
      request.fields['sub_product_name'] = subProductName.text;
      request.fields['category'] = selectedCategory.value ?? '';
      request.fields['price'] = priceController.text;
      request.fields['size'] = sizeController.text;
      request.fields['product_description'] = descriptionController.text;
      request.fields['mobile_number'] = phoneController.text;
      request.fields['sell_country'] = country.text;
      request.fields['sell_state'] = state.text;
      request.fields['sell_street'] = st.text;
      request.fields['sell_pincode'] = pin.text;
      request.fields['sell_city'] = city.text;

      if (image1.value != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'product_image',
            image1.value!.path,
          ),
        );
      }

      if (image2.value != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'product_front_image',
            image2.value!.path,
          ),
        );
      }

      if (image3.value != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'product_back_image',
            image3.value!.path,
          ),
        );
      }

      final response = await request.send();
      final responseData = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        final res = jsonDecode(responseData.body);

        if (res['status'] == true) {
          CommonToast.show(msg: res['message']);
          await getBuyAndSellList(isRefresh: true);
          featureSelected.value = 1;

          Get.back();
          clearAllFields();
        } else {
          CommonToast.show(msg: res['message']);
        }
      } else {
        CommonToast.show(msg: "Error: ${response.statusCode}");
      }
    } catch (e) {
      log("Error: ${e.toString()}");
    } finally {
      addBuyAndSellLoading.value = false;
    }
  }

  var buyAndSellListLoading = false.obs;
  var featureSelected = 0.obs;
  var featuredProducts = <OurProductsDatum>[].obs;
  var yourAdsProducts = <OurProductsDatum>[].obs;
  var orderProducts = <OrderProductsDatum>[].obs;
  var purchasedProducts = <OrderProductsDatum>[].obs;
  var featuredPage = 1;
  var yourAdsPage = 1;
  var orderPage = 1;
  var purchasedPage = 1;
  var featuredLastPage = 1;
  var yourAdsLastPage = 1;
  var orderLastPage = 1;
  var purchasedLastPage = 1;
  RefreshController refreshController = RefreshController();

  Future<void> getBuyAndSellList({int page = 1, bool isRefresh = false}) async {
    try {
      buyAndSellListLoading.value = true;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final res = await repo.getBuyAndSellList(token!, page);
      if (res.status == true) {
        final model = res;
        if (isRefresh) {
          featuredProducts.clear();
          yourAdsProducts.clear();
          orderProducts.clear();
          purchasedProducts.clear();
        }
        if (model.products?.data != null) {
          featuredProducts.addAll(model.products!.data!);
          featuredLastPage = model.products?.pagination?.lastPage ?? 1;
        }
        if (model.ourProducts?.data != null) {
          yourAdsProducts.addAll(model.ourProducts!.data!);
          yourAdsLastPage = model.ourProducts?.pagination?.lastPage ?? 1;
        }
        if (model.orderProducts?.data != null) {
          orderProducts.addAll(model.orderProducts!.data!);
          orderLastPage = model.orderProducts?.pagination?.lastPage ?? 1;
        }
        if (model.purchasedProducts?.data != null) {
          purchasedProducts.addAll(model.purchasedProducts!.data!);
          purchasedLastPage =
              model.purchasedProducts?.pagination?.lastPage ?? 1;
        }
      }
    } catch (e) {
    } finally {
      buyAndSellListLoading.value = false;
      refreshController.refreshCompleted();
      refreshController.loadComplete();
    }
  }

  Future<void> onRefresh() async {
    featuredPage = 1;
    yourAdsPage = 1;
    orderPage = 1;
    purchasedPage = 1;
    await getBuyAndSellList(page: 1, isRefresh: true);
  }

  Future<void> onLoadMore() async {
    final int currentTab = featureSelected.value;
    if (currentTab == 0 && featuredPage < featuredLastPage) {
      featuredPage++;
      await getBuyAndSellList(page: featuredPage);
    } else if (currentTab == 1 && yourAdsPage < yourAdsLastPage) {
      yourAdsPage++;
      await getBuyAndSellList(page: yourAdsPage);
    } else if (currentTab == 2 && orderPage < orderLastPage) {
      orderPage++;
      await getBuyAndSellList(page: orderPage);
    } else if (currentTab == 3 && purchasedPage < purchasedLastPage) {
      purchasedPage++;
      await getBuyAndSellList(page: purchasedPage);
    } else {
      refreshController.loadNoData();
    }
  }

  var deletingBuyAndSellId = Rxn<int>();
  Future<void> deleteBuyAndSell(dynamic id) async {
    try {
      deletingBuyAndSellId.value = id;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final res = await repo.deleteBuyAndSell(token!, id);
      if (res['status'] == true) {
        CommonToast.show(msg: res['message']);
        featureSelected.value = 1;
        await getBuyAndSellList(isRefresh: true);
      } else {
        CommonToast.show(msg: res['message']);
      }
    } catch (e) {
    } finally {
      deletingBuyAndSellId.value = null;
    }
  }


  void clearAllFields() {
    productName.text = '';
    subProductName.text = '';
    categoryController.text = '';
    priceController.text = '';
    sizeController.text = '';
    descriptionController.text = '';
    country.text = '';
    state.text = '';
    st.text = '';
    pin.text = '';
    city.text = '';
    phoneController.text = '';
    urlImage1.value = '';
    urlImage2.value = '';
    urlImage3.value = '';
    image1.value = null;
    image2.value = null;
    image3.value = null;
  }
}
