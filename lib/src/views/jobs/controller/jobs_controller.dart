import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:aadaiz_customer_crm/src/services/api_service.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/model/job_filter_list_model.dart'
    as filter;
import 'package:aadaiz_customer_crm/src/views/jobs/model/job_list_data_model.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/model/job_list_type_model.dart'
    as type;
import 'package:aadaiz_customer_crm/src/views/jobs/repository/job_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';

class JobsController extends GetxController {
  var featureSelected = true.obs;
  final JobRepository repo = JobRepository();
  var communicationPref = false.obs;
  Rx<TimeOfDay?> fromTime = Rx<TimeOfDay?>(null);
  Rx<TimeOfDay?> toTime = Rx<TimeOfDay?>(null);
  Rx<TimeOfDay?> contactFromTime = Rx<TimeOfDay?>(null);
  Rx<TimeOfDay?> contactToTime = Rx<TimeOfDay?>(null);
  RxList<String> genders = ["Any", "Male", "Female"].obs;
  final ImagePicker _picker = ImagePicker();

  RxList<String> qualifications =
      [
        "Any",
        "10th Pass",
        "12th Pass",
        "Diploma",
        "Graduate",
        "Post Graduate",
      ].obs;
  RxList<String> jobTypes = ['Full Time', 'Part Time', 'Internship'].obs;
  RxList<String> jobMode = ['Work From Home', 'Office'].obs;

  TextEditingController contactTo = TextEditingController();
  TextEditingController contactFrom = TextEditingController();

  TextEditingController requirementController = TextEditingController();
  TextEditingController benefitsController = TextEditingController();
  TextEditingController skillsController = TextEditingController();
  TextEditingController workingDaysController = TextEditingController();
  final TextEditingController infoController = TextEditingController();
  TextEditingController hrNumber = TextEditingController();

  RxList<String> skills = <String>[].obs;
  RxList<String> otherRequirement = <String>[].obs;
  RxList<String> benefits = <String>[].obs;
  var benefitSelected = <bool>[].obs;
  var skillSelected = <bool>[].obs;
  var workingDaySelected = <bool>[].obs;
  var otherRequirementSelected = <bool>[].obs;

  List<String> workingDays = ["5 Days Working", "6 Days Working"];

