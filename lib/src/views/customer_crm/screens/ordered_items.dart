import 'package:aadaiz_customer_crm/src/views/customer_crm/app_components/aadaiz_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../app_components/app_colors.dart';
import '../app_components/items.dart';
import 'chat_screen.dart';

class OrderedItems extends StatefulWidget {
  
  final String product_name;
  final List<String> images;
  final String shopId;
  final String orderId;
  final String shopName;
   OrderedItems({
    super.key,
    required this.product_name,
    required this.images, required this.shopId, required this.shopName, required this.orderId
    });

  @override
  State<OrderedItems> createState() => _OrderedItemsState();
}

class _OrderedItemsState extends State<OrderedItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductDetails(
              title:widget.product_name,
              price: 198.00,
              imageUrls:widget.images,
            ),
            SizedBox(height: 94.h,),
            Padding(
              padding: const EdgeInsets.only(left: 16.0,right: 16),
              child: AadaizButton(title: "Chat with team",onTap: (){Get.to(ChatScreen(shopName:widget.shopName,shopId: widget.shopId,orderId: widget.orderId,));},),
            )
          ],
        ),
      ),
    );
  }
}
