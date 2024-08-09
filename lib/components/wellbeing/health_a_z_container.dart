import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';

class HealthAZContainer extends StatelessWidget {
  final String imagePath;
  final String heading;
  final String text;
  final Color color;
  final Color headingtextColor;
  final Color textColor;
  final double headingTextSize;
  final double textSize;
  final double verticalSize;

  const HealthAZContainer(
      {Key? key,
      required this.imagePath,
      required this.heading,
      required this.text,
      required this.color,
      this.textColor = ColorManager.kblackColor,
      this.headingtextColor = ColorManager.kGreyColor,
      this.headingTextSize = 13,
      this.textSize = 16,
      this.verticalSize = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.12,
      width: Get.width * 0.92,
      // padding: const EdgeInsets.all(20.0),
      // margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: Get.width * .04, top: Get.height * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              scale: 6,
            ),
            SizedBox(width: Get.width * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(vertical: verticalSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height * 0.02),
                  Text(
                    heading,
                    style: GoogleFonts.poppins(
                      fontSize: headingTextSize,
                      color: headingtextColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.5,
                    child: Text(
                      text,
                      style: GoogleFonts.poppins(
                        fontSize: textSize,
                        color: textColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
