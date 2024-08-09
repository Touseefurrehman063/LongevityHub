import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';

class NutritionCircularCategories extends StatelessWidget {
  final String text;
  final String image;

  const NutritionCircularCategories(
      {required this.text, required this.image, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey[200],
          backgroundImage: AssetImage(image),
        ),
        SizedBox(height: Get.height * 0.01),
        Text(
          text,
          style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.0,
              color: ColorManager.kblackColor),
        ),
      ],
    );
  }
}
