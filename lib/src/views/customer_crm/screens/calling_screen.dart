



import 'package:flutter/material.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatelessWidget {


  final String user;
   const CallPage({super.key,required this.user });
  

  @override
  Widget build(BuildContext context) {
    return SizedBox();
    // return ZegoUIKitPrebuiltCall(
    //   appID: 558911320,
    //   appSign: "24afc6b4d4b74a4670f3cf1851d2dfb1c4a751a44066c2aeaa493259034512d6",
    //   userID: user,
    //   userName: user,
    //   callID: "caller46",
    //   // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
    //   config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
    // );
  }
}
