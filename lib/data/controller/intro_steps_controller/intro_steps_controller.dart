import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/models/activity_level_model/activity_level_model.dart';
import 'package:longevity_hub/models/activity_model/activity_model.dart';
import 'package:longevity_hub/models/diseases_model/disease_model.dart';
import 'package:longevity_hub/models/height_model/height_model.dart';
import 'package:longevity_hub/models/weight_model/weight_model.dart';
import 'package:longevity_hub/repositories/Intro_steps_repo/intro_steps_repo.dart';
import 'package:longevity_hub/screens/steps_screen/welcome_screen.dart';

class StepsController extends GetxController implements GetxService {
  // Loaders //
  bool? _familyMembersAddLoader = false;
  List<String> selectedActivityIds = [];
  List<String> stringList = [];
  List<String> selectedDiseaseIds = [];
  TextEditingController searchcont = TextEditingController();

  String selectedHeight = "";
  String selectedHeightcm = "";
  String selectedHeightft = "";
  double selectedFeet = 5.6;
  String selectedWeight = "kilogram";
  int selectedCm = 165;
  String selectedActivity = "";
  int? selectedActivityId;
  bool isSelected = false;
  bool isSelecteddisease = false;
  List<PhysicalActivities> selectphysicalactivity = [];
  List<Diseases> selectdiseaselist = [];
  Diseases? selectedDisease;
  final double min = 8.0;
  final double max = 200;
  final int minp = 17;
  final int maxp = 400;
  int pagenumber = 0;
  int diseasepagenumber = 0;
  String selectedValue = '';
  String selectedPound = '';
  bool? get familyMembersAddLoader => _familyMembersAddLoader;
  bool isDiseaseSelected = false;
  bool? _existingFamilyMemberLoader = false;
  bool? get existingFamilyMemberLoader => _existingFamilyMemberLoader;
  var isSelectedDiseaseMap = <String, bool>{}.obs;
  void toggleDiseaseSelection(String diseaseId) {
    if (isSelectedDiseaseMap.containsKey(diseaseId)) {
      isSelectedDiseaseMap[diseaseId] = !isSelectedDiseaseMap[diseaseId]!;
    } else {
      isSelectedDiseaseMap[diseaseId] = true;
    }
    update();
  }

  List<Diseases> getSelectedDiseases() {
    List<Diseases> selectedDiseases = [];
    for (var id in selectedDiseaseIds) {
      var disease = diseaseList.firstWhere((d) => d.id.toString() == id);
      selectedDiseases.add(disease);
    }
    return selectedDiseases;
  }

  bool isActivitySelected = false;
  var isSelectedActivityMap = <String, bool>{}.obs;
  void toggleActivitySelection(String activityId) {
    if (isSelectedActivityMap.containsKey(activityId)) {
      isSelectedActivityMap[activityId] = !isSelectedActivityMap[activityId]!;
    } else {
      isSelectedActivityMap[activityId] = true;
    }
    update();
  }

  void updateselectedactivity() async {
    String activityname = await LocalDb().getActivityLevel();
    log("activityname: $activityname");

    // for (var v in activitylevellist) {
    //   if (v.name == activityname) {
    //     selectedActivity = v.id.toString();
    //     log("v name :${v.id}");
    //   }
    // }
  }

  updateselectedheight() {
    heightMeasurements.isNotEmpty
        ? selectedHeight = heightMeasurements[1].name!
        : "";
    update();
  }

  updateselectedweight() {
    selectedWeight = weightMeasurements[1].name!;
    update();
  }

  updateIsFamilyMemberLoader(bool value) {
    _familyMembersAddLoader = value;
    update();
  }

  updateExistingFamilyMemberLoader(bool value) {
    _existingFamilyMemberLoader = value;
    update();
  }

