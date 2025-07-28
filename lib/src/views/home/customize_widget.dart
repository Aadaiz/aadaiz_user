import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/views/home/self_customization/self_customization_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomizeWidget extends StatefulWidget {
  const CustomizeWidget({super.key});

  @override
  State<CustomizeWidget> createState() => _CustomizeWidgetState();
}

class _CustomizeWidgetState extends State<CustomizeWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          InkWell(
            onTap: (){
             Get.to(()=> const SelfCustomizationHomeScreen());
            },
            child: Image.asset(
              'assets/images/self.png',
              fit:BoxFit.fill,
              height: 20.0.hp,
              width: Get.width*0.89,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/cb.png',
                fit:BoxFit.fill,
                height: 20.0.hp,
                width: Get.width*0.445,

              ),
              Image.asset(
                'assets/images/db.png',
                fit:BoxFit.fill,
                width: Get.width*0.440,

              ),
            ],
          ),
        ],
      ),
    );
  }
}
