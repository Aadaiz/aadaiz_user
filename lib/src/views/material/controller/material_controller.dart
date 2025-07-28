import 'dart:convert';

import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/views/material/model/category_list_model.dart';
import 'package:aadaiz_customer_crm/src/views/material/model/category_list_model.dart'as material;
import 'package:aadaiz_customer_crm/src/views/material/model/material_cart_list_model.dart';
import 'package:aadaiz_customer_crm/src/views/material/model/material_category_model.dart';
import 'package:aadaiz_customer_crm/src/views/material/model/material_category_model.dart' as category;
import 'package:aadaiz_customer_crm/src/views/material/model/material_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/material_repository.dart';

class MaterialController extends GetxController {
  static MaterialController get to => Get.put(MaterialController());

  var repo = MaterialRepository();

  final currentPage = 1.obs;
  final totalPages = 1.obs;
  var materialList = <material.Datum>[].obs;
  var likeList = [].obs;
  var peopleMostViewList = <material.Datum>[].obs;
  var materialLoading = false.obs;

  var price = 'low_to_high'.obs;

  Future<dynamic> getMaterials({bool isRefresh = false, dynamic search}) async {
    if (isRefresh) {
      currentPage.value = 1;
    } else {
      currentPage.value++;
    }
    materialLoading(true);
    MaterialListRes res =
        await repo.getMaterialList(page: currentPage.value, search: search,priceLowHigh:price);
    if (res.status == true) {
      materialLoading(false);
      if(res.materialList!.data!.isNotEmpty){
        peopleMostViewList.value=res.peopleMostViewlist!;
        if(isRefresh){
          materialList.value=res.materialList!.data!;
          likeList.value = List.generate(materialList.value.length, (i)=>materialList.value[i].isLiked==0?false:true??false);
        }else{
          final newItems = res.materialList!.data!??[];
          materialList.addAll(newItems);
          likeList.value = List.generate(materialList.value.length, (i)=>materialList.value[i].isLiked==0?false:true??false);
        }
      }
    } else {
      materialList.clear();
    }
    return true;
  }


  var orderLoading=false.obs;
  var categoryList = <category.Fabric>[].obs;

  getCategory() async {
    orderLoading(true);
    MaterialCategoryListRes res = await repo.getMaterialCategory();
    orderLoading(false);
    if(res.success==true){
      categoryList.value = res.fabric!;
    }else{
      categoryList.clear();
    }
  }


  TextEditingController length =  TextEditingController();
  var cartLoading = false.obs;
 Future<dynamic> addToCart(id,quantity) async {
    cartLoading(true);
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    Map body = {
      'material_id':id,
      'quantity':quantity,
      'token':token,
    };
    print('adfsf body $body');
    MaterialRes res = await repo.addToCart(body: jsonEncode(body));
    cartLoading(false);
    CommonToast.show(msg: res.message);
  }



  var cartListLoading =false.obs;
 var cartList = MaterialCartListRes().data.obs;

  Future<dynamic> getCart() async{
    cartListLoading(true);
   MaterialCartListRes res = await repo.getCart();
    cartListLoading(false);
    if(res.success==true){
      cartList.value = res.data;
    }else{
    }
  }
}
