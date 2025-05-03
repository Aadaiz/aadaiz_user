import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../app_components/calling_screen.dart';

class ConnectCall extends StatefulWidget {
  const ConnectCall({super.key});

  @override
  State<ConnectCall> createState() => _ConnectCallState();
}

class _ConnectCallState extends State<ConnectCall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: ()=> Get.back(),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Image.asset("assets/images/bac1.png",height: 39.h,width: 39.w,),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CallScreen(
            name: 'Aadaiz Team',
            status: 'Calling...',
            imageUrl: 'https://t4.ftcdn.net/jpg/05/07/95/21/360_F_507952111_67OxZSqsFTUPiSkKqb7QkSmdEo5WFght.jpg',
          ),
          SizedBox(height: 260.h,),
          Image.asset("assets/images/callend.png",height: 60.h,width: 60.w,)
        ],
      ),
    );
  }
}
