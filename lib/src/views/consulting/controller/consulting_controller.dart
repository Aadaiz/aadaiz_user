import 'dart:convert';

import 'package:aadaiz_customer_crm/src/views/consulting/models/appointment_list_model.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/models/consulting_category_model.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/models/consulting_designer_model.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/repository/consulting_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/appointment_ create_model.dart';
import '../models/consulting_available_slot_model.dart';

class ConsultingController extends  GetxController{
  static ConsultingController get to => Get.put(ConsultingController());
  var repo = ConsultingRepository();

  var categoryLoading = false.obs;
  var categoryList = <ConsultingCategory>[].obs;
  var designerPrefsList = <ConsultingCategory>[].obs;

  Future<dynamic> getCategory() async {
    categoryLoading(true);
    ConsultingCategoryRes res = await repo.getCategory();
    categoryList.clear();
    designerPrefsList.clear();
    if(res.success==true){
      for(var i=0;i<res.data!.length; i++){
        print('category list $i ${res.data![i].type} ');
        if(res.data![i].type=='category'){
          categoryList.value.add(res.data![i]);
        }else{
          designerPrefsList.value.add(res.data![i]);
        }
      }
      categoryLoading(false);
    }else{
      categoryList.clear();
    }
  }

  var designerLoading=false.obs;
  var designerList =<Designer>[].obs;

  Future<dynamic> getDesigners(id,designer) async {
    designerLoading(true);
    ConsultingDesignerRes res = await repo.getDesigners(id, designer);
    if(res.success==true){
      designerList.value=res.data!;
      designerLoading(false);
    }else{
      designerList.clear();
    }
  }

  var availableSlotLoading=false.obs;
  var availableSlotsList =[].obs;

  Future<dynamic> getAvailableSlots(id,date) async {
    availableSlotsList.clear();
    availableSlotLoading(true);
    AppointmentAvailableRes res = await repo.getAvailableSlots(id, date);
    if(res.success==true){
      availableSlotLoading(false);
      for(var i=0;i<res.data!.length; i++){
        availableSlotsList.add(res.data![i].time);
      }
    }else{
      availableSlotLoading(false);
    }
  }

  var createAppointmentLoading = false.obs;

  Future<dynamic> createAppointment(id,date,time) async {
    createAppointmentLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    final Map<String, dynamic> body = {
      'designer_id':'$id',
      'token':'$token',
      'date':'$date',
      'time':'$time',
    };
    AppointmentCreateRes res = await repo.createAppointment(jsonEncode(body));
    if(res.status==true){
      createAppointmentLoading(false);
    }else{
      createAppointmentLoading(false);
    }
  }


  var appointmentList =<ConsultingAppointment>[].obs;
  final currentPage = 1.obs;
  final totalPages = 1.obs;


  Future<dynamic> getAppointments({bool isRefresh = false,dynamic status}) async{
    if (isRefresh) {
      currentPage.value = 1;
      appointmentList.clear();
    } else {
      currentPage.value++;
    }
    AppointmentRes res = await repo.getAppointments(status, currentPage.value);
    if(res.status==true){
      totalPages.value=res.data!.lastPage;
      print('tadad ${totalPages.value}');
      if(res.data!.data!.isNotEmpty){
        if(isRefresh){
          appointmentList.value = res.data!.data!;
        }else{
          final newItems = res.data!.data ?? [];
          appointmentList.addAll(newItems);
        }
      }else{
        appointmentList.clear();
      }
    }else{

    }
    return true;
  }
}