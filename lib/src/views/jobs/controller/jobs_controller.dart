import 'dart:convert';
import 'dart:developer';

import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/model/job_list_data_model.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/model/job_filter_list_model.dart'
    as filter;
import 'package:aadaiz_customer_crm/src/views/jobs/model/job_list_type_model.dart'
    as type;
import 'package:aadaiz_customer_crm/src/views/jobs/repository/job_repository.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class JobsController extends GetxController {
  var featureSelected = true.obs;
  final JobRepository repo = JobRepository();
  var communicationPref = false.obs;
  Rx<TimeOfDay?> fromTime = Rx<TimeOfDay?>(null);
  Rx<TimeOfDay?> toTime = Rx<TimeOfDay?>(null);
  Rx<TimeOfDay?> contactFromTime = Rx<TimeOfDay?>(null);
  Rx<TimeOfDay?> contactToTime = Rx<TimeOfDay?>(null);
  RxList<String> genders = ["Any", "Male", "Female"].obs;

  RxList<String> qualifications =
      [
        "Any",
        "10th Pass",
        "12th Pass",
        "Diploma",
        "Graduate",
        "Post Graduate",
      ].obs;
  RxList<String> jobTypes =
      ['Full Time', 'Part Time', 'Internship', 'Remote'].obs;

  TextEditingController contactTo = TextEditingController();
  TextEditingController contactFrom = TextEditingController();

  TextEditingController requirementController = TextEditingController();
  TextEditingController benefitsController = TextEditingController();
  TextEditingController skillsController = TextEditingController();
  TextEditingController workingDaysController = TextEditingController();
  TextEditingController hrNumber = TextEditingController();

  RxList<String> benefits =
      <String>["Cab", "Meal", "Insurance", "PF", "Medical Benefits"].obs;

  RxList<String> skills = <String>[].obs;
  RxList<String> otherRequirement = <String>[].obs;

  var benefitSelected = <bool>[].obs;
  var skillSelected = <bool>[].obs;
  var workingDaySelected = <bool>[].obs;
  var otherRequirementSelected = <bool>[].obs;

  List<String> workingDays = ["5 Days Working", "6 Days Working", "Others"];

  var workingDayIndex = (-1).obs;

  @override
  void onInit() {
    super.onInit();
    initializeSelectedLists();
    getJobs();
    getJobData(true);
    getJobFilter();
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
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController openingsController = TextEditingController();
  var selectedJobType = ''.obs;
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  var selectedGender = 'recent_jobs'.obs;
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
    jobTitleController.clear();
    categoryController.clear();
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
  }

  Future<void> createJob() async {
    try {
      createJobLoading.value = true;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final Map<String, dynamic> data = {
        "token": token,

        "job_details": {
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
          "job_description": "Need experienced tailor for stitching",
        },

        "job_benefits": selectedJobBenefits.map((e) => {"name": e}).toList(),

        "job_skill": selectedJobSkills.map((e) => {"name": e}).toList(),

        "job_requirements":
            otherRequirement.map((e) => {"requirements": e}).toList(),

        "job_timings": {"start_time": from.text, "end_time": to.text},

        "working_days": {"working_days": selectedWorkingDays.join(", ")},
        'communication':
            "Allow Candidates To Call Between\n${contactFrom.text} – ${contactTo.text} on ${hrNumber.text}",
      };
      final res = await repo.createJob(token!, jsonEncode(data));
      if (res['status'] == true) {
        CommonToast.show(msg: res['message']);
        Get.back();
        Get.back();
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
      }

      if (currentPage.value == 1 && isRefresh != true) {
        getJobListDataLoading.value = true;
      }

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? t = prefs.getString('token');

      final JobListResponse res = await repo.getJobListData(
        t!,
        currentPage.value,
        jobType: jobType,
        jobCategory: jobCategory,
        salary: salary,
        search: search,
      );

      if (res.status == true && res.data != null) {
        AppliedJobs? selectedData;

        switch (selectedJobType.value) {
          case 'recent_jobs':
            selectedData = res.data!.recentJobs;
            break;
          case 'applied_jobs':
            selectedData = res.data!.appliedJobs;
            break;
          case 'my_job_applicants':
            selectedData = res.data!.myJobApplicants;
            break;
          default:
            selectedData = res.data!.ourJobs;
        }

        final jobList = selectedData?.data ?? [];
        final totalLastPage = selectedData?.lastPage ?? 1;

        if (currentPage.value == 1) {
          jobListData.assignAll(jobList);
        } else {
          jobListData.addAll(jobList);
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
        getJobListDataLoading.value = false;
      }
      refreshController.refreshCompleted();
    }
  }
  var jobDeleteLoading = false.obs;
  Future<void> deleteJob(dynamic id) async {
    try {
      jobDeleteLoading.value = true;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final res = await repo.deleteJob(token!, id);
      if (res['status'] == true) {
        CommonToast.show(msg: res['message']);
        await getJobData(false);
      } else {
        CommonToast.show(msg: res['message']);
      }
    } catch (e) {
    } finally {
      jobDeleteLoading.value = false;
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
