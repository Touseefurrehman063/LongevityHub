// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';
import 'dart:core';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/models/diseases_model/disease_model.dart';
import 'package:longevity_hub/models/user_model/user_model.dart';

class AuthController extends GetxController implements GetxService {
  UserDataModel? user;
  final name = TextEditingController();
  List<String> preselectedIds = [];
  final phone = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();
  final forgetemailController = TextEditingController();
  final confirmpass = TextEditingController();
  List<Diseases> selectedDisease = [];
  String countryCode = "+971";
  String? picturePath;
  var selectedActivityLevelId = '';
  List<Diseases> selectedDiseases = [];
  String? faceBookAccessToken = "";
  String? gmailAccessToken = "";
  String accountType = "";

  void updateIsLoading(bool value) {
    isLoading = value;
    update();
  }

  Set<String> selectedDiseaseIds = <String>{};

  void updateSelectedDiseaseIds(List<Diseases> newDiseases) {
    selectedDiseaseIds =
        newDiseases.map<String>((disease) => disease.id!.toLowerCase()).toSet();
    update();
  }

  late bool isfeetSelected;
  late bool isKgSelected;
  void toggleWeightUnit() {
    // isKgSelected = !isKgSelected;
    user?.weightMeasurementCategoryName = isKgSelected ? "Pound" : "Kilogram";
    user?.weightMeasurementCategoryId = isKgSelected
        ? "970108c7-de95-414a-8ac8-c317cd4c7c76"
        : "ba7d2f0e-6814-4861-9cfc-2bb4142c5378";
  }

  void toggleHeightUnit() {
    // isfeetSelected = !isfeetSelected;
    user?.heightMeasurementCategoryName =
        isfeetSelected ? "Feet" : "Centimeter";
    user?.heightMeasurementCategoryId = isfeetSelected
        ? "6170d73c-6fc3-4c5d-9dce-9bffb5ceec64"
        : "5cbf850e-dcca-4d66-8091-0316192c4d2e";
  }

  TextEditingController fullnamecont = TextEditingController();
  TextEditingController phonecont = TextEditingController();
  TextEditingController emailcont = TextEditingController();
  TextEditingController weightcont = TextEditingController();
  TextEditingController heightcont = TextEditingController();
  TextEditingController gendercont = TextEditingController();
  TextEditingController agecont = TextEditingController();
  TextEditingController diseasecont = TextEditingController();
  TextEditingController activitylevelcont = TextEditingController();
  TextEditingController newpasscontroller = TextEditingController();
  TextEditingController confirmnewpasscontroller = TextEditingController();
  TextEditingController oldpasscontroller = TextEditingController();
  String? diseasesid;
  void updateDiseaseId(String diseaseId) {
    if (!preselectedIds.contains(diseaseId)) {
      preselectedIds.add(diseaseId);
      diseasesid = preselectedIds.join(",");
    }

    if (preselectedIds.contains(diseaseId)) {
      preselectedIds.remove(diseaseId);
      diseasesid = preselectedIds.join(",");
    }

    update();
  }

  passFunc() {
    fullnamecont = TextEditingController(text: user?.firstName ?? "");
    phonecont = TextEditingController(text: user?.cellNumber ?? "");
    emailcont = TextEditingController(text: user?.email ?? "");
    weightcont = TextEditingController(text: user?.weight.toString() ?? "");
    heightcont = TextEditingController(text: user?.height.toString() ?? "");
    gendercont = TextEditingController(text: user?.gender ?? "");
    agecont = TextEditingController(text: user?.age ?? "");
    diseasecont = TextEditingController(text: user?.diseasesListName ?? "");
    activitylevelcont =
        TextEditingController(text: user?.physicalActivityLevelName ?? "");
    diseasesid = user?.diseasesListIds ?? "";
    if (diseasecont.text.isNotEmpty) {
      selectedDiseases.add(Diseases(
          code: '', comments: '', id: diseasesid, name: diseasecont.text));
    }
  }

