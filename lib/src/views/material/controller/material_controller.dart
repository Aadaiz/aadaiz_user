import 'package:aadaiz_customer_crm/src/views/material/model/category_list_model.dart';
import 'package:aadaiz_customer_crm/src/views/material/model/category_list_model.dart'as material;
import 'package:aadaiz_customer_crm/src/views/material/model/material_category_model.dart';
import 'package:aadaiz_customer_crm/src/views/material/model/material_category_model.dart' as category;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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

  Future<dynamic> getMaterials({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage.value = 1;
    } else {
      currentPage.value++;
    }
    materialLoading(true);
    MaterialListRes res =
        await repo.getMaterialList(page: currentPage.value, search: '');
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
}
