import 'package:get/get.dart';

class CallStateController extends GetxController {
  RxBool isCallActive = false.obs;
  RxString activeCallId = ''.obs;

  void setIncoming(String callId) {
    if (isCallActive.value) {
      return;
    }
    isCallActive.value = true;
    activeCallId.value = callId;
  }

  void endCall() {
    isCallActive.value = false;
    activeCallId.value = '';
  }
}
