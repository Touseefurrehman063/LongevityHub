// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:logger_plus/logger_plus.dart';
import 'package:longevity_hub/components/Profile/custom_attention_popup.dart';
import 'package:longevity_hub/components/Profile/custom_popup.dart';
import 'package:longevity_hub/data/controller/subscription_controller/subscription_controller.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/models/subscription_model/get_expirydate_model.dart';
import 'package:longevity_hub/models/subscription_model/get_subscription_plan_model.dart';
import 'package:longevity_hub/screens/subscritpion_screens/subscription_screen.dart';
import 'package:longevity_hub/utils/constants.dart';
import 'package:http/http.dart' as http;

var logger = Logger();

class SubscriptionRepo {
  static updatePackageSubscriptionPlan() async {
    String? userId = await LocalDb().getUserid();
    String? accessToken = await LocalDb().getAccessToken();
    var chargeDetails = SubscriptionController
        .i.packages[SubscriptionController.i.selectedIndex].chargeDetails;
    var body = {
      'UserId': userId,
      'PackageSubscriptionPlanId': SubscriptionController.i.selectedPackageId,
      'PackagePriceDetailsId': chargeDetails[0].packagePriceDetailsId,
    };
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    logger.i('Request Body: ${jsonEncode(body)}');
    try {
      var response = await http.post(
          Uri.parse(AppConstants.updatePackageSubscriptionPlan),
          headers: headers,
          body: jsonEncode(body));
      // print(body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        if (result['Status'] == 1) {
          Get.to(() => const SubscriptionScreen());
        } else {
          log(result['Message'].toString());
          CustomPopup.showError(result['Message'].toString());
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('$e exception caught');
    }
  }

  static getPackageExpiryDate() async {
    String? userId = await LocalDb().getUserid();
    String? accessToken = await LocalDb().getAccessToken();
    var body = {
      'UserId': userId,
    };
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getUserPackagePlanExpireDate),
          headers: headers,
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        if (result['Status'] == 1) {
          // Get.to(() => const SubscriptionScreen());
          var data = result['Data'];
          List<ExpirydateData> expiryDateList = List<ExpirydateData>.from(
              data.map((item) => ExpirydateData.fromJson(item)));

          SubscriptionController.i.getexpirydateData(expiryDateList);
          return expiryDateList;
        } else {
          log(result['Message'].toString());
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('$e exception caught');
    }
  }

  static getPackageSubscriptionPlan() async {
    String? userId = await LocalDb().getUserid();
    String? accessToken = await LocalDb().getAccessToken();

    var body = {
      'UserId': userId,
    };

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getPackageSubscriptionPlan),
          headers: headers,
          body: jsonEncode(body));
      // print(body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        if (result['Status'] == 1) {
          List<PackageSubscriptionPlan> fetchedPackages =
              (result['Data'] as List)
                  .map((e) => PackageSubscriptionPlan.fromJson(e))
                  .toList();
          SubscriptionController.i.packages = fetchedPackages;
          // SubscriptionController.i.updatePackages();
        } else {
          log(result['Message'].toString());
          CustomPopup.showError(result['Message'].toString());
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('$e exception caught');
    }
  }

  static verifyModuleForUser(String value, Function onSuccessCallback) async {
    String? userId = await LocalDb().getUserid();
    String? accessToken = await LocalDb().getAccessToken();

    var body = {
      'UserId': userId,
      'PackageSubscriptionPlanId':
          SubscriptionController.i.packagePlanDate.isNotEmpty
              ? SubscriptionController
                  .i.packagePlanDate[0].packageSubscriptionPlanId
              : "",
      'Value': value,
    };
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    // Debugging

    try {
      var response = await http.post(
          Uri.parse(AppConstants.verifyModuleForUser),
          headers: headers,
          body: jsonEncode(body));

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          onSuccessCallback();
        } else {
          CustomAttentionPopup.showError(result['ErrorMessage'].toString());
          log(result['ErrorMessage'].toString());
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('$e exception caught');
    }
  }
}
// var logger = Logger(
//   printer: PrettyPrinter(
//     methodCount: 0, // number of method calls to be displayed
//     errorMethodCount: 5, // number of method calls if stacktrace is provided
//     lineLength: 120, // width of the output
//     colors: true, // Colorful log messages
//     printEmojis: true, // Print an emoji for each log message
//     printTime: false, // Should each log print contain a timestamp
//   ),
// );
