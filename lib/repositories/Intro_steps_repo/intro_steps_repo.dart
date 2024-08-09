// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:longevity_hub/components/Profile/custom_popup.dart';
import 'package:longevity_hub/data/controller/intro_steps_controller/intro_steps_controller.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/models/activity_level_model/activity_level_model.dart';
import 'package:longevity_hub/models/activity_model/activity_model.dart';
import 'package:longevity_hub/models/consent_model/consent_model.dart';
import 'package:longevity_hub/models/diseases_model/disease_model.dart';
import 'package:longevity_hub/models/gender_response_model/gender_repsonse_model.dart';
import 'package:longevity_hub/models/height_model/height_model.dart';
import 'package:longevity_hub/models/intro_update_model/intro_update_model.dart';
import 'package:longevity_hub/models/weight_model/weight_model.dart';
import 'package:longevity_hub/screens/steps_screen/welcome_success_sccreen.dart';
import 'package:longevity_hub/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StepsRepository {
  getGenders() async {
    var body = {};
    String? accessToken = await LocalDb().getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(Uri.parse(AppConstants.getgenders),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        GenderResponse genderResponseData = GenderResponse.fromJson(result);
        if (genderResponseData.status == 1) {
          StepsController.i.updateIsLoading(false);
          log(genderResponseData.toJson().toString());
          return genderResponseData.data;
        } else {
          CustomPopup.showError(genderResponseData.status.toString());
          StepsController.i.updateIsLoading(false);
        }
      }
    } catch (e) {
      // ToastManager.showToast(e.toString());
      StepsController.i.updateIsLoading(false);
    }
  }

  getHeightMeasurments() async {
    var body = {"PageNumber": "0", "PageLength": "3", "Search": ""};
    String? accessToken = await LocalDb().getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(Uri.parse(AppConstants.getheight),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        HeightModel genderResponseData = HeightModel.fromJson(result);
        if (genderResponseData.status == 1) {
          StepsController.i.updateIsLoading(false);
          log(genderResponseData.toJson().toString());
          return genderResponseData.heightMeasurements;
        } else {
          CustomPopup.showError(genderResponseData.errorMessage.toString());
          StepsController.i.updateIsLoading(false);
        }
      }
    } catch (e) {
      // ToastManager.showToast(e.toString());
      StepsController.i.updateIsLoading(false);
    }
  }

  getWeightMeasurments() async {
    var body = {"PageNumber": "0", "PageLength": "3", "Search": ""};
    String? accessToken = await LocalDb().getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(Uri.parse(AppConstants.getweight),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        WeightModel ResponseData = WeightModel.fromJson(result);
        if (ResponseData.status == 1) {
          StepsController.i.updateIsLoading(false);
          log(ResponseData.toJson().toString());
          return ResponseData.weightMeasurements;
        } else {
          CustomPopup.showError(ResponseData.errorMessage.toString());
          StepsController.i.updateIsLoading(false);
        }
      }
    } catch (e) {
      // ToastManager.showToast(e.toString());
      StepsController.i.updateIsLoading(false);
    }
  }

  getPhhysicalActivityLevel() async {
    var body = {"PageNumber": "0", "PageLength": "25", "Search": ""};
    String? accessToken = await LocalDb().getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getphysicalactivitylevel),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        PhysicalActivitiesLevelModel ResponseData =
            PhysicalActivitiesLevelModel.fromJson(result);
        if (ResponseData.status == 1) {
          StepsController.i.updateIsLoading(false);
          log(ResponseData.toJson().toString());
          return ResponseData.physicalActivityLevels;
        } else {
          CustomPopup.showError(ResponseData.errorMessage.toString());
          StepsController.i.updateIsLoading(false);
        }
      }
    } catch (e) {
      // ToastManager.showToast(e.toString());
      StepsController.i.updateIsLoading(false);
    }
  }

  getPhhysicalActivities() async {
    var body = {
      "PageNumber": StepsController.i.pagenumber,
      "PageLength": "25",
      "Search": ""
    };
    String? accessToken = await LocalDb().getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getphysicalactivities),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        PhysicalActivitiesModel ResponseData =
            PhysicalActivitiesModel.fromJson(result);
        if (ResponseData.status == 1) {
          StepsController.i.updateIsLoading(false);
          StepsController.i.updatePhysicalActivities(ResponseData);
          log(ResponseData.toJson().toString());
          return ResponseData.physicalActivities;
        } else {
          // Utils.toastMessage(
          //     ResponseData.status.toString(), Colors.red, Colors.white);
          StepsController.i.updateIsLoading(false);
        }
      }
    } catch (e) {
      // ToastManager.showToast(e.toString());
      StepsController.i.updateIsLoading(false);
    }
  }

  getDiseases() async {
    var body = {
      "PageNumber": StepsController.i.diseasepagenumber,
      "PageLength": "100",
      "Search": StepsController.i.searchcont.text
    };
    String? accessToken = await LocalDb().getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(Uri.parse(AppConstants.getdiseases),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        DiseaseModel genderResponseData = DiseaseModel.fromJson(result);
        if (genderResponseData.status == 1) {
          StepsController.i.updatemoreLoading(false);
          StepsController.i.updatediseaseresponse(genderResponseData);
          log(genderResponseData.toJson().toString());
          return genderResponseData.diseases;
        } else {
          // Utils.toastMessage(
          //     genderResponseData.status.toString(), Colors.red, Colors.white);
          StepsController.i.updatemoreLoading(false);
        }
      }
    } catch (e) {
      // ToastManager.showToast(e.toString());
      StepsController.i.updatemoreLoading(false);
    }
  }

  introUpdateProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //gender
    String? genderId = prefs.getString('selectedGender');
    //dateofbirth
    int? day = prefs.getInt('dobDay');
    String? month = prefs.getString('dobMonth');
    int? year = prefs.getInt('dobYear');
    String dateOfBirth = "";
    if (day != null && month != null && year != null) {
      dateOfBirth =
          "$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
    }

    // Correctly format the date if it includes time part from a response
    if (dateOfBirth.contains("T")) {
      DateTime parsedDate = DateTime.parse(dateOfBirth);
      dateOfBirth = DateFormat('yyyy-MM-dd').format(parsedDate);
    }
    Map<String, dynamic> heightData = await LocalDb().getHeightData();
    String? heightValue = heightData['heightValue'];
    String? heightMeasurementId = heightData['heightMeasurementId'];
    Map<String, dynamic> weightData = await LocalDb().getWeightData();
    String? weightValue = weightData['weightValue'];
    String? weightMeasurementId = weightData['weightMeasurementId'];
    // List<PhysicalActivities> interestedActivities =
    //     StepsController.i.selectphysicalactivity;
    // List<String> diseases = StepsController.i.selectedDiseaseIds;
    String? activityLevelId = await LocalDb().getActivityLevel();
    var body = {
      "GenderId": genderId ?? "",
      "DateOfBirth": dateOfBirth,
      "Height": heightValue ?? "",
      "HeightMeasurementCategoryId": heightMeasurementId ?? "",
      "Weight": weightValue ?? "",
      "WeightMeasurementCategoryId": weightMeasurementId ?? "",
      "PhysicalActivityLevelId": activityLevelId ?? "",
      "InterestedActivities": StepsController.i.selectedActivityIds.toList(),
      "Diseases": StepsController.i.selectedDiseaseIds.toList(),
    };
    String? accessToken = await LocalDb().getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(Uri.parse(AppConstants.introupdateprofile),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        IntroUpdateModel ResponseData = IntroUpdateModel.fromJson(result);
        if (ResponseData.status == 2) {
          StepsController.i.updateIsLoading(false);
          // Utils.toastMessage(ResponseData.errorMessage.toString(),
          //     ColorManager.kPrimaryColor, Colors.white);
          log(ResponseData.toJson().toString());
          return ResponseData;
        } else {
          CustomPopup.showError(ResponseData.errorMessage.toString());
          StepsController.i.updateIsLoading(false);
        }
      }
    } catch (e) {
      // ToastManager.showToast(e.toString());
      StepsController.i.updateIsLoading(false);
    }
  }

  consentagreement() async {
    var body = {"Status": "true"};
    String? accessToken = await LocalDb().getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(Uri.parse(AppConstants.consentagreement),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        ConsentModel ResponseData = ConsentModel.fromJson(result);
        if (ResponseData.status == 2) {
          StepsController.i.updateIsLoading(false);
          // Utils.toastMessage(ResponseData.errorMessage.toString(),
          //     ColorManager.kPrimaryColor, Colors.white);
          Get.offAll(() => const WelcomeSuccess());
          log(ResponseData.toJson().toString());
          return ResponseData;
        } else {
          CustomPopup.showError(ResponseData.errorMessage.toString());
          StepsController.i.updateIsLoading(false);
        }
      }
    } catch (e) {
      // ToastManager.showToast(e.toString());
      StepsController.i.updateIsLoading(false);
    }
  }
}