  var workingDayIndex = (-1).obs;
  var workingDaysText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    initializeSelectedLists();
    getJobs();
    getJobData(true);
    getJobFilter();
    selectedJobType = 'recent_jobs'.obs;
  }

  void initializeSelectedLists() {
    benefitSelected.value = List.generate(benefits.length, (index) => false);
    workingDaySelected.value = List.generate(
      workingDays.length,
      (index) => false,
    );
  }

  void toggleFeatureSelected() {
    featureSelected.toggle();
  }

  void toggleOnlyFreshers() {
    onlyFreshers.toggle();
  }

  void toggleCommunicationPref() {
    communicationPref.toggle();
  }

  void setWorkingDay(int index) {
    workingDayIndex.value = index;

    for (int i = 0; i < workingDaySelected.length; i++) {
      workingDaySelected[i] = i == index;
    }
  }

  void addSkill(String skill) {
    if (skill.isNotEmpty && !skills.contains(skill)) {
      skills.add(skill);
      skillSelected.add(false);
    }
  }

  void removeSkill(int index) {
    if (index >= 0 && index < skills.length) {
      skills.removeAt(index);
      skillSelected.removeAt(index);
    }
  }

  void toggleBenefit(int index) {
    if (index >= 0 && index < benefitSelected.length) {
      benefitSelected[index] = !benefitSelected[index];
      benefitSelected.refresh();
    }
  }

  var jobListLoading = false.obs;
  var jobData = <type.Datum>[].obs;
  Future<void> getJobs() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      jobListLoading.value = true;
      final type.JobListRes res = await repo.getJobList(token!);
      if (res.status == true) {
        jobData.assignAll(res.data ?? []);
      } else {}
    } catch (e) {
    } finally {
      jobListLoading.value = false;
    }
  }

  var jobFilterListLoading = false.obs;
  var jobFilterData = Rxn<filter.Data>();
  Future<void> getJobFilter() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      jobFilterListLoading.value = true;
      final filter.JobFilterListRes res = await repo.getJobFilter(token!);
      if (res.status == true) {
        jobFilterData.value = res.data!;
      } else {}
    } catch (e) {
    } finally {
      jobFilterListLoading.value = false;
    }
  }

  var createJobLoading = false.obs;
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController openingsController = TextEditingController();
  final TextEditingController jobDescriptionController =
      TextEditingController();
  var selectedJobType = ''.obs;
  var selectedJobMode = ''.obs;
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  var selectedGender = ''.obs;
  var selectedQualification = ''.obs;
  var onlyFreshers = false.obs;
  TextEditingController minExpController = TextEditingController();
  TextEditingController maxExpController = TextEditingController();
  TextEditingController minSalaryController = TextEditingController();
  TextEditingController maxSalaryController = TextEditingController();
  RxList<String> selectedJobBenefits = <String>[].obs;
  RxList<String> selectedJobSkills = <String>[].obs;
  TextEditingController to = TextEditingController(); //toTime
  TextEditingController from = TextEditingController(); //fromTime
  var selectedWorkingDays = <String>[].obs;

  void clearAllFields() {
    companyNameController.clear();
    jobTitleController.clear();
    categoryController.clear();
    jobDescriptionController.clear();
    openingsController.clear();
    selectedJobType.value = '';
    countryController.clear();
    stateController.clear();
    cityController.clear();
    areaController.clear();
    pincodeController.clear();
    selectedGender.value = '';
    selectedQualification.value = '';
    onlyFreshers.value = false;
    minExpController.clear();
    maxExpController.clear();
    minSalaryController.clear();
    maxSalaryController.clear();
    selectedJobBenefits.clear();
    selectedJobSkills.clear();
    to.clear();
    from.clear();
    selectedWorkingDays.clear();
    contactTo.clear();
    contactFrom.clear();
    communicationPref.value = false;
    selectedJobMode.value = '';
    benefits.clear();
    skills.clear();
    otherRequirement.clear();
    selectedWorkingDays.clear();
  }

  Future<void> createJob(bool? type, dynamic id) async {
    try {
      createJobLoading.value = true;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final fromTime = DateFormat('hh:mm a').parse(from.text);
      final toTime = DateFormat('hh:mm a').parse(to.text);
      final startTime = DateFormat('HH:mm').format(fromTime);
      final endTime = DateFormat('HH:mm').format(toTime);
      final Map<String, dynamic> data = {
        "token": token,

        "job_details": {
          'company_name': companyNameController.text,

          "job_title": jobTitleController.text,
          "job_category": categoryController.text,
          "job_type":
              selectedJobType.value == 'Full Time'
                  ? 'full_time'
                  : selectedJobType.value == 'Part Time'
                  ? 'part_time'
                  : selectedJobType.value == 'Internship'
                  ? 'internship'
                  : selectedJobType.value == 'Remote'
                  ? 'remote'
                  : '',
          'job_mode':
              selectedJobMode.value == 'Work From Home'
                  ? 'work_from_home'
                  : 'office',

          "number_of_openings": int.tryParse(openingsController.text) ?? 0,
          "job_city": cityController.text,
          "job_country": countryController.text,
          "job_pincode": pincodeController.text,
          "job_area": areaController.text,
          "job_state": stateController.text,
          "gender": selectedGender.value,
          "qualification": selectedQualification.value,
          "is_fresher": onlyFreshers.value ? 1 : 0,
          "min_exp": int.tryParse(minExpController.text) ?? 0,
          "max_exp": int.tryParse(maxExpController.text) ?? 0,
          "salary_from": int.tryParse(minSalaryController.text) ?? 0,
          "salary_to": int.tryParse(maxSalaryController.text) ?? 0,
          "job_description": jobDescriptionController.text,
        },

        "job_benefits": selectedJobBenefits.map((e) => {"name": e}).toList(),

        "job_skill": selectedJobSkills.map((e) => {"name": e}).toList(),

        "job_requirements":
            otherRequirement.map((e) => {"requirements": e}).toList(),

        "job_timings": {"start_time": startTime, "end_time": endTime},

        "working_days": {'working_days': selectedWorkingDays.map((e) => e)},
        'communication':
            "Allow Candidates To Call Between\n${contactFrom.text} – ${contactTo.text} on ${hrNumber.text}",
      };
      final res = await repo.createJob(token!, jsonEncode(data), type, id);
      if (res['status'] == true) {
        CommonToast.show(msg: res['message']);
        Get.back();
        Get.back();
        clearAllFields();
        selectedJobType = 'our_jobs'.obs;
        await getJobData(true);
      } else {
        CommonToast.show(msg: res['message']);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      createJobLoading.value = false;
    }
  }

  var getJobListDataLoading = false.obs;
  var currentPage = 1.obs;
  var lastPage = 1.obs;
  RefreshController refreshController = RefreshController();
  var jobListData = <Datum>[].obs;
  var applicantsData = <Applicant>[].obs;

  Future<void> getJobData(
    bool? isRefresh, {
    String? jobType,
    String? jobCategory,
    String? salary,
    String? search,
  }) async {
    try {
      if (isRefresh == true) {
        currentPage.value = 1;
        refreshController.resetNoData();

        if (selectedJobType.value == 'my_job_applicants') {
          applicantsData.clear();
        } else {
          jobListData.clear();
        }
      }

      if (currentPage.value == 1 && isRefresh != true) {
        getJobListDataLoading.value = true;
      }

      final prefs = await SharedPreferences.getInstance();
      final t = prefs.getString('token')!;

      final res = await repo.getJobListData(
        t,
        currentPage.value,
        jobType: jobType,
        jobCategory: jobCategory,
        salary: salary,
        search: search,
      );

      if (res.status == true && res.data != null) {
        if (selectedJobType.value == 'my_job_applicants') {
          final applicantsPage = res.data!.myJobApplicants;
          if (applicantsPage != null) {
            final newApplicants = applicantsPage.data ?? [];
            if (currentPage.value == 1) {
              applicantsData.assignAll(newApplicants);
            } else {
              applicantsData.addAll(newApplicants);
            }
            lastPage.value = applicantsPage.lastPage ?? 1;
          }
        } else {
          AppliedJobs? selectedJobs;
          switch (selectedJobType.value) {
            case 'recent_jobs':
              selectedJobs = res.data!.recentJobs;
              break;
            case 'applied_jobs':
              selectedJobs = res.data!.appliedJobs;
              break;
            default:
              selectedJobs = res.data!.ourJobs;
          }
          final jobList = selectedJobs?.data ?? [];
          final totalLastPage = selectedJobs?.lastPage ?? 1;

          if (currentPage.value == 1) {
            jobListData.assignAll(jobList);
          } else {
            jobListData.addAll(jobList);
          }
          lastPage.value = totalLastPage;
        }

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
        getJobListDataLoading.value = false;
      }
      refreshController.refreshCompleted();
    }
  }

  var jobDeleteLoading = false.obs;
  var deletingJobId = Rxn<int>();
  Future<void> deleteJob(dynamic id) async {
    try {
      deletingJobId.value = id;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final res = await repo.deleteJob(token!, id);
      if (res['status'] == true) {
        CommonToast.show(msg: res['message']);
        await getJobData(true);
      } else {
        CommonToast.show(msg: res['message']);
      }
    } catch (e) {
    } finally {
      deletingJobId.value = null;
    }
  }

  Rx<File?> resumeFile = Rx<File?>(null);
  RxString resumeFileName = ''.obs;

  Future<void> pickResume() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      final file = File(result.files.single.path!);
      resumeFile.value = file;
      resumeFileName.value = result.files.single.name;
    }
  }

  var jobApplyLoading = false.obs;
  Future<void> appJob(bool? isEdit, dynamic id, BuildContext context) async {
    try {
      jobApplyLoading.value = true;

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      final uri = Uri.parse("${Api.applyJob}/$id");

      final request = http.MultipartRequest('POST', uri);

      request.fields['token'] = token ?? '';

      request.fields['information'] = infoController.text;

      if (resumeFile.value != null) {
        request.files.add(
          await http.MultipartFile.fromPath('resume', resumeFile.value!.path),
        );
      }

      final response = await request.send();
      final responseData = await http.Response.fromStream(response);

      final res = jsonDecode(responseData.body);

      if (res['status'] == true) {
        jobApplyLoading.value = false;
        Get.back();
        await showDialog(
          context: context,

          barrierDismissible: false,
          builder: (context) {
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pop(context);
            });
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/apply_success.png', height: 80),

                    const SizedBox(height: 16),

                    Text(
                      'Successful',
                      style: GoogleFonts.dmSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Congratulations, your application has been sent',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        );
        Get.back();
        selectedJobType = 'recent_jobs'.obs;
        await getJobData(false);
        infoController.clear();
      } else {
        log(res.toString());
      }
    } catch (e) {
      CommonToast.show(msg: e.toString());
      log(e.toString());
    } finally {
      jobApplyLoading.value = false;
    }
  }

  @override
  void onClose() {
    to.dispose();
    from.dispose();
    contactTo.dispose();
    contactFrom.dispose();
    minExpController.dispose();
    maxExpController.dispose();
    minSalaryController.dispose();
    maxSalaryController.dispose();
    requirementController.dispose();
    benefitsController.dispose();
    skillsController.dispose();
    workingDaysController.dispose();
    hrNumber.dispose();
    super.onClose();
  }
}
