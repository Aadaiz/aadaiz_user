import 'dart:convert';
import 'dart:io';

import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/views/profile/model/support_list.dart';
import 'package:aadaiz_customer_crm/src/views/profile/model/support_list.dart'as support;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/colors.dart';
import '../model/profile_model.dart';

import '../model/profile_model.dart' as profile;
import '../repository/profile_repository.dart';
class ProfileController extends GetxController{
  static ProfileController get to => Get.put(ProfileController());
  var repo = ProfileRepository();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfile();
  }
  var profileLoading = false.obs;
  var profileData= profile.User().obs;
var UpdateprofileLoading=false.obs;
  getProfile() async {
    profileLoading(true);
    ProfileRes res = await repo.profile();
    if(res.status==true){
      profileLoading(false);
      profileData.value=res.user!;
      profileName.text = res.user!.username??'';
      mobile.text = res.user!.mobileNumber??'';
      email.text = res.user!.email??'';
    }else{
    }

  }

  Future<dynamic> updateProfile() async {
    UpdateprofileLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    try {
      // Check if there are selected images to upload
      if (selectedImages.isNotEmpty) {
        await uploadImage(); // Call uploadImage to upload images and set uploadImages.value
      }

      // Prepare the body for the profile update
      Map body = {
        'token': token,
        'username': profileName.text,
        'profile_image': uploadImages.value, // Use the uploaded image URL
      };
      print('Update Profile Body: $body'); // Debug log to verify body

      ProfileRes res = await repo.updateProfile(jsonEncode(body));
      if (res.status == true) {
        getProfile();







      } else {
        Get.snackbar('Error', 'Failed to update profile');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      rethrow;
    } finally {
      UpdateprofileLoading(false); // Reset loading state
    }
  }

  var addPostLoading=false.obs;
  var uploadImages = ''.obs;
  var selectedImages = <File>[];
  Future<dynamic> uploadImage() async {
    List upload = [];
    uploadImages.value = '';

    try {
      for (var i = 0; i < selectedImages.length; i++) {
        var response = await repo.uploadImage(image: selectedImages[i].path);
        if (response != null) {
          upload.add(response.url);
        }
      }
      uploadImages.value = upload.join(',');
      if (uploadImages.value.isEmpty) {
        Get.snackbar('Error', 'Failed to upload image');
      }
    } catch (e) {
      Get.snackbar('Error', 'Image upload failed: $e');
      rethrow;
    }
  }

  TextEditingController profileName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();

  var addSupportLoading=false.obs;
  addSupport(title,description)async{
    addSupportLoading(true);
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    Map body ={
      'title': title,
      'description': description,
      'attachment': '${uploadImages.value}',
      'token': token,
    };
    final res = await repo.addSupport(jsonEncode(body));
    addSupportLoading(false);
    CommonToast.show(msg: res['message']);
  }

  var supportListLoading=false.obs;
  var supportList=<support.Datum>[].obs;

  getSupportList() async{
    supportListLoading(true);
    SupportListRes res = await repo.supportLists();
    supportListLoading(false);
    if(res.success==true){
      supportList.value = res.data!;
    }else{
      supportList.clear();
    }

  }



  Future<void> showdialog(context,{dynamic profile}){
    return showDialog(
      context: context,
      builder: (context) {
        var sel = 0;
        return StatefulBuilder(
            builder: (context, setState){
              return Dialog(
                  insetPadding: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 16,
                  child: Container(
                    //  height: 32.00.hp,
                      width: 95.00.wp,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 01.00.hp,
                          ),
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      'Please Choose',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 14.00.sp,
                                              color:
                                              const Color(0xff171717),
                                              fontWeight:
                                              FontWeight.w600)),
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.0, top: 10, right: 0),
                                  child: Align(
                                      alignment: Alignment.topRight,
                                      child: Icon(Icons.cancel,size: 25,color: Colors.blueAccent,)),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 04.00.hp,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    sel =1;
                                    openCamera(camera: sel==1? false:true, profile: profile);
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                      left: 15,
                                      right: 15),
                                  decoration: BoxDecoration(
                                      border: Border.all(color:sel == 1
                                          ? AppColor.primary
                                          : Colors.white,),
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.image,
                                        size: 50,
                                        color:
                                        sel == 1 ? AppColor.primary : Colors.grey[800],
                                      ),
                                      SizedBox(
                                        height: 1.0.hp,
                                      ),
                                      Text(
                                        'Gallery',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 11.00.sp,
                                                color: sel == 1?AppColor.primary: const Color(
                                                    0xff171717),
                                                fontWeight:
                                                FontWeight.w500)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    sel=2;
                                    openCamera(camera: sel==1? false:true,profile: profile);
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                      left: 15,
                                      right: 15),
                                  decoration: BoxDecoration(
                                      border: Border.all(color:sel == 2
                                          ? AppColor.primary
                                          : Colors.white,),
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.camera_alt_rounded,
                                        size: 50,
                                        color:
                                        sel == 2 ? AppColor.primary : Colors.grey[800],
                                      ),
                                      SizedBox(
                                        height: 1.3.hp,
                                      ),
                                      Text(
                                        'Camera',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 11.00.sp,
                                                color: sel == 2?AppColor.primary: const Color(
                                                    0xff171717),
                                                fontWeight:
                                                FontWeight.w500)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 03.00.hp,
                          ),
                        ],
                      )));

            }     );
      },
    );
  }
  final ImagePicker _picker = ImagePicker();
  Rx<File> image = File('').obs;
  openCamera({dynamic camera, dynamic profile=true}) async {
    selectedImages=[];
    //refreshUpload=true;
    Get.back();
    //  refreshUpload = false;
    final pickedFile = await _picker.pickImage(
      source: camera ?  ImageSource.camera :ImageSource.gallery,
      maxWidth: 1000,
      maxHeight: 1000,
    );

    //  addPostLoad = true;
    // List<XFile> xfilePick = pickedFile;
    //  if (xfilePick.isNotEmpty) {
    //    for (var i = 0; i < xfilePick.length; i++) {
    if (pickedFile != null) {
      // refreshUpload = true;
        image(File(pickedFile.path));
        selectedImages.add(image.value);

    }
  }
}