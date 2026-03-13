import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;


  final Widget? suffixWidget;


  final bool showSuffix;


  final bool enableShadow;

  const SearchField({
    super.key,
    this.controller,
    required this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.suffixWidget,
    this.showSuffix = false,
    this.enableShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(12),
        boxShadow: enableShadow
            ? [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 20,
            color: AppColor.unSelectColor.withAlpha(60),
          )
        ]
            : [],
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        style: GoogleFonts.dmSans(
          fontSize: 13,
          color: AppColor.unSelectColor,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.dmSans(
            fontSize: 13,
            color: AppColor.unSelectColor.withOpacity(0.5),
          ),
          border: InputBorder.none,

          contentPadding: const EdgeInsets.symmetric(vertical: 15),


          prefixIcon: Padding(
            padding: const EdgeInsets.all(14),
            child: Image.asset(
              'assets/images/search.png',
              width: 18,
              color: AppColor.primary,
            ),
          ),


          suffixIcon: showSuffix ? suffixWidget : null,
        ),
      ),
    );
  }
}
