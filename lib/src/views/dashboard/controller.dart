import 'package:get/get.dart';

class DashboardController extends GetxController{
  static DashboardController get to => Get.put(DashboardController(),permanent: true);

  final RxInt tabSelected = 0.obs;
}