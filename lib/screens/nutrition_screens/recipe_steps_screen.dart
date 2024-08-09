// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/components/custom_nutrition_plan/custom_steps_indicator.dart';
import 'package:longevity_hub/data/controller/nutrition_controller/nutrition_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/nutrition_screens/recipe_complete_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:video_player/video_player.dart';

class RecipeStepsScreen extends StatefulWidget {
  final String steptext;
  const RecipeStepsScreen({super.key, required this.steptext});

  @override
  _RecipeStepsScreenState createState() => _RecipeStepsScreenState();
}

class _RecipeStepsScreenState extends State<RecipeStepsScreen> {
  @override
  void initState() {
    super.initState();
    NutritionController.i.videoPlayerController = VideoPlayerController.file(
      File('path/to/your/video.mp4'),
    );
    NutritionController.i.videoPlayerController.addListener(() {
      setState(() {
        NutritionController.i.isPlaying =
            NutritionController.i.videoPlayerController.value.isPlaying;
      });
    });
  }

  @override
  void dispose() {
    NutritionController.i.videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 200,
                child: Center(
                  child: NutritionController
                          .i.videoPlayerController.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: NutritionController
                              .i.videoPlayerController.value.aspectRatio,
                          child: VideoPlayer(
                              NutritionController.i.videoPlayerController),
                        )
                      : const CircularProgressIndicator(),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.05,
                left: MediaQuery.of(context).size.width * 0.03,
                child: IconButton(
                  icon:
                      const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.repeat_rounded),
                iconSize: 25,
                onPressed: () {
                  setState(() {
                    NutritionController.i.isPlaying
                        ? NutritionController.i.videoPlayerController.pause()
                        : NutritionController.i.videoPlayerController.play();
                  });
                },
              ),
              SizedBox(
                width: Get.width * 0.04,
              ),
              Image.asset(
                AppImages.back,
                scale: 15,
                color: Colors.black,
              ),
              SizedBox(
                width: Get.width * 0.04,
              ),
              IconButton(
                icon: Icon(NutritionController.i.isPlaying
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_fill),
                iconSize: 64,
                onPressed: () {
                  setState(() {
                    NutritionController.i.isPlaying
                        ? NutritionController.i.videoPlayerController.pause()
                        : NutritionController.i.videoPlayerController.play();
                  });
                },
              ),
              SizedBox(
                width: Get.width * 0.04,
              ),
              Image.asset(
                AppImages.forward,
                scale: 15,
                color: Colors.black,
              ),
              SizedBox(
                width: Get.width * 0.04,
              ),
              IconButton(
                icon: Icon(NutritionController.i.isMuted
                    ? Icons.volume_off
                    : Icons.volume_up),
                onPressed: () {
                  setState(() {
                    NutritionController.i.isMuted =
                        !NutritionController.i.isMuted;
                    NutritionController.i.videoPlayerController
                        .setVolume(NutritionController.i.isMuted ? 0 : 1);
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          StepIndicator(
            steps: 3,
            currentStep: NutritionController.i.currentStep,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Step 1",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: ColorManager.kblackColor,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                    'Add the chopped eggs to the mashed avocados. Season with salt and pepper to taste. Optionally, add a splash of lemon juice for extra flavor and chopped cilantro for freshness.',
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: ColorManager.kblackColor,
                        fontWeight: FontWeight.w400)),
                SizedBox(
                  height: Get.height * 0.2,
                )
              ],
            ),
          ),
          CustomButton(
            buttonheight: Get.height * 0.07,
            backgroundColor: ColorManager.kPrimaryColor,
            buttonwidth: Get.width * 0.75,
            onPress: () async {
              Get.offAll(() => const RecipeStepsCompleteScreen());
            },
            mywidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Next Step",
                  style: GoogleFonts.poppins(
                    color: ColorManager.kblackColor,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.01,
                ),
                Image.asset(
                  AppImages.nextArrow,
                  scale: 8,
                ),
              ],
            ),
            radius: 10,
          ),
        ],
      ),
    );
  }
}
