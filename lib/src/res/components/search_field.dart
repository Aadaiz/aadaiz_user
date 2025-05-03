import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchField extends StatelessWidget {
  final TextEditingController? controllers;
  final String hinttext;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  const SearchField({
    Key? key,
    this.controllers,
    required this.hinttext,
    this.onChanged, this.onSubmitted,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Add padding around the search bar
      //padding: const EdgeInsets.symmetric(horizontal: 8.0),
      // Use a Material design search bar
      height: 05.5.hp, width: 93.00.wp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffF7F7F7),
          boxShadow:  [
            BoxShadow(
              offset: Offset(2, 2),
              blurRadius: 20,
              color: AppColor.unSelectColor.withOpacity(0.1),
            )
          ]
      ),

      child: TextFormField(
        controller: controllers,
        onChanged: (value){
          onChanged!(value);
        },
        onFieldSubmitted: (value){
          onSubmitted!(value);
        },
        style: GoogleFonts.dmSans(
            textStyle: TextStyle(
                fontSize: 11.00.sp,
                color: AppColor.unSelectColor.withOpacity(0.5),
                fontWeight: FontWeight.w500)),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 10,left: 16),
          hintText: hinttext,
          hintStyle: GoogleFonts.dmSans(
              textStyle: TextStyle(
                  fontSize: 12.00.sp,
                  color:AppColor.unSelectColor.withOpacity(0.5),
                  fontWeight: FontWeight.w400)),
          border: InputBorder.none,

          // Add a search icon or button to the search bar
          prefixIcon: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Image.asset(
              'assets/images/search.png',
              //height: 01.50.hp,
              width: 02.50.wp,
              color: AppColor.primary,
            ),
          ),

          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Color(0xffF7F7F7)),
          ),
        ),
      ),
    );
  }
}
