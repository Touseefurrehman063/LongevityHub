// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ExcerciseController extends GetxController implements GetxService {
  TextEditingController? searchcont = TextEditingController();
  String searchText = "";
  String selecetednutrition = "";
  late VideoPlayerController vcontroller;
  late VideoPlayerController videoPlayerController;
  bool isPlaying = false;
  bool isMuted = false;
  bool isrepeat = false;
  int currentStep = 1;
  String getContentForStep(int step) {
    switch (step) {
      case 1:
        return 'Step 1: Chop the eggs.';
      case 2:
        return 'Step 2: Add the chopped eggs to the mashed avocados. Season with salt and pepper to taste. Optionally, add a splash of lemon juice for extra flavor and chopped cilantro for freshness.';
      case 3:
        return 'Step 3: Serve and enjoy!';
      default:
        return '';
    }
  }

  static ExcerciseController get i => Get.put(ExcerciseController());
}
