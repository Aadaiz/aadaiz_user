import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_textfiled_two.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/Event/controller/event_controller.dart';
import 'package:aadaiz_customer_crm/src/views/Event/model/event_model.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/app_components/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_state_city/country_state_city.dart' as csc;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CreateEventScreen extends StatefulWidget {
  final bool isEdit;
  final Datum? data;
  const CreateEventScreen({super.key, this.isEdit = false, this.data});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  EventController controller = Get.find<EventController>();
  DateTime? fromDate;
  DateTime? toDate;
  String? fileName;
  String countryCode = '';
  List<csc.Country> countries = [];
  List<csc.State> states = [];
  List<csc.City> cities = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () async {
      countries = await csc.getAllCountries();
    });

    if (widget.isEdit == true) {
      controller.eventNameController.text = widget.data!.eventName ?? '';
      controller.eventDescriptionController.text =
          widget.data!.aboutEvent ?? '';
      controller.startDateController.text =
          widget.data!.startDate != null
              ? DateFormat('MMM dd, yyyy').format(widget.data!.startDate!)
              : '';
      controller.endDateController.text =
          widget.data!.endDate != null
              ? DateFormat('MMM dd, yyyy').format(widget.data!.endDate!)
              : '';
      controller.startTimeController.text =
          widget.data!.startTime != null
              ? DateFormat(
                'hh:mm a',
              ).format(DateFormat('HH:mm:ss').parse(widget.data!.startTime!))
              : '';

      controller.endTimeController.text =
          widget.data!.endTime != null
              ? DateFormat(
                'hh:mm a',
              ).format(DateFormat('HH:mm:ss').parse(widget.data!.endTime!))
              : '';

      controller.countryController.text = widget.data!.eventCountry ?? '';
      controller.stateController.text = widget.data!.eventState ?? '';
      controller.cityController.text = widget.data!.eventCity ?? '';
      controller.areaController.text = widget.data!.eventArea ?? '';
      controller.pincodeController.text = widget.data!.eventPincode ?? '';
      controller.emailController.text = widget.data!.eventEmail ?? '';
      controller.mobileController.text = widget.data!.eventMobileNumber ?? '';
      // controller.image1.value = widget.data!.eventImage;
    } else {
      controller.clearAllFields();
    }

  }



  @override
  Widget build(BuildContext context) {
    final screenWidth = Utils.getActivityScreenWidth(context);
    final screenHeight = Utils.getActivityScreenHeight(context);


    return Scaffold(
      backgroundColor: Colors.white,

      appBar: PreferredSize(
        preferredSize: Size(100, 6.0.hp),
        child: CommonAppBar(
          leadingclick: () => Get.back(),
          title: "Create Event",
        ),
      ),

      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextFieldTwo(
                labelName: "Event Name",
                hintName: "Enter Event Name",
                controller: controller.eventNameController,
              ),

              SizedBox(height: screenHeight * 0.01),
              CommonTextFieldTwo(
                labelName: "Event Description",
                hintName: "Enter Event Description",
                controller: controller.eventDescriptionController,
                maxLines: 4,
              ),

              SizedBox(height: screenHeight * 0.026),

              Text(
                "Start",
                style: GoogleFonts.dmSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: CommonTextFieldTwo(
                      hintName: "Friday, 25 May 2024",
                      controller: controller.startDateController,
                      readOnly: true,
                      suffixIcon: const Icon(Icons.calendar_today, size: 18),
                      onTap: () {
                        _pickFromDate();
                      },
                    ),
                  ),

                  SizedBox(width: screenWidth * 0.03),

                  Expanded(
                    child: CommonTextFieldTwo(
                      hintName: "02:00 PM",
                      controller: controller.startTimeController,
                      readOnly: true,
                      suffixIcon: const Icon(Icons.access_time, size: 18),
                      onTap: () {
                        _pickFromTime(context);
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.022),

              Text(
                "End",
                style: GoogleFonts.dmSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: CommonTextFieldTwo(
                      hintName: "Friday, 25 May 2024",
                      controller: controller.endDateController,
                      readOnly: true,
                      suffixIcon: const Icon(Icons.calendar_today, size: 18),
                      onTap: () {
                        _pickToDate();
                      },
                    ),
                  ),

                  SizedBox(width: screenWidth * 0.03),

                  Expanded(
                    child: CommonTextFieldTwo(
                      hintName: "02:00 PM",
                      controller: controller.endTimeController,
                      readOnly: true,
                      suffixIcon: const Icon(Icons.access_time, size: 18),
                      onTap: () {
                        _pickToTime(context);
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.02),

              Text(
                'Event Location',
                style: GoogleFonts.dmSans(
                  color: AppColors.blackColor,
                  fontSize: 13.0.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              CommonTextFieldTwo(
                readOnly: true,
                hintName: "Choose Country",
                controller: controller.countryController,
                keyboardType: TextInputType.emailAddress,
                suffixIcon: const Icon(Icons.location_on),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: AppColor.white,

                        insetPadding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 16,
                        child: SizedBox(
                          height: Get.width * 0.85,
                          width: Get.width * 0.6,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Text(
                                  'Country',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      color: AppColor.greyTitleColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const Gap(16),
                                SizedBox(
                                  height: Get.width * 0.68,
                                  child: countries.isEmpty
                                      ? const Text('No countries found')
                                      : Expanded(
                                        child: ListView.separated(
                                          itemCount: countries.length,
                                          separatorBuilder: (context, index) => const Divider(),
                                          itemBuilder: (context, index) {
                                            final data = countries[index];

                                            return InkWell(
                                              onTap: () async {
                                                Get.back();
                                                controller.countryController.text = data.name ?? '';
                                                countryCode = data.isoCode;

                                                states.clear();
                                                cities.clear();
                                                controller.stateController.clear();
                                                controller.cityController.clear();

                                                states = await csc.getStatesOfCountry(data.isoCode);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 16, bottom: 8),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        data.name,
                                                        style: GoogleFonts.poppins(
                                                          fontSize: 16,
                                                          color: AppColor.black,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: screenHeight * 0.01),
              CommonTextFieldTwo(
                readOnly: true,
                hintName: "Choose State",
                controller: controller.stateController,
                keyboardType: TextInputType.emailAddress,
                suffixIcon: const Icon(Icons.location_on),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: AppColor.white,

                        insetPadding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 16,
                        child: SizedBox(
                          height: Get.width * 0.85,
                          width: Get.width * 0.6,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Text(
                                  'States',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      color: AppColor.greyTitleColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const Gap(16),
                                SizedBox(
                                  height: Get.width * 0.68,
                                  child:
                                      states.isEmpty
                                          ? const Text('No cities found')
                                          : ListView.separated(
                                            separatorBuilder:
                                                (context, index) =>
                                                    const Divider(),
                                            shrinkWrap: true,
                                            physics:
                                                const AlwaysScrollableScrollPhysics(),
                                            itemCount: states.length,
                                            itemBuilder: (context, index) {
                                              final data = states[index];

                                              return InkWell(
                                                onTap: () async {
                                                  debugPrint(
                                                    'State code :${data.isoCode}',
                                                  );
                                                  Get.back();
                                                  controller
                                                      .stateController
                                                      .text = data.name ?? '';
                                                  cities.clear();
                                                  controller.cityController
                                                      .clear();

                                                  cities = await csc
                                                      .getStateCities(
                                                        countryCode,
                                                        data.isoCode,
                                                      );
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        left: 16,
                                                        bottom: 8,
                                                      ),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          data.name,
                                                          style: GoogleFonts.poppins(
                                                            textStyle: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  AppColor
                                                                      .black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: screenHeight * 0.01),
              CommonTextFieldTwo(
                hintName: "Choose City",
                controller: controller.cityController,
                keyboardType: TextInputType.emailAddress,
                suffixIcon: const Icon(Icons.location_on),
                readOnly: true,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: AppColor.white,

                        insetPadding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 16,
                        child: SizedBox(
                          height: Get.width * 0.85,
                          width: Get.width * 0.6,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Text(
                                  'States',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      color: AppColor.greyTitleColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const Gap(16),
                                SizedBox(
                                  height: Get.width * 0.68,
                                  child:
                                      cities.isEmpty
                                          ? const Text('No cities found')
                                          : ListView.separated(
                                            separatorBuilder:
                                                (context, index) =>
                                                    const Divider(),
                                            shrinkWrap: true,
                                            physics:
                                                const AlwaysScrollableScrollPhysics(),
                                            itemCount: cities.length,
                                            itemBuilder: (context, index) {
                                              final data = cities[index];
                                              return InkWell(
                                                onTap: () async {
                                                  Get.back();
                                                  controller
                                                      .cityController
                                                      .text = data.name ?? '';
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        left: 16,
                                                        bottom: 8,
                                                      ),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          data.name,
                                                          style: GoogleFonts.poppins(
                                                            textStyle: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  AppColor
                                                                      .black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: screenHeight * 0.02),

              CommonTextFieldTwo(
                hintName: "Enter Area",
                controller: controller.areaController,
              ),
              SizedBox(height: screenHeight * 0.02),

              CommonTextFieldTwo(
                hintName: "Enter Pincode ",
                controller: controller.pincodeController,
                keyboardType: TextInputType.number,
                maxLength: 6,
              ),
              SizedBox(height: screenHeight * 0.02),

              CommonTextFieldTwo(
                labelName: "Email address",
                hintName: "Your email",
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              SizedBox(height: screenHeight * 0.02),

              CommonTextFieldTwo(
                labelName: "Mobile Number",
                hintName: "Your Mobile Number",
                controller: controller.mobileController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
              ),

              SizedBox(height: screenHeight * 0.025),

              Text(
                "Upload Attachment ( Event Place )",
                style: GoogleFonts.dmSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: screenHeight * 0.01),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        FocusManager.instance.primaryFocus?.unfocus();

                        await Future.delayed(const Duration(milliseconds: 100));

                        await controller.showDialogImage(context, picture: 1);

                        if (controller.image1.value != null) {
                          setState(() {
                            fileName =
                                controller.image1.value!.path.split('/').last;
                          });
                        }
                      },
                      child: Container(
                        width: screenWidth * 0.3,
                        height: screenHeight * 0.03,

                        decoration: BoxDecoration(
                          color: AppColor.backGroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          widget.isEdit ? 'Change File' : "Select File",
                          style: TextStyle(
                            color: AppColor.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),

                    Obx(() {
                      return (controller.image1.value == null && widget.isEdit)
                          ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              height: screenHeight * 0.2,
                              width: screenWidth,
                              fit: BoxFit.cover,
                              errorWidget:
                                  (context, url, error) => Container(
                                    width: screenWidth,
                                    color: Colors.black,
                                  ),
                              progressIndicatorBuilder:
                                  (context, url, progress) => Container(
                                    height: screenHeight * 0.2,
                                    color: Colors.black,
                                    width: screenWidth,
                                    child: Center(
                                      child: Transform.scale(
                                        scale: 0.5,
                                        child: CircularProgressIndicator(
                                          color: Colors.grey,
                                          strokeWidth: 2,
                                          value: progress.progress,
                                        ),
                                      ),
                                    ),
                                  ),
                              imageUrl: widget.data!.eventImage.toString(),
                            ),
                          )
                          : const SizedBox.shrink();
                    }),

                    if (controller.image1.value != null)
                      Divider(color: Colors.grey.withAlpha(76)),
                    Obx(() {
                      if (controller.image1.value == null) {
                        return const SizedBox();
                      }

                      final name =
                          controller.image1.value!.path.split('/').last;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.check,
                                color: Colors.red,
                                size: 18,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                name,
                                style: GoogleFonts.dmSans(fontSize: 12.sp),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              controller.image1.value = null;
                            },
                            icon: Icon(Icons.delete_sharp, color: AppColor.red),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.04),

              Obx(
                () => CommonButton(
                  loading: controller.createEventLoading.value,
                  press: () {
                    validateFields();
                  },
                  text: widget.isEdit ? 'Update Event' : 'Create Event',
                  borderRadius: 0.0,
                  height: screenHeight * 0.045,
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
            ],
          ),
        ),
      ),
    );
  }

  void validateFields() {
    if (controller.eventNameController.text.isEmpty) {
      CommonToast.show(msg: 'Please enter event name');
    } else if (controller.eventDescriptionController.text.isEmpty) {
      CommonToast.show(msg: 'Please enter event description');
    } else if (controller.startDateController.text.isEmpty) {
      CommonToast.show(msg: 'Please select start date');
    } else if (controller.endDateController.text.isEmpty) {
      CommonToast.show(msg: 'Please select end date');
    } else if (controller.startTimeController.text.isEmpty) {
      CommonToast.show(msg: 'Please select start time');
    } else if (controller.endTimeController.text.isEmpty) {
      CommonToast.show(msg: 'Please select end time');
    } else if (controller.countryController.text.isEmpty) {
      CommonToast.show(msg: 'Please select country');
    } else if (controller.stateController.text.isEmpty) {
      CommonToast.show(msg: 'Please select state');
    } else if (controller.cityController.text.isEmpty) {
      CommonToast.show(msg: 'Please select city');
    } else if (controller.areaController.text.isEmpty) {
      CommonToast.show(msg: 'Please enter area');
    } else if (controller.pincodeController.text.isEmpty) {
      CommonToast.show(msg: 'Please enter pincode');
    } else if (controller.emailController.text.isEmpty) {
      CommonToast.show(msg: 'Please enter email');
    } else if (controller.mobileController.text.isEmpty) {
      CommonToast.show(msg: 'Please enter mobile number');
    } else if (controller.image1.value == null) {
      if (widget.isEdit == false) {
        CommonToast.show(msg: 'Please select attachment');
      } else {
        controller.createEvent(widget.isEdit, widget.data!.id);
      }
    } else {
      controller.createEvent(widget.isEdit, widget.data!.id);
    }
  }

  Future<void> _pickFromDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fromDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: AppColor.primary),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: AppColor.primary),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        fromDate = picked;
        controller.startDateController.text = DateFormat(
          'MMM dd, yyyy',
        ).format(fromDate!);

        if (toDate != null && toDate!.isBefore(picked)) {
          toDate = null;
        }
      });
    }
  }

  Future<void> _pickToDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: toDate ?? fromDate ?? DateTime.now(),
      firstDate: fromDate ?? DateTime.now(),
      lastDate: DateTime(2100),

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: AppColor.primary),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: AppColor.primary),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        toDate = picked;
        controller.endDateController.text = DateFormat(
          'MMM dd, yyyy',
        ).format(toDate!);
      });
    }
  }

  Future<void> _pickFromTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: controller.fromTime.value ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: AppColor.primary),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: AppColor.primary),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      controller.fromTime.value = picked;
      final now = DateTime.now();
      final formatted = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );
      controller.startTimeController.text = DateFormat(
        'hh:mm a',
      ).format(formatted);

      if (controller.toTime.value != null) {
        final toDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          controller.toTime.value!.hour,
          controller.toTime.value!.minute,
        );
        if (toDateTime.isBefore(formatted)) {
          controller.toTime.value = null;
          controller.endTimeController.clear();
        }
      }
    }
  }

  Future<void> _pickToTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime:
          controller.toTime.value ??
          controller.fromTime.value ??
          TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: AppColor.primary),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: AppColor.primary),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final now = DateTime.now();
      final selectedTo = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );

      controller.toTime.value = picked;
      controller.endTimeController.text = DateFormat(
        'hh:mm a',
      ).format(selectedTo);
    }
  }
}
