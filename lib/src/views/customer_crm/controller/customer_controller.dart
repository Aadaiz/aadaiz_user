import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aadaiz_customer_crm/main.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/model/notification_model.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/model/notification_model.dart'
    as notification;
import 'package:aadaiz_customer_crm/src/views/customer_crm/repository/customer_repository.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/model/customer_orders.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/repository/customer_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../utils/utils.dart';

class CustomerController extends GetxController {
  final CustomerRepository repo = CustomerRepository();
  var isLoading = false.obs;

  @override
  void onInit() {
    getNotifications(isRefresh: true);
    super.onInit();
  }

  var orderDatas = OrdersData.fromMap({}).obs;

  final feedbackController = TextEditingController();
  RxDouble rating = 0.0.obs;
  int currentPageNew = 1;
  int currentPageExisting = 1;

  bool hasMoreNew = true;
  bool hasMoreExisting = true;

  Future<void> getOrders({
    filter = "progress",
    dynamic search,
    int page = 1,
    bool isLoadMore = false,
    bool isNewOrder = true,
  }) async {
    if (!isLoadMore) isLoading.value = true;

    final OrdersData res =
    await repo.getOrders(filter: filter, search: search, page: page);

    if (res.status == true) {
      if (isLoadMore) {
        if (isNewOrder) {
          if (res.data?.newOrders?.data?.isEmpty ?? true) {
            hasMoreNew = false;
          } else {
            orderDatas.value.data?.newOrders?.data
                ?.addAll(res.data!.newOrders!.data!);

            currentPageNew++;
          }
        } else {
          if (res.data?.existingOrders?.data?.isEmpty ?? true) {
            hasMoreExisting = false;
          } else {
            orderDatas.value.data?.existingOrders?.data
                ?.addAll(res.data!.existingOrders!.data!);
            currentPageExisting++;
          }
        }
      } else {
        orderDatas.value = res;
        currentPageNew = 1;
        currentPageExisting = 1;
        hasMoreNew = true;
        hasMoreExisting = true;
      }
    }

    if (!isLoadMore) isLoading.value = false;
  }

  final currentPage = 1.obs;
  final totalPages = 1.obs;

  var notificationList = <notification.Datum>[].obs;

  Future<dynamic> getNotifications({
    bool isRefresh = false,
  }) async {
    if (isRefresh) {
      notificationList.clear();
      currentPage.value = 1;
    } else {
      currentPage.value++;
    }
    final NotificationRes res = await repo.getNotifications();
    if (res.status == true) {
      totalPages.value = res.data!.lastPage;
      if (res.data!.data!.isNotEmpty) {
        if (isRefresh) {
          notificationList.value = res.data!.data!;
        } else {
          final newItems = res.data!.data ?? [];
          notificationList.addAll(newItems);
        }
      }
    }
    return true;
  }
  Rx<File?> fileData = Rx<File?>(null);
  RxBool fileLoading = false.obs;

  Future<File?> invoiceData(dynamic id) async {
    try {
      fileLoading(true);

      final SharedPreferences prefs =
      await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      final response =
      await repo.superAdminExportData(
        token: token.toString(),
        id: id,
      );

      if (response != null) {
        fileData.value = response;
        return response;
      }
    } catch (e) {
      debugPrint("Invoice Error: $e");
    } finally {
      fileLoading(false);
    }
    return null;
  }


  String timeAgo(DateTime inputTime) {
    final now = DateTime.now().toUtc();
    final diff = now.difference(inputTime);

    if (diff.inSeconds < 60) {
      return '${diff.inSeconds} second${diff.inSeconds == 1 ? '' : 's'} ago';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
    } else if (diff.inDays < 30) {
      return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
    } else if (diff.inDays < 365) {
      final months = (diff.inDays / 30).floor();
      return '$months month${months == 1 ? '' : 's'} ago';
    } else {
      final years = (diff.inDays / 365).floor();
      return '$years year${years == 1 ? '' : 's'} ago';
    }
  }

  ratings(dynamic id, dynamic ratings, String comments) async {
    isLoading.value = true;
    try {
      Map<String, dynamic> request = {
        "ratings": rating.value,
        "comments": comments,
      };

      // Convert map to JSON string here
      final res = await repo.ratings(
        id: id,
        search: jsonEncode(request),
      );

      final data = jsonDecode(res); // decode response
      if (data['status'] == true) {
        CommonToast.show(msg: '${data['message']}');
        feedbackController.clear();
        rating.value = 0;
      }
      else{
        CommonToast.show(msg: '${data['message']}');
        feedbackController.clear();
        rating.value = 0;

      }
    } finally {
      isLoading.value = false;
    }
  }



}
