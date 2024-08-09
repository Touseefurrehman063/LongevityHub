import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/subscritpion_screens/subscription_plan_screen.dart';

class CustomAttentionPopup {
  static void showError(String message) {
    Get.dialog(
      AlertDialog(
        title: Text(
          "attention".tr,
          style: const TextStyle(color: ColorManager.kPrimaryColor),
        ),
        content: Text(
          message,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              "cancel".tr,
              style: const TextStyle(color: ColorManager.kblackColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.to(() => const SubscriptionPlanScreen());
            },
            child: Text(
              "updatepackage".tr,
              style: const TextStyle(color: ColorManager.kPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
