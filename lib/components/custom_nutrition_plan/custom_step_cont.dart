import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/nutrition_screens/recipe_steps_screen.dart';

class NutritionStepsContainer extends StatelessWidget {
  final String text1;

  const NutritionStepsContainer({super.key, required this.text1});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.to(() => const RecipeStepsScreen(
                steptext: "text1",
              ));
        },
        child: Container(
          width: 318,
          height: 57,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorManager.kPrimaryColor, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text1,
                  style: GoogleFonts.poppins(
                    color: ColorManager.kPrimaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
