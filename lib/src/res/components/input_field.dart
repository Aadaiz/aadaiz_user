import 'package:aadaiz/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatelessWidget {
  final String labeltext;
  final TextEditingController? controller;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  // final Color? bgcolor;
  //final double? radiusvalue;
  // final Color bordercolor;
  // final double? elevationvalue;
  // final VoidCallback press;
  final Widget? prefixicon;
  final dynamic type;

  const InputField({
    Key? key,
    required this.labeltext,

    //this.bgcolor,
    this.controller,
    this.prefixicon,
    required this.validator,
    this.keyboardType,
    this.type = true,

    // required this.bordercolor,
    //  this.radiusvalue,
    // this.elevationvalue,

    // required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: TextFormField(
        inputFormatters: [
          type
              ? LengthLimitingTextInputFormatter(100)
              : LengthLimitingTextInputFormatter(10),
        ],
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 11.00.sp,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w500)),
        decoration: InputDecoration(
          labelText: labeltext,
          labelStyle: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 12.00.sp,
                  color: const Color(0xff6F6F6F),
                  fontWeight: FontWeight.w400)),
          prefixIcon: prefixicon,
          enabledBorder: const UnderlineInputBorder(
            borderSide:
            BorderSide(color: Color(0xff6F6F6F), width: 0.5), //<-- SEE HERE
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide:
            BorderSide(color: Color(0xFF9C27C0), width: 0.5), //<-- SEE HERE
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide:
            BorderSide(color: Color(0xff6F6F6F), width: 0.5), //<-- SEE HERE
          ),
        ),
      ),
    );
  }
}