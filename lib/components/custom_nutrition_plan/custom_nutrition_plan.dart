// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/nutrition_screens/food_detail_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class CustomNutritionContainer extends StatefulWidget
    implements PreferredSizeWidget {
  final String? ricepeText;
  final String dietText;
  final String caltext;
  final String timetext;
  final String? image;
  final Color? bkColor;

  const CustomNutritionContainer({
    Key? key,
    required this.dietText,
    this.bkColor,
    required this.caltext,
    required this.timetext,
    this.ricepeText,
    this.image,
  }) : super(key: key);

  @override
  _CustomNutritionContainerState createState() =>
      _CustomNutritionContainerState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomNutritionContainerState extends State<CustomNutritionContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => FoodDetail(image: widget.image, text: widget.ricepeText));
      },
      child: SizedBox(
        height: Get.height * 0.15,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                widget.image!,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 20),
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: Get.width * 0.01),
                            Text(
                              widget.dietText,
                              style: GoogleFonts.poppins(
                                  color: ColorManager.kWhiteColor,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  AppImages.kCalimage,
                                  scale: 7,
                                ),
                                SizedBox(width: Get.width * 0.01),
                                Text(
                                  widget.caltext,
                                  style: GoogleFonts.poppins(
                                      color: ColorManager.kWhiteColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(width: Get.width * 0.01),
                                Text(
                                  "|",
                                  style: GoogleFonts.poppins(
                                      color: ColorManager.kWhiteColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: Get.width * 0.01),
                                Image.asset(
                                  AppImages.timewatchimage,
                                  scale: 7,
                                ),
                                SizedBox(width: Get.width * 0.01),
                                Text(
                                  widget.timetext,
                                  style: GoogleFonts.poppins(
                                      color: ColorManager.kWhiteColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 15.0,
              right: 15.0,
              child: InkWell(
                onTap: () {},
                child: Image.asset(
                  AppImages.nutritionicon,
                  scale: 7,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
