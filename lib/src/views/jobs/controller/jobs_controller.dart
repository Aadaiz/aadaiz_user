import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobsController extends GetxController {

  var featureSelected = true.obs;


  Rx<TimeOfDay?> fromTime = Rx<TimeOfDay?>(null);
  Rx<TimeOfDay?> toTime = Rx<TimeOfDay?>(null);
  Rx<TimeOfDay?> contactFromTime = Rx<TimeOfDay?>(null);
  Rx<TimeOfDay?> contactToTime = Rx<TimeOfDay?>(null);


  TextEditingController to = TextEditingController();
  TextEditingController from = TextEditingController();
  TextEditingController contactTo = TextEditingController();
  TextEditingController contactFrom = TextEditingController();
  TextEditingController minExpController = TextEditingController();
  TextEditingController maxExpController = TextEditingController();
  TextEditingController minSalaryController = TextEditingController();
  TextEditingController maxSalaryController = TextEditingController();
  TextEditingController requirementController = TextEditingController();
  TextEditingController benefitsController = TextEditingController();
  TextEditingController skillsController = TextEditingController();
  TextEditingController workingDaysController = TextEditingController();
  TextEditingController hrNumber = TextEditingController();


  var onlyFreshers = false.obs;
  var communicationPref = false.obs;

  RxList<String> benefits = <String>[
    "Cab",
    "Meal",
    "Insurance",
    "PF",
    "Medical Benefits",
  ].obs;

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
  }

  void initializeSelectedLists() {

    benefitSelected.value = List.generate(benefits.length, (index) => false);
    workingDaySelected.value = List.generate(workingDays.length, (index) => false);

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
