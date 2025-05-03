import 'package:aadaiz_customer_crm/main.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/model/notification_model.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/model/notification_model.dart'
    as notification;
import 'package:aadaiz_customer_crm/src/views/customer_crm/repository/customer_repository.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/model/customer_orders.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/repository/customer_repository.dart';
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

  Future<dynamic> getOrders({filter = "progress", dynamic search}) async {
    isLoading.value = true;
    final OrdersData res = await repo.getOrders(filter: filter, search: search);
    isLoading.value = false;
    if (res.status == true) {
      orderDatas.value = res;
    }
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

}
