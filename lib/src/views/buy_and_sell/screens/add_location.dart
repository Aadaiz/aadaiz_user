import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/controller/buyAndSellController.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {

  BuyAndSellController controller = Get.find<BuyAndSellController>();

  bool _validateFields() {
    if (controller.country.text.isEmpty) {
      CommonToast.show(msg: "Please enter Country Name");
      return false;
    }
    if (controller.st.text.isEmpty) {
      CommonToast.show(msg: "Please enter street");
      return false;
    }
    if (controller.pin.text.isEmpty) {
      CommonToast.show(msg: "Please enter pin");
      return false;
    }
    if (controller.city.text.isEmpty) {
      CommonToast.show(msg: "Please enter city");
      return false;
    }
    if (controller.land.text.isEmpty) {
      CommonToast.show(msg: "Please enter landmark");
      return false;
    }
    return true;
  }



  @override
  Widget build(BuildContext context) {
    final screenHeight = Utils.getActivityScreenHeight(context);
    final screenWidth = Utils.getActivityScreenWidth(context);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: PreferredSize(
        preferredSize: Size(100, 6.0.hp),
        child: CommonAppBar(
          leadingclick: () {
            Get.back();
          },
          title: 'Address',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
        child: SingleChildScrollView(
          child: Column(

            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  width: screenWidth * 0.8,
                  child: Column(

                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: controller.country,
                        decoration: InputDecoration(
                          labelText: 'country',
                          labelStyle: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),

                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16), TextFormField(
                        controller: controller.state,
                        decoration: InputDecoration(
                          labelText: 'state',
                          labelStyle: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),

                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),


                      TextFormField(
                        controller: controller.city,
                        decoration: InputDecoration(
                          labelText: 'City',
                          labelStyle: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),

                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: controller.st,
                        decoration: InputDecoration(
                          labelText: 'Street, Area',
                          labelStyle: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        maxLength: 6,
                        keyboardType: TextInputType.phone,
                        controller: controller.pin,
                        decoration: InputDecoration(
                          labelText: 'Pincode',
                          labelStyle: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                            fontSize: 16,
                          ),

                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),

                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.5),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      const SizedBox(height: 16),

                    ],
                  ),
                ),
              ),
             
          

            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(color: AppColor.white, child: InkWell(
        onTap: () {
          if (_validateFields()) {
            Get.back();
          }
        },
        child: CommonButton(
          borderRadius: 0.0,
          press: () {
            Get.back();
          },
          text: 'Next',
          width: screenWidth * 0.9,
          height: screenHeight * 0.055,
        ),
      ) ,),
    );
  }
}
