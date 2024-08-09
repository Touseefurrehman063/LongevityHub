import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:longevity_hub/helpers/color_manager.dart';

class CustomPopupAttention {
  static void showError(String message) {
    Get.defaultDialog(
      title: "attention".tr,
      middleText: message,
      backgroundColor: Colors.white,
      titleStyle: const TextStyle(color: ColorManager.kPrimaryColor),
      middleTextStyle: const TextStyle(color: Colors.black),
      textConfirm: "ok".tr,
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        Get.back();
      },
    );
  }
}