  bool isChangePasswordLoading = false;
  updateIsChangePasswordloading(bool value) {
    isChangePasswordLoading = value;
    update();
  }

  bool _isLoadingMoredata = false;
  bool get isLoadingmoreData => _isLoadingMoredata;
  updatemoreLoading(bool value) {
    _isLoadingMoredata = value;
    update();
  }

  void updateUserData(UserDataModel? userresponse) {
    user = userresponse;
  }

  bool isLoading = false;

  updateisLoading(value) {
    isLoading = value;
    update();
  }

  bool isOtpLoading = false;

  void updateisOtpLoading(bool value) {
    isLoading = value;
    update();
  }

  bool isforgetLoading = false;

  void updateisforgetLoading(bool value) {
    isforgetLoading = value;
    update();
  }

  // GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  // bool isloginLoading = false;

  // Future<void> login() async {
  //   try {
  //     isloginLoading = true;
  //     if (!loginFormKey.currentState!.validate()) {
  //       isloginLoading=false;
  //       return;
  //     }
  //     final auth=AuthService.goog.instance;
  //     await auth.loginWith
  //   } catch (e) {}
  // }

  bool _isotpLoading = false;
  bool get isotpLoading => _isotpLoading;
  bool obsecure = true;
  bool obsecure1 = true;
  bool obsecure2 = true;
  bool obsecure3 = true;
  bool obsecure4 = true;

  bool changepassword = true;
  bool changeconfirmpassword = true;
  bool oldpassword = true;
  bool newpassword = true;
  bool newconfirmpassword = true;

  updateobsecurepassword(bool ob) {
    obsecure = !obsecure;
    update();
  }

  updateobsecurepassword1(bool ob) {
    obsecure1 = !obsecure1;
    update();
  }

  updatechangepassword(bool ob) {
    changepassword = !changepassword;
    update();
  }

  updatechangeconfirmpassword(bool ob) {
    changeconfirmpassword = !changeconfirmpassword;
    update();
  }

  updateoldpassword(bool ob) {
    oldpassword = !oldpassword;
    update();
  }

  updatenewpassword(bool ob) {
    newpassword = !newpassword;
    update();
  }

  updatenewconfirmpassword(bool ob) {
    newconfirmpassword = !newconfirmpassword;
    update();
  }

  updateIsotploading(bool value) {
    _isotpLoading = value;
    update();
  }

  String verificationCode = "";
  String code = '';
  updatecode(c) {
    code = c;
    update();
  }

  String verificationcode = '';
  updateverificationcode(c) {
    verificationcode = c;
    update();
  }

  String otpemail = '';
  updatotpemail(c) {
    otpemail = c;
    update();
  }

  String otpusername = '';
  updateusername(c) {
    otpusername = c;
    update();
  }

  // Forget Password Timer
  RxInt timer = 300.obs;
  var isTimerOver = false.obs;
  void startTimer(ctx) {
    isTimerOver.value = false;
    const oneSecond = Duration(seconds: 1);
    Timer.periodic(oneSecond, (tim) {
      if (timer == 0) {
        isTimerOver.value = true;
        tim.cancel();
        // Get.to(() => const ForgetPassword());
        Fluttertoast.showToast(
            msg: "codeexpire".tr,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorManager.kPrimaryColor,
            textColor: ColorManager.kWhiteColor,
            fontSize: 14.0);
      } else {
        timer--;
      }
    });
  }

  String removeCountryCode(String phone) {
    String? countryCode = AuthController.i.user?.countryCode;
    log(countryCode.toString());

    if (countryCode != null && phone.startsWith(countryCode)) {
      return phone.substring(countryCode.length);
    }

    return phone;
  }

// =======> LoginControllers
  late TextEditingController emailController;
  late TextEditingController passwordController;

  resettimerupdate() {
    timer = 0.obs;
    update();
  }

  disposefields() {
    emailController.clear();
    passwordController.clear();
  }

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  static AuthController get i => Get.put(AuthController());
}
