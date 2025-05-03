import 'package:aadaiz_customer_crm/src/views/customer_crm/app_components/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AadaizButton extends StatefulWidget {
  final String title ;

  var onTap;
   AadaizButton({
    super.key,
    required this.onTap,
    this.title = "",
  });

  @override
  State<AadaizButton> createState() => _AadaizButtonState();
}

class _AadaizButtonState extends State<AadaizButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColors.projectcolor,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            //spacing: 8.w,
            children: [
              Image.asset("assets/images/question.png",height: 24.h,width: 24.w,),
              SizedBox(width:8.w),
              Text(widget.title,style: GoogleFonts.montserrat(fontSize: 14.0.sp,fontWeight: FontWeight.w700,color: AppColors.whiteColor),),
            ],
          ),
        ),
      ),
    );
  }
}
