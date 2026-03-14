import 'package:aadaiz_customer_crm/src/views/Event/controller/event_controller.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/controller/buyAndSellController.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/chat/controller/ChatMessageController.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/chat/controller/ChatSocketController.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/chat/controller/call_controller.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/controller/jobs_controller.dart';
import 'package:aadaiz_customer_crm/src/views/material/controller/material_controller.dart';
import 'package:aadaiz_customer_crm/src/views/profile/controller/profile_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings{
  @override
  void dependencies(){
    Get.put(BuyAndSellController(), permanent: true);
    Get.put(EventController(), permanent: true);
    Get.put(ChatSocketController(), permanent: true);
    Get.put(ChatMessageController(), permanent: true);
    Get.put(ProfileController(), permanent: true);
    Get.put(CallStateController(), permanent: true);
    Get.put(MaterialController(), permanent: true);
    Get.put(JobsController(), permanent: true);




  }
}