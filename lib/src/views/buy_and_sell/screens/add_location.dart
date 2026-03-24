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
  bool _isLoading = false;
  bool _isLocationFetched = false;
  BuyAndSellController controller = Get.find<BuyAndSellController>();

  bool _validateFields() {
    if (controller.no.text.isEmpty) {
      CommonToast.show(msg: "Please enter House number");
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

  Future<void> _useCurrentLocation() async {
    setState(() {
      _isLoading = true;
      _isLocationFetched = false;
    });

    try {
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        CommonToast.show(msg: "Location services are disabled.");
        setState(() {
          _isLoading = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          CommonToast.show(msg: "Location permission denied.");
          setState(() {
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        CommonToast.show(msg: "Location permission permanently denied.");
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      controller.latitude.value = position.latitude;
      controller.longitude.value = position.longitude;

      final List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final Placemark placemark = placemarks.first;
        String? houseNumber;
        final RegExp regExp = RegExp(r'^(\d+)');
        Match? match = regExp.firstMatch(placemark.street ?? '');
        if (match != null) {
          houseNumber = match.group(1);
        } else {
          match = regExp.firstMatch(placemark.name ?? '');
          if (match != null) {
            houseNumber = match.group(1);
          }
        }

        controller.no.text = houseNumber ?? '';
        controller.st.text = placemark.subLocality ?? '';
        controller.pin.text = placemark.postalCode ?? '';
        controller.city.text = placemark.locality ?? '';
        controller.land.text = placemark.street ?? '';

        setState(() {
          _isLocationFetched = true;
        });
      } else {
        CommonToast.show(msg: "Unable to fetch address details.");
      }
    } catch (e) {
      CommonToast.show(msg: "Error fetching location: $e");
      print('error : ${e.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
                        controller: controller.no,
                        decoration: InputDecoration(
                          labelText: 'House No',
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
                      const SizedBox(height: 6),
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
                        controller: controller.land,
                        decoration: InputDecoration(
                          labelText: 'Landmark',
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
                      const Text(
                        "( Or )",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap:
                            _isLoading
                                ? null
                                : _useCurrentLocation,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.greyTitleColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _isLoading
                                  ? SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColor.black,
                                    ),
                                  )
                                  : const Icon(
                                    Icons.my_location,
                                    color: Colors.black,
                                  ),
                              const SizedBox(width: 8),
                              Row(
                                children: [
                                  Text(
                                    'Use My Current Location',
                                    style: GoogleFonts.dmSans(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.black,
                                    ),
                                  ),
                                  if (_isLocationFetched) ...[
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 24,
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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
          press: () {},
          text: 'Next',
          width: screenWidth * 0.9,
          height: screenHeight * 0.055,
        ),
      ) ,),
    );
  }
}
