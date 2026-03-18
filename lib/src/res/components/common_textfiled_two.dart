import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/app_components/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonTextFieldTwo extends StatelessWidget {

  final String? labelName;
  final bool showLabel;
  final bool isRequired;
  final TextEditingController? controller;
  final String? hintName;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int maxLines;
  final Color fillColor;
  final Widget? suffixIcon;
  final bool readOnly;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextStyle? hintStyle;
  final TextStyle? lableStyle;
  final Function()? onTap;
  final bool? isBorderNeed;
  final int? maxLength;



  const CommonTextFieldTwo({
    super.key,
    this.labelName,
    this.showLabel = true,
    this.isRequired = false,
    this.controller,
    this.hintName,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.maxLines = 1,
    this.fillColor = AppColors.whiteColor,
    this.suffixIcon,
    this.readOnly = false,
    this.focusNode,
    this.nextFocusNode,
    this.hintStyle,
    this.lableStyle,
    this.onTap,
    this.isBorderNeed=true,
    this.maxLength
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);

    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          if (showLabel && labelName != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: RichText(
                text: TextSpan(
                  text: labelName,
                  style:lableStyle?? GoogleFonts.dmSans(
                    color: AppColors.blackColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    if (isRequired)
                      TextSpan(
                        text: " *",
                        style: GoogleFonts.dmSans(
                          color: AppColors.thickOrangeColor,
                        ),
                      ),
                  ],
                ),
              ),
            ),


          SizedBox(
            height: maxLines == 1 ? screenHeight * 0.067 : null,
            child: TextFormField(
              onTap: onTap,

              controller: controller,
              focusNode: focusNode,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              maxLines: maxLines,
              readOnly: readOnly,
maxLength: maxLength,
              decoration: InputDecoration(
                isDense: true,
                hintText: hintName,
                hintStyle: hintStyle ??
                    GoogleFonts.dmSans(
                      color: AppColors.textgrey,
                      fontSize: 12.sp,
                    ),

                filled: true,
                fillColor: fillColor,

                suffixIcon: suffixIcon,


                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:  BorderSide(
                    color:isBorderNeed==true? AppColors.textFieldBorderColor:Colors.transparent,
                  ),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:  BorderSide(
                    color:isBorderNeed==true? AppColors.textFieldBorderColor:Colors.transparent,
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:  BorderSide(
                    color:isBorderNeed==true? AppColors.textFieldBorderColor:Colors.transparent,
                  ),
                ),
              ),

              onFieldSubmitted: (_) {
                if (nextFocusNode != null) {
                  Utils.fieldFocusChange(
                    context: context,
                    currentFocus: focusNode!,
                    nextFocus: nextFocusNode!,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}