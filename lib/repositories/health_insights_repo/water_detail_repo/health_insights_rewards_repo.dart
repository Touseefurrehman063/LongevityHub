// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:longevity_hub/components/Profile/custom_popup.dart';
import 'package:longevity_hub/components/Profile/custom_popup_attention.dart';
import 'package:longevity_hub/data/controller/gym_membership_controller/gym_membership_controller.dart';
import 'package:longevity_hub/data/controller/health_insights_controller/health_insights_controller.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/models/heallth_insights_model/sleep_rewards_model.dart';
import 'package:longevity_hub/models/heallth_insights_model/steps_reward_model.dart';
import 'package:longevity_hub/models/heallth_insights_model/update_water_level_model.dart';
import 'package:longevity_hub/models/heallth_insights_model/user_sleep_model.dart';
import 'package:longevity_hub/models/heallth_insights_model/user_steps_level_model.dart';
import 'package:longevity_hub/models/heallth_insights_model/user_water_level_model.dart';
import 'package:longevity_hub/models/heallth_insights_model/user_workout_model.dart';
import 'package:longevity_hub/models/heallth_insights_model/water_rewards_model.dart';
import 'package:longevity_hub/models/heallth_insights_model/workout_rewards_model.dart';
import 'package:longevity_hub/screens/health_insights_screens/steps_count_screen.dart';

import 'package:longevity_hub/utils/constants.dart';
import 'package:http/http.dart' as http;

