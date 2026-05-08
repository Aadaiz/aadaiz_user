import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/book_designer.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/controller/consulting_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Contact extends StatefulWidget {
  final dynamic designerId;
  final String date;
  final dynamic slotId;

  const Contact({
    super.key,
    required this.designerId,
    required this.date,
    required this.slotId,
  });

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final controller = ConsultingController.to;

  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _areaController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _landmarkController = TextEditingController();
  final _pincodeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _areaController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _landmarkController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  Future<void> _onContinue() async {
    final bookRes = await controller.bookAppointment(
      designerId: widget.designerId,
      date: widget.date,
      slotId: widget.slotId,
      isOnline: false,
      contactName: _nameController.text.trim(),
      contactMobile: _mobileController.text.trim(),
      area: _areaController.text.trim(),
      city: _cityController.text.trim(),
      state: _stateController.text.trim(),
      landmark: _landmarkController.text.trim(),
      pincode: _pincodeController.text.trim(),
    );

    if (bookRes == null || bookRes['status'] != true) {
      Get.snackbar(
        'Error',
        bookRes?['message'] ?? 'Booking failed',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final dynamic bookingId = bookRes['data']?['id'];
    final int amount = ((bookRes['data']?['consultation_fee'] ??
        bookRes['data']?['amount'] ??
        bookRes['data']?['total'] ??
        314) as num)
        .toInt();

    Get.to(
          () => BookDesigner(
        designerId: widget.designerId,
        date: widget.date,
        slotId: widget.slotId,
        isOnline: false,
        bookingId: bookingId,
        amount: amount,
        contactName: _nameController.text.trim(),
        contactMobile: _mobileController.text.trim(),
        area: _areaController.text.trim(),
        city: _cityController.text.trim(),
        state: _stateController.text.trim(),
        landmark: _landmarkController.text.trim(),
        pincode: _pincodeController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    InputDecoration fieldDecoration(String label, String hint) =>
        InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.dmSans(
            fontWeight: FontWeight.w400,
            fontSize: 12.00.sp,
            color: AppColor.textFieldLabelColor,
          ),
          isDense: true,
          hintText: hint,
          hintStyle: GoogleFonts.dmSans(
            color: AppColor.black.withOpacity(0.5),
            fontSize: 10.00.sp,
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.underlineBorderColor),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.underlineBorderColor),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.underlineBorderColor),
          ),
        );

    TextStyle inputStyle() => GoogleFonts.dmSans(
      fontWeight: FontWeight.w400,
      fontSize: 12.00.sp,
      color: AppColor.black,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.016),
          child: Image.asset('assets/images/back.png'),
        ),
        elevation: 2,
        shadowColor: AppColor.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.022,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Info',
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.00.sp,
                        color: AppColor.black,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      style: inputStyle(),
                      decoration: fieldDecoration('Name', 'Name'),
                    ),
                    SizedBox(height: screenHeight * 0.022),
                    TextFormField(
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      style: inputStyle(),
                      decoration: fieldDecoration(
                          'Mobile Number', 'Mobile Number (+91)'),
                    ),
                  ],
                ),
              ),
              Container(
                color: AppColor.textFieldDividerColor,
                width: double.infinity,
                height: screenHeight * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.022,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address Info',
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.00.sp,
                        color: AppColor.black,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextFormField(
                      controller: _areaController,
                      textInputAction: TextInputAction.next,
                      style: inputStyle(),
                      decoration: fieldDecoration('Area', 'Area'),
                    ),
                    SizedBox(height: screenHeight * 0.022),
                    TextFormField(
                      controller: _cityController,
                      textInputAction: TextInputAction.next,
                      style: inputStyle(),
                      decoration: fieldDecoration('City', 'City'),
                    ),
                    SizedBox(height: screenHeight * 0.022),
                    TextFormField(
                      controller: _stateController,
                      textInputAction: TextInputAction.next,
                      style: inputStyle(),
                      decoration: fieldDecoration('State', 'State'),
                    ),
                    SizedBox(height: screenHeight * 0.022),
                    TextFormField(
                      controller: _landmarkController,
                      textInputAction: TextInputAction.next,
                      style: inputStyle(),
                      decoration: fieldDecoration('Landmark', 'Landmark'),
                    ),
                    SizedBox(height: screenHeight * 0.022),
                    TextFormField(
                      controller: _pincodeController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      style: inputStyle(),
                      decoration: fieldDecoration('Pincode', 'Pincode'),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    Obx(
                          () => SizedBox(
                        width: double.infinity,
                        height: screenHeight * 0.055,
                        child: ElevatedButton(
                          onPressed: controller.bookingLoading.value
                              ? null
                              : _onContinue,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: controller.bookingLoading.value
                              ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                              : Text(
                            'Continue',
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}