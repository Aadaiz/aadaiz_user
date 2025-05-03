import 'package:aadaiz_customer_crm/src/views/customer_crm/model/customer_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/order_details.dart';
import '../screens/ordered_items.dart';
import 'app_colors.dart';

class OrderWidget extends StatefulWidget {
  final bool is_completed;
  final String order_name;
  final String order_no;
  final List<OrdersProduct> products;
    final String order_date;
  final String order_shop;
  final String order_item_count;
  final String delivery_date;
  final String name;
  final String phone;
  final String email;
  final String address;
  final String shopId;
  OrderWidget({
    super.key,
    required this.order_name,
    required this.order_no,
    required this.is_completed,
    required this.products,
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
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {

   bool expand = false;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: ()=> Get.to(OrderDetails(
        status:widget.is_completed,
        order_name: widget.order_name,
        order_no: widget.order_no,
        order_shop: widget.order_shop,
        order_item_count:widget.order_item_count , 
        delivery_date: widget.delivery_date,
        order_date: widget.order_date,
        name: widget.name, 
        email: widget.email, 
        address: widget.address,
        phone: widget.phone,
        shopId: widget.shopId,
      )),
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.09),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    inProgress(completed:widget.is_completed),
                    SizedBox(width: 24.w,),
                    InkWell(
                      onTap: (){
                        setState(() {
                        expand = !expand;
                      });},
                        child: Image.asset(expand ?"assets/images/up.png":"assets/images/downarr.png",height: 14.h,width: 14.w,)),
                  ],
                ),
              ),
             expand? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 18.h,),
                  Divider(color: Color(0xffD9D9D9),),
                  SizedBox(height: 8.h,),
                  Text("Products",style: GoogleFonts.montserrat(fontSize: 12.0.sp,fontWeight: FontWeight.w600,color: AppColors.blackColor),),
                  SizedBox(height: 8.h,),
                  Column(
                    children: [
                      for(var p in widget.products)
                        buildStatusCard(
                          title: p.name ?? "null", 
                          status: p.productStatus ?? false, 
                          images: [
                            p.image1??"",
                            p.image2??"",
                            p.image3??"",
                            ], shopName: widget.order_shop, shopId: widget.shopId, orderId: p.id,
                          ),
                    ]
                  ),
                  

                 
      
                ],
              ):SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
Widget inProgress({required bool completed}){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
    decoration: BoxDecoration(
      color:completed? Color(0xFFC8FFF4): Color(0xffFFEBB2), // Light yellow
      borderRadius: BorderRadius.circular(20.r),
    ),
    child: Text(
      completed? "Completed": 'In Progress',
      style: GoogleFonts.montserrat(
        fontSize: 12.0.sp,
        color: Colors.black,
      ),
    ),
  );
}



Widget buildStatusCard({
  required String title,  
  required List<String> images, 
  required bool status,
  required dynamic shopName,
  required dynamic shopId,
  required dynamic orderId,
  }) {
  final String statusText = status ? 'Completed' : 'In progress';
  final Color statusBgColor = status
      ? const Color(0xFFC8FFF4) // Completed - teal
      : const Color(0xFFFFE2AD); // In progress - light orange
  final Color outline = status
      ? const Color(0xFF3BFF98) // Completed - teal
      : const Color(0xFFFFCB85); // In progress - light orange

  return GestureDetector(
    onTap: (){Get.to(OrderedItems(product_name: title, images: images, shopId: shopId, shopName: shopName, orderId: orderId,));},
    child: Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 22.h),
      decoration: BoxDecoration(
        color: AppColors.tab_bar_bg, // Card background
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 12.0.sp,
              color: Colors.black,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: statusBgColor,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: outline)
            ),
            child: Text(
              statusText,
              style: GoogleFonts.montserrat(
                fontSize: 12.0.sp,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