class HealthInsightsRewardRepo {
  getSleepRewardsLevel() async {
    String? accessToken = await LocalDb().getAccessToken();
    var body = {};
    var headers = {
      // 'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(Uri.parse(AppConstants.getsleeplevel),
          headers: headers, body: body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        SleepLevelsModel responseData = SleepLevelsModel.fromJson(result);
        if (responseData.status == 1) {
          HealthInsightsController.i.updateIsLoading(false);
          HealthInsightsController.i.getsleepLevels(responseData.data);
          log(responseData.toJson().toString());
          return responseData.data;
        } else {
          CustomPopup.showError(responseData.errorMessage.toString());
          HealthInsightsController.i.updateIsLoading(false);
        }
      } else {
        log('Error: Received status code ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log('Exception: $e');
      log('StackTrace: $stackTrace');
      // ToastManager.showToast(e.toString());
      GymMembershipController.i.updateIsLoading(false);
    }
  }

  getStepsRewardsLevel() async {
    String? accessToken = await LocalDb().getAccessToken();
    var body = {};
    var headers = {
      // 'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getStepsRewardsLevel),
          headers: headers,
          body: body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        StepsLevelsModel responseData = StepsLevelsModel.fromJson(result);
        if (responseData.status == 1) {
          HealthInsightsController.i.updateIsLoading(false);
          HealthInsightsController.i.getstepsLevels(responseData.data);
          log(responseData.toJson().toString());
          return responseData.data;
        } else {
          // CustomPopup.showError(responseData.errorMessage.toString());
          HealthInsightsController.i.updateIsLoading(false);
        }
      } else {
        log('Error: Received status code ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log('Exception: $e');
      log('StackTrace: $stackTrace');
      // ToastManager.showToast(e.toString());
      GymMembershipController.i.updateIsLoading(false);
    }
  }

  getWorkoutRewardsLevel() async {
    String? accessToken = await LocalDb().getAccessToken();
    var body = {};
    var headers = {
      // 'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getWorkoutRewardsLevel),
          headers: headers,
          body: body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        WorkoutLevelsModel responseData = WorkoutLevelsModel.fromJson(result);
        if (responseData.status == 1) {
          HealthInsightsController.i.updateIsLoading(false);
          HealthInsightsController.i.getWorkoutLevels(responseData.data);
          log(responseData.toJson().toString());
          return responseData.data;
        } else {
          // CustomPopup.showError(responseData.errorMessage.toString());
          HealthInsightsController.i.updateIsLoading(false);
        }
      } else {
        log('Error: Received status code ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log('Exception: $e');
      log('StackTrace: $stackTrace');
      // ToastManager.showToast(e.toString());
      GymMembershipController.i.updateIsLoading(false);
    }
  }

  getwaterIntakeRewardsLevel() async {
    String? accessToken = await LocalDb().getAccessToken();
    var body = {};
    var headers = {
      // 'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getWaterActivityRewardsLevel),
          headers: headers,
          body: body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        WaterLevelsModel responseData = WaterLevelsModel.fromJson(result);
        if (responseData.status == 1) {
          HealthInsightsController.i.updateIsLoading(false);
          HealthInsightsController.i.getwaterLevels(responseData.data);
          log(responseData.toJson().toString());
          return responseData.data;
        } else {
          // CustomPopup.showError(responseData.errorMessage.toString());
          HealthInsightsController.i.updateIsLoading(false);
        }
      } else {
        log('Error: Received status code ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log('Exception: $e');
      log('StackTrace: $stackTrace');
      // ToastManager.showToast(e.toString());
      GymMembershipController.i.updateIsLoading(false);
    }
  }

  getIntakeWaterGlassActivity() async {
    String? userId = await LocalDb().getUserid();
    var body = {
      "UserId": userId,
    };
    String? accessToken = await LocalDb().getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getUserWaterActivityRewardsLevel),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        WaterUserModel responseData = WaterUserModel.fromJson(result);
        if (responseData.status == 1) {
          HealthInsightsController.i.updateIsLoading(false);
          HealthInsightsController.i
              .getuserWaterActivityLevel(responseData.waterUserData);

          log(responseData.toJson().toString());
          return responseData;
        } else {
          // CustomPopup.showError(responseData.status.toString());
          HealthInsightsController.i.updateIsLoading(false);
        }
      } else {
        log('Error: Received status code ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log('Exception: $e');
      log('StackTrace: $stackTrace');
      // ToastManager.showToast(e.toString());
      HealthInsightsController.i.updateIsLoading(false);
    }
  }

  getUserStepsActivityRewardsLevel() async {
    String? userId = await LocalDb().getUserid();
    var body = {
      "UserId": userId,
    };
    String? accessToken = await LocalDb().getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getUserStepsActivityRewardsLevel),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        UserStepsModel responseData = UserStepsModel.fromJson(result);
        if (responseData.status == 1) {
          HealthInsightsController.i.updateIsLoading(false);
          HealthInsightsController.i
              .getuserStepsActivityLevel(responseData.data);

          log(responseData.toJson().toString());
          return responseData;
        } else {
          // CustomPopup.showError(responseData.status.toString());
          HealthInsightsController.i.updateIsLoading(false);
        }
      } else {
        log('Error: Received status code ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log('Exception: $e');
      log('StackTrace: $stackTrace');
      // ToastManager.showToast(e.toString());
      HealthInsightsController.i.updateIsLoading(false);
    }
  }

  getUserSleepsActivityRewardsLevel() async {
    String? userId = await LocalDb().getUserid();
    var body = {
      "UserId": userId,
    };
    String? accessToken = await LocalDb().getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getUserSleepActivityRewardsLevel),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        UserSleepModel responseData = UserSleepModel.fromJson(result);
        if (responseData.status == 1) {
          HealthInsightsController.i.updateIsLoading(false);
          HealthInsightsController.i
              .getuserSleepActivityLevel(responseData.data);

          log(responseData.toJson().toString());
          return responseData;
        } else {
          // CustomPopup.showError(responseData.status.toString());
          HealthInsightsController.i.updateIsLoading(false);
        }
      } else {
        log('Error: Received status code ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log('Exception: $e');
      log('StackTrace: $stackTrace');
      // ToastManager.showToast(e.toString());
      HealthInsightsController.i.updateIsLoading(false);
    }
  }

  getUserWorkoutActivityRewardsLevel() async {
    String? userId = await LocalDb().getUserid();
    var body = {
      "UserId": userId,
    };
    String? accessToken = await LocalDb().getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getUserWorkoutActivityRewardsLevel),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        UserWorkoutModel responseData = UserWorkoutModel.fromJson(result);
        if (responseData.status == 1) {
          HealthInsightsController.i.updateIsLoading(false);
          HealthInsightsController.i
              .getuserworkoutActivityLevel(responseData.data);

          log(responseData.toJson().toString());
          return responseData;
        } else {
          // CustomPopup.showError(responseData.status.toString());
          HealthInsightsController.i.updateIsLoading(false);
        }
      } else {
        log('Error: Received status code ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log('Exception: $e');
      log('StackTrace: $stackTrace');
      // ToastManager.showToast(e.toString());
      HealthInsightsController.i.updateIsLoading(false);
    }
  }

