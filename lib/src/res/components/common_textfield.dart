import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class CommonTextField extends StatefulWidget {
  final Function()?  callBack;
  final String hintText;
  final bool forPassword;
  final bool enablePrefixImage;
  final String? asset;
  final double width;
  final IconData? iconData;
  final Function(String value)? onchange;
  final TextInputType? type;
  final TextEditingController? textEditingController;
  final dynamic isMobile;
  final dynamic readOnly;
  final dynamic isDropDown;
  final dynamic isEdit;
  final dynamic edit;
  final String? Function(String?)? validator;

  CommonTextField(
      {super.key,
        this.asset,
        required this.hintText,
        this.forPassword = false,
        this.width = 321,
        this.iconData,
        this.textEditingController,
        this.type,
        this.enablePrefixImage = true,
        this.onchange,
        this.isMobile = false,
        this.readOnly = false,  this.callBack, this.isDropDown=false, this.isEdit=false, this.edit=false,  this.validator});

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  final textFieldFocusNode = FocusNode();
  bool _obscured = false;

  TextEditingController controler = TextEditingController();

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return; // If focus is on text field, dont unfocus
      }
      textFieldFocusNode.canRequestFocus =
      false; // Prevents focus if tap on eye
    });
  }

  @override
  void initState() {
    controler = widget.textEditingController ?? TextEditingController();
    super.initState();
    print('textedit ${widget.type}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: widget.width,
      decoration: BoxDecoration(
        color: const Color(0xffF7F8F9),
        boxShadow: const [
          BoxShadow(
              color: Colors.white, blurRadius: 2.0, offset: Offset(0.0, 0.0)),
        ],
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          if (widget.enablePrefixImage)
            Padding(
                padding: EdgeInsets.only(left: 15),
                child: (widget.iconData != null)
                    ? Icon(
                  widget.iconData,
                  size: 20,
                )
                    : const SizedBox()
            ),
          Expanded(
            child: TextFormField(
              onTap: widget.callBack,
              readOnly: widget.readOnly,
              controller: controler,
              inputFormatters: [
               widget.isMobile
                    ? LengthLimitingTextInputFormatter(10)
                    : LengthLimitingTextInputFormatter(100),
              ],
              keyboardType: (widget.type == null)
                  ? widget.forPassword
                  ? TextInputType.visiblePassword
                  : TextInputType.text
                  : widget.type,
              obscureText: widget.forPassword?!_obscured: _obscured,
              focusNode: textFieldFocusNode,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle:GoogleFonts.dmSans(
                    textStyle:  TextStyle(
                        fontSize: 10.0.sp,
                        color: AppColor.greyTitleColor,
                        fontWeight: FontWeight.w500)),
                contentPadding: widget.forPassword
                    ? const EdgeInsets.symmetric(vertical: 10, horizontal: 0)
                    :widget.isDropDown
                    ? const EdgeInsets.symmetric(vertical: 10, horizontal: 0)
                    : const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                isDense: true,
                suffixIcon: widget.forPassword
                    ? GestureDetector(
                  onTap: _toggleObscured,
                  child: Icon(
                    !_obscured ? Iconsax.eye_slash : Iconsax.eye,
                    size: 20,
                    weight: 20,
                    color:  AppColor.primary,
                  ),
                ) : widget.isDropDown?
                Icon(Icons.keyboard_arrow_down_rounded,
                  size: 50,
                  weight: 50,
                  color:  AppColor.primary,)
                    : widget.isEdit?
                Padding(
                  padding: const EdgeInsets.only(top: 16,right: 8),
                  child: Text(widget.edit,
                      style: GoogleFonts.dmSans(
                          textStyle:  const TextStyle(
                              fontSize: 11.00,
                              color: Colors.red,
                              fontWeight: FontWeight.w500))),
                ):
                null,
              ),
              onChanged: (value) => widget.onchange!(value),
              style: GoogleFonts.dmSans(
                  textStyle:  TextStyle(
                      fontSize: 14.00,
                      color: AppColor.greyTitleColor,
                      fontWeight: FontWeight.w500)),
              validator: widget.validator,
            ),
          ),
        ],
      ),
    );
  }
}
