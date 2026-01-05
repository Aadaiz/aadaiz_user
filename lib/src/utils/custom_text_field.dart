import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/app_components/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool enabled;
  final double? width;
  final TextInputType keyboardType; // ✅ added

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.controller,
    this.enabled = true,
    this.width,
    this.keyboardType = TextInputType.text, // ✅ default
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  bool _hasText = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _hasText = _controller.text.isNotEmpty;
    _controller.addListener(() {
      setState(() {
        _hasText = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
      },
      child: Container(
        width: widget.width?? Get.width,
       // margin: EdgeInsets.fromLTRB(12, 2, 12, 2),
        padding: EdgeInsets.fromLTRB(2, 13, 2, 0),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color:
                _isFocused && _hasText
                    ? AppColor.primary
                    : AppColors.whiteColor,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.blackColor.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextField(
          keyboardType: widget.keyboardType,
          enabled: widget.enabled,
          controller: _controller,
          decoration: InputDecoration(

            label: Text(widget.hintText, style: TextStyle(color: Colors.grey)),
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(1.0)),
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
            ),
            disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
            ),
          ),
        ),
      ),
    );
  }
}
