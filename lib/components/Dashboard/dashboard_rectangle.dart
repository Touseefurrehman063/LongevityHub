import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';

// ignore: must_be_immutable
class DashboardRectangle extends StatelessWidget {
  String headingText;
  String subheadingText;
  Color headingColor;
  Color containerColor;
  String containerimage;
  DashboardRectangle(
      {required this.headingText,
      required this.subheadingText,
      required this.headingColor,
      required this.containerimage,
      required this.containerColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.438,
      decoration: BoxDecoration(
          color: containerColor, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.03, vertical: Get.height * 0.01),
        child: Row(
          children: [
            Container(
              height: Get.height * 0.07,
              width: Get.width * 0.15,
              decoration: BoxDecoration(
                color: headingColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  containerimage,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              width: Get.width * 0.04,
            ),
            // Text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  headingText,
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: headingColor),
                ),
                SizedBox(
                  height: Get.height * 0.0015,
                ),
                Text(
                  subheadingText,
                  style: GoogleFonts.poppins(
                      height: 1.0,
                      fontSize: 10,
                      color: ColorManager.kblackColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),

            // Image
          ],
        ),
      ),
    );
  }
}
