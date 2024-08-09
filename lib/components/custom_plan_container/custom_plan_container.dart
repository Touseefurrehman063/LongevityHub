// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class CustomPlanContainer extends StatelessWidget {
  final String centerText;

  const CustomPlanContainer({
    Key? key,
    required this.centerText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.to(() => const SubscriptionPlanScreen());
      },
      child: Container(
        child: Row(
          children: [
            Image.asset(
              AppImages.subscheckbox,
              // color: ColorManager.kPrimaryColor,
              width: Get.width * 0.04, // Adjust image size as needed
            ),
            SizedBox(width: Get.width * 0.02), // Adjust spacing as needed
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  centerText,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Adjust spacing as needed
              ],
            ),
          ],
        ),
      ),
    );
  }
}
