import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:aadaiz_customer_crm/src/views/post/model/post_model.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/services/api_service.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/app_components/app_colors.dart';
import 'package:aadaiz_customer_crm/src/views/post/model/post_my_profile.dart' as profile;
import 'package:aadaiz_customer_crm/src/views/post/repository/post_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostController extends GetxController {
  TextEditingController captionController = TextEditingController();
  var createPostLoading = false.obs;
  Rx<File?> postImagFile = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();
  RxString postImagFileName = ''.obs;
  PostRepository repo = PostRepository();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPostListData(true);
    getProfilePosts(true);
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
                              openCamera(
                                camera: false,
                                picture: picture,
                                context: context,
                              );
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
                              openCamera(
                                camera: true,
                                picture: picture,
                                context: context,
                              );
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

  Future<void> openCamera({
    required bool camera,
    required int picture,
    required BuildContext context,
  }) async {
    Get.back();

    final pickedFile = await _picker.pickImage(
      source: camera ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 1000,
      maxHeight: 1000,
    );

    if (pickedFile == null) return;

    final File file = File(pickedFile.path);

    final croppedFile = await AppImageCropper.cropImage(file, context);

    if (croppedFile == null) return;

    postImagFile.value = File(croppedFile.path);
  }

  Future<void> createPost() async {
    try {
      createPostLoading.value = true;

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      final uri = Uri.parse(Api.createPost);

      final request = http.MultipartRequest('POST', uri);

      request.fields['token'] = token ?? '';

      request.fields['caption'] = captionController.text;

      if (postImagFile.value != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'post_image',
            postImagFile.value!.path,
          ),
        );
      }

      final response = await request.send();
      final responseData = await http.Response.fromStream(response);

      final res = jsonDecode(responseData.body);

      if (res['status'] == true) {
        createPostLoading.value = false;
        Get.back();
        CommonToast.show(msg: res['message']);
        captionController.clear();
        postImagFile.value = null;

        Get.back();
      } else {
        log(res.toString());
      }
    } catch (e) {
      CommonToast.show(msg: e.toString());
      log(e.toString());
    } finally {
      createPostLoading.value = false;
    }
  }

  var postListLoading = false.obs;
  var currentPage = 1.obs;
  var lastPage = 1.obs;
  var postList = <Datum>[].obs;
  RefreshController refreshController = RefreshController();
  Future<void> getPostListData(bool isRefresh) async {
    try {
      if (isRefresh) {
        currentPage.value = 1;

        refreshController.resetNoData();
      }

      if (currentPage.value == 1) {
        postListLoading.value = true;
      }

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final res = await repo.getPostList(token ?? '', currentPage.value);

      if (res.status == true) {
        final newList = res.data?.data ?? [];

        lastPage.value = res.data?.lastPage ?? 1;

        if (currentPage.value == 1) {
          postList.value = newList;
        } else {
          postList.addAll(newList);
        }

        if (isRefresh) {
          refreshController.refreshCompleted();
        }

        if (currentPage.value >= lastPage.value) {
          refreshController.loadNoData();
        } else {
          currentPage.value++;
          refreshController.loadComplete();
        }
      } else {
        CommonToast.show(msg: res.message ?? "");

        if (isRefresh) {
          refreshController.refreshFailed();
        } else {
          refreshController.loadFailed();
        }
      }
    } catch (e) {
      if (isRefresh) {
        refreshController.refreshFailed();
      } else {
        refreshController.loadFailed();
      }
    } finally {
      postListLoading.value = false;
    }
  }

  var likeStatus = false.obs;
  Future<void> likePost(Datum post) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final res = await repo.likePost(token ?? '', post.id);

      if (res.status == true) {
        post.isLiked = !(post.isLiked ?? false);

        if (post.isLiked == true) {
          post.likesCount = (post.likesCount ?? 0) + 1;
        } else {
          post.likesCount = (post.likesCount ?? 0) - 1;
        }

        postList.refresh();
      }
    } catch (e) {}
  }

  TextEditingController commentController = TextEditingController();
  var addCommentLoading = false.obs;
  Future<void> addComment(Datum post) async {
    try {
      addCommentLoading.value = true;

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      final Map<String, dynamic> data = {
        'token': token,
        'comment': commentController.text,
      };

      final res = await repo.addComment(post.id, jsonEncode(data));

      if (res['status'] == true) {
        final newComment = PostComment.fromMap(res['data']['comment']);

        post.postComment ??= [];
        post.postComment!.insert(0, newComment);

        post.commentsCount = (post.commentsCount ?? 0) + 1;

        postList.refresh();

        commentController.clear();
      }
    } catch (e) {
    } finally {
      addCommentLoading.value = false;
    }
  }
  var profilePostList = <profile.PostsDatum>[].obs;

  var profileCurrentPage = 1.obs;
  var profileLastPage = 1.obs;

  var profilePostLoading = false.obs;
  var myProfileData = Rxn<profile.MyPostProfile>();
  RefreshController profileRefreshController = RefreshController();
  Future<void> getProfilePosts(bool isRefresh) async {
    try {
      if (isRefresh) {
        profileCurrentPage.value = 1;
        profileRefreshController.resetNoData();
      }

      if (profileCurrentPage.value == 1) {
        profilePostLoading.value = true;
      }

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final res = await repo.getMyProfile(token ?? '');

      if (res.status == true) {


        myProfileData.value = res;

        final newList = res.data?.posts?.data ?? [];

        profileLastPage.value = res.data?.posts?.lastPage ?? 1;

        if (profileCurrentPage.value == 1) {
          profilePostList.value = newList;
        } else {
          profilePostList.addAll(newList);
        }

        if (isRefresh) {
          profileRefreshController.refreshCompleted();
        }

        if (profileCurrentPage.value >= profileLastPage.value) {
          profileRefreshController.loadNoData();
        } else {
          profileCurrentPage.value++;
          profileRefreshController.loadComplete();
        }
      } else {
        profileRefreshController.loadFailed();
      }
    } catch (e) {
      profileRefreshController.loadFailed();
    } finally {
      profilePostLoading.value = false;
    }
  }
}

class AppImageCropper {
  static Future<CroppedFile?> cropImage(
    File imageFile,
    BuildContext context, {
    bool hideBottomControls = false,
  }) async {
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Aadaiz Image Cropper',
          toolbarColor: AppColors.blackColor,
          toolbarWidgetColor: AppColors.whiteColor,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPresetCustom(),
          ],
          hideBottomControls: hideBottomControls,
        ),
        IOSUiSettings(
          title: 'Aadaiz Image Cropper',
          aspectRatioPresets: [CropAspectRatioPreset.square],
        ),
        WebUiSettings(context: context),
      ],
    );
    return croppedFile;
  }
}

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3);

  @override
  String get name => '2x3 (customized)';
}
