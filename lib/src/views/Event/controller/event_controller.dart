import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:aadaiz_customer_crm/src/services/api_service.dart';
import 'package:aadaiz_customer_crm/src/views/Event/model/event_model.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/Event/repository/event_repository.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/app_components/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EventController extends GetxController {
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController eventDescriptionController =
      TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final EventRepository _repository = EventRepository();
  final ImagePicker _picker = ImagePicker();
  Rx<TimeOfDay?> fromTime = Rx<TimeOfDay?>(null);
  Rx<TimeOfDay?> toTime = Rx<TimeOfDay?>(null);
  Rx<DateTime?> fromDate = Rx<DateTime?>(null);
  Rx<DateTime?> toDate = Rx<DateTime?>(null);
  RxList<dynamic> selectedLocations = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getEventData(true);
    getCities();
  }

  Future<void> showDialogImage(context, {required int picture}) {
    return showDialog(
      context: context,
      builder: (context) {
        var sel = 0;
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: 95.0.wp,
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Please Choose',
                          style: GoogleFonts.dmSans(
                            fontSize: 14.0.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.cancel,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.0.hp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              sel = 1;
                              openCamera(camera: false, picture: picture);
                            });
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.image,
                                size: 50,
                                color:
                                    sel == 1
                                        ? AppColors.projectcolor
                                        : Colors.grey,
                              ),
                              SizedBox(height: 1.0.hp),
                              Text(
                                'Gallery',
                                style: GoogleFonts.dmSans(
                                  fontSize: 11.0.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              sel = 2;
                              openCamera(camera: true, picture: picture);
                            });
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.camera_alt_rounded,
                                size: 50,
                                color:
                                    sel == 2
                                        ? AppColors.projectcolor
                                        : Colors.grey,
                              ),
                              SizedBox(height: 1.0.hp),
                              Text(
                                'Camera',
                                style: GoogleFonts.dmSans(
                                  fontSize: 11.0.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.0.hp),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  var cityLoading = false.obs;
  var cityData = [].obs;

  Future<void> getCities() async {
    try {
      cityLoading.value = true;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final res = await _repository.getCities(token!);
      if (res['status'] == true) {
        cityData.value = res['data'];
      } else {
        CommonToast.show(msg: res['message']);
      }
    } catch (e) {
    } finally {
      cityLoading.value = false;
    }
  }

  Rx<File?> image1 = Rx<File?>(null);
  Future<void> openCamera({required bool camera, required int picture}) async {
    Get.back();

    final pickedFile = await _picker.pickImage(
      source: camera ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 1000,
      maxHeight: 1000,
    );

    if (pickedFile == null) return;

    final File file = File(pickedFile.path);

    image1.value = file;
  }

  var createEventLoading = false.obs;
  Future<void> createEvent(bool? isEdit, dynamic id) async {
    try {
      createEventLoading.value = true;

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      final startDate = DateFormat(
        'MMM dd, yyyy',
      ).parse(startDateController.text);

      final endDate = DateFormat('MMM dd, yyyy').parse(endDateController.text);

      final startTime = DateFormat('hh:mm a').parse(startTimeController.text);

      final endTime = DateFormat('hh:mm a').parse(endTimeController.text);

      final uri = Uri.parse(
        isEdit == true ? "${Api.updateEvent}/$id" : Api.createEvent,
      );

      final request = http.MultipartRequest('POST', uri);

      request.fields['token'] = token ?? '';

      request.fields['event_name'] = eventNameController.text;
      request.fields['about_event'] = eventDescriptionController.text;
      request.fields['start_date'] = DateFormat('yyyy-MM-dd').format(startDate);
      request.fields['end_date'] = DateFormat('yyyy-MM-dd').format(endDate);
      request.fields['start_time'] = DateFormat('HH:mm').format(startTime);
      request.fields['end_time'] = DateFormat('HH:mm').format(endTime);
      request.fields['event_email'] = emailController.text;
      request.fields['event_mobile_number'] = mobileController.text;
      request.fields['event_country'] = countryController.text;
      request.fields['event_state'] = stateController.text;
      request.fields['event_city'] = cityController.text;
      request.fields['event_area'] = areaController.text;
      request.fields['event_pincode'] = pincodeController.text;

      if (image1.value != null) {
        request.files.add(
          await http.MultipartFile.fromPath('event_image', image1.value!.path),
        );
      }

      final response = await request.send();
      final responseData = await http.Response.fromStream(response);

      final res = jsonDecode(responseData.body);

      if (res['status'] == true) {
        CommonToast.show(msg: res['message']);
        featureSelected.value = false;
        Get.back();
        await getEventData(true);
        clearAllFields();
      } else {
        CommonToast.show(msg: res['message']);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      createEventLoading.value = false;
    }
  }

  var featureSelected = true.obs;
  var getEventDataLoading = false.obs;
  var currentPage = 1.obs;
  var lastPage = 1.obs;
  RefreshController refreshController = RefreshController();
  var eventData = <Datum>[].obs;
  Future<void> getEventData(
    bool? isRefresh, {
    String? startDate,
    String? endDate,
    String? location,
    String? search,
  }) async {
    try {
      if (isRefresh == true) {
        currentPage.value = 1;
        refreshController.resetNoData();
      }

      if (currentPage.value == 1 && isRefresh != true) {
        getEventDataLoading.value = true;
      }

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? t = prefs.getString('token');

      final EventRes res = await _repository.getEventData(
        t!,
        currentPage.value,
        startDate: startDate,
        endDate: endDate,
        location: location,
        search: search,
      );

      if (res.status == true && res.data != null) {
        final eventList =
            featureSelected.value
                ? res.data!.event?.data ?? []
                : res.data!.yourEvent?.data ?? [];

        final totalLastPage =
            featureSelected.value
                ? res.data!.event?.lastPage ?? 1
                : res.data!.yourEvent?.lastPage ?? 1;

        if (currentPage.value == 1) {
          eventData.assignAll(eventList);
        } else {
          eventData.addAll(eventList);
        }

        lastPage.value = totalLastPage;

        if (currentPage.value >= lastPage.value) {
          refreshController.loadNoData();
        } else {
          currentPage.value++;
          refreshController.loadComplete();
        }
      } else {
        CommonToast.show(msg: res.message ?? "Something went wrong");
        refreshController.loadFailed();
      }
    } catch (e) {
      refreshController.loadFailed();
    } finally {
      if (isRefresh != true) {
        getEventDataLoading.value = false;
      }
      refreshController.refreshCompleted();
    }
  }

  var eventDeleteLoading = false.obs;
  Future<void> deleteEvent(dynamic id) async {
    try {
      eventDeleteLoading.value = true;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final res = await _repository.deleteEvent(token!, id);
      if (res['status'] == true) {
        CommonToast.show(msg: res['message']);
        await getEventData(false);
      } else {
        CommonToast.show(msg: res['message']);
      }
    } catch (e) {
    } finally {
      eventDeleteLoading.value = false;
    }
  }

  void clearAllFields() {
    eventNameController.clear();
    eventDescriptionController.clear();
    startDateController.clear();
    startTimeController.clear();
    endDateController.clear();
    endTimeController.clear();
    locationController.clear();
    emailController.clear();
    mobileController.clear();
    countryController.clear();
    stateController.clear();
    cityController.clear();
    areaController.clear();
    pincodeController.clear();
    image1.value = null;
  }
}
