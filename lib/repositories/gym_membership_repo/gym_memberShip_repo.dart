// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:longevity_hub/components/Profile/custom_popup.dart';
import 'package:longevity_hub/data/controller/gym_membership_controller/gym_membership_controller.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/models/gym_memberships_model/add_review_model.dart';
import 'package:longevity_hub/models/gym_memberships_model/get_catogery_model.dart';
import 'package:longevity_hub/models/gym_memberships_model/get_gym_model.dart';
import 'package:longevity_hub/models/gym_memberships_model/get_gym_video_model.dart';
import 'package:longevity_hub/models/gym_memberships_model/get_trainer_model.dart';
import 'package:longevity_hub/models/gym_memberships_model/review_model.dart';
import 'package:longevity_hub/screens/gym_membership_screens/trainers_review_screen.dart';
import 'package:longevity_hub/utils/constants.dart';
import 'package:http/http.dart' as http;

class GymMembershipRepo {
  getGyms() async {
    String? accessToken = await LocalDb().getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response =
          await http.get(Uri.parse(AppConstants.getGyms), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        GetGymModel responseData = GetGymModel.fromJson(result);
        if (responseData.status == 1) {
          GymMembershipController.i.updateIsLoading(false);
          GymMembershipController.i.getGyms(responseData.data);
          log(responseData.toJson().toString());
          return responseData.data;
        } else {
          CustomPopup.showError(responseData.status.toString());
          GymMembershipController.i.updateIsLoading(false);
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

  getGymTrainers(String gymId) async {
    String? accessToken = await LocalDb().getAccessToken();
    var body = {"GymId": gymId};
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(Uri.parse(AppConstants.getGymTrainers),
          headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        GetTrainersModel responseData = GetTrainersModel.fromJson(result);
        if (responseData.status == 1) {
          GymMembershipController.i.updateIsLoading(false);
          GymMembershipController.i.getTrainers(responseData.data);
          log(responseData.toJson().toString());
          return responseData.data;
        } else {
          // CustomPopup.showError(responseData.status.toString());
          GymMembershipController.i.updateIsLoading(false);
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

  getGymTrainersVideos(String? categoryId) async {
    String? accessToken = await LocalDb().getAccessToken();
    String? gymIds = await LocalDb().getSelectedGymId();
    // String? exerciseCatogeryId = await LocalDb().getSelectedGymCategoryId();
    var body = {
      "GymId": gymIds,
      "GymExerciseCategoryId": categoryId,
    };
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(Uri.parse(AppConstants.getGymTrainerVideo),
          headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        GetGymVideoModel responseData = GetGymVideoModel.fromJson(result);
        if (responseData.status == 1) {
          GymMembershipController.i.updateIsLoading(false);
          GymMembershipController.i.getGymVideo(responseData.data);
          log(responseData.toJson().toString());
          return responseData.data;
        } else {
          // CustomPopup.showError(responseData.status.toString());
          GymMembershipController.i.updateIsLoading(false);
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

  // gymExerciseCatagory() async {
  //   String? accessToken = await LocalDb().getAccessToken();
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $accessToken',
  //   };
  //   try {
  //     var response = await http.get(Uri.parse(AppConstants.gymExerciseCategory),
  //         headers: headers);
  //     if (response.statusCode == 200) {
  //       var result = jsonDecode(response.body);
  //       log('API Response: $result');
  //       GetGymModel responseData = GetGymModel.fromJson(result);
  //       if (responseData.status == 1) {
  //         GymMembershipController.i.updateIsLoading(false);
  //         GymMembershipController.i.getGyms(responseData.data);
  //         log(responseData.toJson().toString());
  //         return responseData.data;
  //       } else {
  //         CustomPopup.showError(responseData.status.toString());
  //         GymMembershipController.i.updateIsLoading(false);
  //       }
  //     } else {
  //       log('Error: Received status code ${response.statusCode}');
  //     }
  //   } catch (e, stackTrace) {
  //     log('Exception: $e');
  //     log('StackTrace: $stackTrace');
  //     // ToastManager.showToast(e.toString());
  //     GymMembershipController.i.updateIsLoading(false);
  //   }
  // }

  getVideoCatogery() async {
    String? accessToken = await LocalDb().getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.get(
          Uri.parse(AppConstants.getGymExerciseVideoCategory),
          headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        GymVideoCatogeryModel responseData =
            GymVideoCatogeryModel.fromJson(result);
        if (responseData.status == 1) {
          GymMembershipController.i.updateIsLoading(false);
          GymMembershipController.i.getCatogary(responseData.data);
          log(responseData.toJson().toString());
          return responseData.data;
        } else {
          CustomPopup.showError(responseData.status.toString());
          GymMembershipController.i.updateIsLoading(false);
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

  addGymTrainerReview(String ratings, String reviews, String trainersId) async {
    String? accessToken = await LocalDb().getAccessToken();
    String? userId = await LocalDb().getUserid();
    var body = {
      "TrainerId": trainersId,
      "UserId": userId,
      "Rating": ratings,
      "Description": reviews
    };
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(
          Uri.parse(AppConstants.addGymTrainerReview),
          headers: headers,
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        AddReviewModel responseData = AddReviewModel.fromJson(result);
        if (responseData.status == 1) {
          GymMembershipController.i.updateIsLoading(false);
          Get.to(() => TrainerReviewsScreen(
                trainerId: trainersId,
                ratings: ratings,
              ));

          log(responseData.toJson().toString());
          return responseData.status;
        } else {
          // CustomPopup.showError(responseData.status.toString());
          GymMembershipController.i.updateIsLoading(false);
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

  getGymTrainerReview(String trainersId) async {
    String? accessToken = await LocalDb().getAccessToken();
    String? userId = await LocalDb().getUserid();
    var body = {
      "TrainerId": trainersId,
      "UserId": userId,
    };
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getGymTrainerReview),
          headers: headers,
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        ReviewModel responseData = ReviewModel.fromJson(result);
        if (responseData.status == 1) {
          GymMembershipController.i.updateIsLoading(false);
          GymMembershipController.i.getReview(responseData.data);
          // Get.to(() => const TrainerReviewsScreen());
          log(responseData.toJson().toString());
          return responseData.status;
        } else {
          // CustomPopup.showError(responseData.status.toString());
          GymMembershipController.i.updateIsLoading(false);
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
}