  updateUserWaterActivityRewardsLevel() async {
    String? userId = await LocalDb().getUserid();
    var body = {
      "UserId": userId,
      "Id": HealthInsightsController.i.waterlevelUser.isNotEmpty
          ? HealthInsightsController.i.waterlevelUser[0].id ?? ""
          : "",
    };
    String? accessToken = await LocalDb().getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(
          Uri.parse(AppConstants.updateUserWaterActivityRewardsLevel),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        UpdateWaterLevelModel responseData =
            UpdateWaterLevelModel.fromJson(result);
        if (responseData.status == 3) {
          HealthInsightsController.i.updateIsLoading(false);

          getIntakeWaterGlassActivity();

          log(responseData.toJson().toString());
          return responseData;
        } else if (responseData.status == 2) {
          getIntakeWaterGlassActivity();

          CustomPopupAttention.showError(responseData.message.toString());
        } else {
          // CustomPopup.showError(responseData.status.toString());
          HealthInsightsController.i.updateIsLoading(false);
        }
      } else {
        log('Error: Received status code ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log('Exception: $e');
      log('StackTrace: $stackTrace');
      // ToastManager.showToast(e.toString());
      HealthInsightsController.i.updateIsLoading(false);
    }
  }

  saveFootStepActivity(String goal) async {
    String? userId = await LocalDb().getUserid();
    var body = {
      "UserId": userId,
      "KiloCalories": goal,
    };
    String? accessToken = await LocalDb().getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(
          Uri.parse(AppConstants.saveFootStepActivity),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        UpdateWaterLevelModel responseData =
            UpdateWaterLevelModel.fromJson(result);
        if (responseData.status == 1 || responseData.status == 2) {
          HealthInsightsController.i.updateIsLoading(false);
          Get.to(() => const StepCountScreen());

          log(responseData.toJson().toString());
          return responseData;
        } else {
          // Get.to(() => const StepCountScreen());
          CustomPopup.showError(responseData.message.toString());
          HealthInsightsController.i.updateIsLoading(false);
        }
      } else {
        log('Error: Received status code ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log('Exception: $e');
      log('StackTrace: $stackTrace');
      // ToastManager.showToast(e.toString());
      HealthInsightsController.i.updateIsLoading(false);
    }
  }

  updateFootStepActivityRewardsLevel(String Kgoal) async {
    String? userId = await LocalDb().getUserid();
    var body = {
      "UserId": userId,
      "BurnKiloCalories": Kgoal,
      "Id": HealthInsightsController.i.stepslevelUser.isNotEmpty
          ? HealthInsightsController.i.stepslevelUser[0].id ?? ""
          : "",
    };
    String? accessToken = await LocalDb().getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(
          Uri.parse(AppConstants.updateFootStepActivityRewardsLevel),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        UpdateWaterLevelModel responseData =
            UpdateWaterLevelModel.fromJson(result);
        if (responseData.status == 1) {
          HealthInsightsController.i.updateIsLoading(false);
          getUserStepsActivityRewardsLevel();

          log(responseData.toJson().toString());
          return responseData;
        } else {
          HealthInsightsController.i.updateIsLoading(false);
        }
      } else {
        log('Error: Received status code ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log('Exception: $e');
      log('StackTrace: $stackTrace');
      // ToastManager.showToast(e.toString());
      HealthInsightsController.i.updateIsLoading(false);
    }
  }
}
