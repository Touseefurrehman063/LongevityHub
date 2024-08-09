// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';

class DashboardSquare extends StatelessWidget {
  Color headingTextColor;
  Color containerColor;
  String headingText;
  String subheadingText;
  String image;
  DashboardSquare(
      {required this.headingTextColor,
      required this.subheadingText,
      required this.headingText,
      required this.image,
      required this.containerColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.438,
      height: Get.height * 0.2,
      decoration: BoxDecoration(
          color: containerColor, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.03, vertical: Get.height * 0.015),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.1,
              child: Image.asset(
                image,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Text(
              headingText,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: headingTextColor),
            ),
            SizedBox(
              height: Get.height * 0.005,
            ),
            Text(
              subheadingText,
              style: GoogleFonts.poppins(
                height: 1.0,
                fontSize: 10,
                color: ColorManager.kblackColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
