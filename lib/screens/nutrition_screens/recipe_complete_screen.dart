import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/nutrition_screens/nutrition_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class RecipeStepsCompleteScreen extends StatelessWidget {
  const RecipeStepsCompleteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.recipePic),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          // Text in the middle of the screen

          Center(
            child: Text(
              "Congrats!",
              style: GoogleFonts.poppins(
                  fontSize: 25,
                  color: ColorManager.kWhiteColor,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: Get.width * 0.06, top: Get.height * 0.1),
            child: Center(
              child: Text(
                "You've successfully completed the recipe.\n   Enjoy your delicious Keto/Paleo dish!!",
                style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: ColorManager.kWhiteColor,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: Get.width * 0.33, top: Get.height * 0.2),
            child: Center(
              child: Row(
                children: [
                  Image.asset(
                    AppImages.kCalimage,
                    scale: 4,
                  ),
                  SizedBox(width: Get.width * 0.01),
                  Text(
                    "135 kcal",
                    style: GoogleFonts.poppins(
                        color: ColorManager.kWhiteColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(width: Get.width * 0.04),
                  Image.asset(
                    AppImages.timewatchimage,
                    scale: 4,
                  ),
                  SizedBox(width: Get.width * 0.01),
                  Text(
                    "30 min",
                    style: GoogleFonts.poppins(
                        color: ColorManager.kWhiteColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: CustomButton(
                buttonheight: Get.height * 0.07,
                backgroundColor: ColorManager.kPrimaryColor,
                buttonwidth: Get.width * 0.75,
                onPress: () {
                  Get.to(() => const NutritionScreen());
                },
                mywidget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Done",
                      style: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                radius: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
