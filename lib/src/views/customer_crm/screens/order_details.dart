import 'package:aadaiz_customer_crm/src/views/customer_crm/app_components/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_components/aadaiz_button.dart';
import '../app_components/deliveryDetails.dart';
import '../app_components/expandInfo.dart';
import '../app_components/order_widget.dart';
import 'chat_screen.dart';

class OrderDetails extends StatefulWidget {


  final String order_name;
  final String order_no;
  final bool status;
  final String order_date;
  final String order_shop;
  final String order_item_count;
  final String delivery_date;
  final String name;
  final String phone;
  final String email;
  final String address;
  final String shopId;
   OrderDetails({
    super.key,
    required this.order_name,
    required this.status,
    required this.order_no,
    required this.order_shop,
    required this.order_item_count,
    required this.delivery_date,
    required this.order_date,
    required this.name,
    required this.email,
    required this.address,
    required this.phone, required this.shopId,
    });

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
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
        centerTitle: true,
        title: Text("Order details",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,fontSize: 14.0.sp,color: AppColors.blackColor),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30.h,),
            Padding(
              padding: const EdgeInsets.only(left: 16.0,right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/appvan.png",height: 46.h,width: 46.w,),
                  SizedBox(width: 10.w,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.order_name,style: GoogleFonts.montserrat(color: AppColors.blackColor,fontWeight: FontWeight.w500,fontSize: 14.0.sp),),
                        Text("Ord ID ${widget.order_no}",style: GoogleFonts.montserrat(color: AppColors.blackColor,fontWeight: FontWeight.w400,fontSize: 12.0.sp),),
                      ],
                    ),
                  ),
                  inProgress(completed:widget.status),
                  ],
              ),
            ),
            SizedBox(height: 50.h,),
            ExpandInfo(
              orderNumber: widget.order_no,
              date: widget.order_date,
              itemCount: int.parse(widget.order_item_count),
              shopName: widget.order_shop,
            ),
            SizedBox(height: 40.h,),
            Padding(
              padding: const EdgeInsets.only(left: 16.0,right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Delivery Date",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,fontSize: 14.0.sp,color: AppColors.blackColor),),
                  Text(widget.delivery_date,style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,fontSize: 14.0.sp,color: AppColors.blackColor),),

                ],
              ),
            ),
            SizedBox(height: 40.h,),
            DeliveryDetails(
              address: widget.address,
              name: widget.name,
              email: widget.email,
              phone: widget.phone,
            ),
            SizedBox(height: 62.h,),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0,horizontal: 16),
        child: AadaizButton(title: "Chat with team",onTap: (){Get.to(ChatScreen(shopName:widget.order_shop,shopId: widget.shopId,orderId: widget.order_no,));}),
      ),
    );
  }
}
