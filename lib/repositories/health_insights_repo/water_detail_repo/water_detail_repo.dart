// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:longevity_hub/components/Profile/custom_popup.dart';
import 'package:longevity_hub/data/controller/health_insights_controller/health_insights_controller.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/models/heallth_insights_model/update_Water_model.dart';
import 'package:longevity_hub/models/heallth_insights_model/water_category_model.dart';
import 'package:longevity_hub/models/heallth_insights_model/water_detail_model.dart';
import 'package:longevity_hub/models/heallth_insights_model/water_intake_model.dart';
import 'package:longevity_hub/utils/constants.dart';
import 'package:http/http.dart' as http;

class WaterRepository {
  Future<List<Data>> getWaterActivity() async {
    String? accessToken = await LocalDb().getAccessToken();
    String? userId = await LocalDb().getUserid();
    var body = {
      "UserId": userId,
    };
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(Uri.parse(AppConstants.getWaterActivity),
          body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        WaterResponse responseData = WaterResponse.fromJson(result);
        if (responseData.status == 1) {
          HealthInsightsController.i.updateIsLoading(false);
          HealthInsightsController.i
              .setWaterActivities(responseData.data ?? []);
          HealthInsightsController.i.update();
          log(responseData.toJson().toString());
          return responseData.data ?? [];
        } else {
          HealthInsightsController.i.updateIsLoading(false);
          return [];
        }
      } else {
        log('Error: Received status code ${response.statusCode}');
        return [];
      }
    } catch (e, stackTrace) {
      log('Exception: $e');
      log('StackTrace: $stackTrace');
      HealthInsightsController.i.updateIsLoading(false);
      return [];
    }
  }

  getIntakeWaterGlassActivity() async {
    var body = {
      "UserId": HealthInsightsController.i.waterActivities[0].userId,
      "WaterActivityId": HealthInsightsController.i.selectedWaterActivityId,
    };
    String? accessToken = await LocalDb().getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getIntakeWaterGlassCount),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        GetIntakeWaterModel responseData = GetIntakeWaterModel.fromJson(result);
        if (responseData.status == 1) {
          HealthInsightsController.i.updateIsLoading(false);
          HealthInsightsController.i.setIntakeWaterModel(responseData);

          HealthInsightsController.i.counter =
              responseData.intakeGlassCount ?? 0;

          log(responseData.toJson().toString());
          return responseData;
        } else {
          CustomPopup.showError(responseData.status.toString());
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

  updateHealthInsightWaterActivity() async {
    var body = {
      "UserId": HealthInsightsController.i.waterActivities[0].userId,
      "WaterActivityId":
          HealthInsightsController.i.selectedWaterActivityId.isNotEmpty
              ? HealthInsightsController.i.selectedWaterActivityId
              : "953f64af-bbbc-48db-8c13-2d01174a3d76",
      "IntakeGlassCount": HealthInsightsController.i.counter
    };
    String? accessToken = await LocalDb().getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(
          Uri.parse(AppConstants.updateHealthInsightWaterActivity),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        UpdateWaterModel responseData = UpdateWaterModel.fromJson(result);
        if (responseData.status == 1) {
          HealthInsightsController.i.updateIsLoading(false);
          log(responseData.toJson().toString());
          return responseData.message;
        } else {
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

  getcategory() async {
    String? accessToken = await LocalDb().getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.get(
          Uri.parse(AppConstants.getWaterActivityCategories),
          headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        WaterCategoryModel responseData = WaterCategoryModel.fromJson(result);
        if (responseData.status == 1) {
          HealthInsightsController.i.updateIsLoading(false);
          HealthInsightsController.i.getWaterCatogery(responseData.data);

          // HealthInsightsController.i.counter =
          //     responseData.intakeGlassCount ?? 0;

          log(responseData.toJson().toString());
          return responseData;
        } else {
          CustomPopup.showError(responseData.status.toString());
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

  saveWaterActivity() async {
    HealthInsightsController.i.updateIsLoading(true);
    String? userId = await LocalDb().getUserid();
    String? categoryId = await LocalDb().getSelectedCategoryId();
    var body = {
      "UserId": userId,
      "WaterActivityCategoryId": categoryId,
      "NumberOfGlass": HealthInsightsController.i.waterQuantityCont.text
    };
    String? accessToken = await LocalDb().getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(Uri.parse(AppConstants.saveWaterActivity),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        UpdateWaterModel responseData = UpdateWaterModel.fromJson(result);
        if (responseData.status == 1) {
          HealthInsightsController.i.updateIsLoading(false);
          await getWaterActivity();
          log(responseData.toJson().toString());
          return responseData.message;
        } else {
          String errorMessage =
              responseData.message ?? 'Unknown error occurred';
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CustomPopup.showError(errorMessage);
          });
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
