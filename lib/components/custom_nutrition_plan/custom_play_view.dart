import 'package:flutter/material.dart';
import 'package:longevity_hub/components/Profile/custom_popup.dart';
import 'package:longevity_hub/data/controller/nutrition_controller/nutrition_controller.dart';
// import 'package:longevity_hub/utils/utils.dart';
import 'package:video_player/video_player.dart';

playView(BuildContext context) {
  final controller = NutritionController.i.vcontroller;
  if (controller.value.isInitialized) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: VideoPlayer(controller),
    );
  } else {
    // Utils.toastMessage(
    //     "Being Initialized Please Wait", Colors.grey, Colors.white);
    CustomPopup.showError("Being Initialized Please Wait");
    return const AspectRatio(
      aspectRatio: 16 / 9,
      child: Text("Being Intilized please wait"),
    );
  }
}
