// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';

class DashboardBeautiyCard extends StatelessWidget {
  Color containerColor;
  String headingText;
  String subheadingText;
  String image;
  DashboardBeautiyCard(
      {required this.containerColor,
      required this.headingText,
      required this.subheadingText,
      required this.image,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.27,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.only(
            left: Get.width * 0.03,
            right: Get.width * 0.03,
            top: Get.height * 0.015),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              headingText,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                  color: ColorManager.kblackColor),
            ),
            SizedBox(
              height: Get.height * 0.004,
            ),
            Text(
              subheadingText,
              style: GoogleFonts.poppins(
                fontSize: 10,
                height: 1.0,
                color: ColorManager.kblackColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                scale: 5,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