  bool _isLoadingMoredata = false;
  bool get isLoadingmoreData => _isLoadingMoredata;
  updatemoreLoading(bool value) {
    _isLoadingMoredata = value;
    update();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  updateIsLoading(bool value) {
    _isLoading = value;
    update();
  }

  PhysicalActivitiesModel? responsedata;
  void updatePhysicalActivities(PhysicalActivitiesModel activities) {
    responsedata = activities;
  }

  DiseaseModel? diseaseresponse;
  void updatediseaseresponse(DiseaseModel? disese) {
    diseaseresponse = disese;
  }

  List<Diseases> _diseaseList = [];
  List<Diseases> get diseaseList => _diseaseList;
  updateDiseaseList(List<Diseases> diseases) {
    _diseaseList = diseases;
    update();
  }

  updatedisease(Diseases disease) {
    selectedDisease = disease;

    update();
  }

  List<PhysicalActivities> _activityList = [];
  List<PhysicalActivities> get activitylist => _activityList;
  updateActivityList(List<PhysicalActivities> activity) {
    _activityList = activity;
    update();
  }

  List<PhysicalActivityLevels> _activitylevelList = [];
  List<PhysicalActivityLevels> get activitylevellist => _activitylevelList;

  void updateActivityLevelList(List<PhysicalActivityLevels> activitylevel) {
    _activitylevelList = activitylevel;

    update();
  }

  updateactivitylist() {
    stringList.clear();
    for (int i = 0; i < activitylevellist.length; i++) {
      stringList.add(activitylevellist[i].name!);
    }
    update();
  }

  final ScrollController scrollController = ScrollController();
  bool setStartToFetchNextData() {
    final responseData = diseaseresponse;
    if (responseData != null) {
      final totaldiseaseRecords = responseData.totalRecords ?? 0;
      if ((diseaseList.length) < totaldiseaseRecords) {
        diseasepagenumber = diseasepagenumber + 1;
        return true;
      } else {
        return false;
      }
    } else {
      // Handle null responseData
      return false;
    }
  }

  Future<void> getDiseases() async {
    updateIsLoading(true);

    try {
      var diseases = await StepsRepository().getDiseases();

      if (diseases != null) {
        updateDiseaseList(diseases);
      } else {
        // Utils.toastMessage(
        //     "Failed to fetch diseases", Colors.red, Colors.white);
      }
    } catch (e) {
      // Utils.toastMessage("Error: $e", Colors.grey, Colors.white);
    }

    updateIsLoading(false);
  }

  Future<void> getPhysicalactivities() async {
    updateIsLoading(true);

    try {
      var activity = await StepsRepository().getPhhysicalActivities();
      if (activity != null) {
        updateActivityList(activity);
      } else {
        // Utils.toastMessage(
        //     "Failed to fetch activities", Colors.grey, Colors.white);
      }
    } catch (e) {
      // Utils.toastMessage("Error: $e", Colors.grey, Colors.white);
    }

    updateIsLoading(false);
  }

  Future<void> getactivitiylevel() async {
    try {
      var activitylevel = await StepsRepository().getPhhysicalActivityLevel();
      if (activitylevel != null) {
        updateActivityLevelList(activitylevel);
      } else {
        // Utils.toastMessage(
        //     "Failed to fetch activities level", Colors.red, Colors.white);
      }
    } catch (e) {
      // Utils.toastMessage("Error: $e", Colors.grey, Colors.white);
    }
  }

  PhysicalActivityLevels? selectedActivityLevel;
  void updateActivityLevel(PhysicalActivityLevels activityLevel) {
    selectedActivityLevel = activityLevel;
    log('selected lab Test ${activityLevel.name}');
    update();
  }

  List<HeightMeasurements> heightMeasurements = [];
  Future<void> fetchHeightMeasurements() async {
    List<HeightMeasurements> measurements =
        await StepsRepository().getHeightMeasurments();

    heightMeasurements = measurements;
  }

  List<WeightMeasurements> weightMeasurements = [];
  Future<void> fetchWeightMeasurements() async {
    List<WeightMeasurements> measurements =
        await StepsRepository().getWeightMeasurments();

    weightMeasurements = measurements;
  }

  updateheight() {
    selectedHeightcm = heightMeasurements[0].name!;
    selectedHeightft = heightMeasurements[1].name!;
    update();
  }

  Future<void> updateIntroProfile() async {
    updateIsLoading(true);
    var result = await StepsRepository().introUpdateProfile();
    if (result != null) {
      Get.offAll(() => const WelcomeLongevity());
    }
    updateIsLoading(false);
    update();
  }

  static StepsController get i => Get.put(StepsController());
}
