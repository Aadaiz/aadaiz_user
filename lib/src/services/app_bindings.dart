import 'package:aadaiz_customer_crm/src/views/buy_and_sell/controller/buyAndSellController.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings{
  @override
  void dependencies(){
    Get.put(BuyAndSellController(), permanent: true);

  }
}