import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class CommunityDashboard extends StatelessWidget {
  const CommunityDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.438,
      height: Get.height * 0.2, // Ensure height is explicitly set
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(AppImages.communityDashboard),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.03,
          vertical: Get.height * 0.015,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust alignment
          children: [
            SizedBox(
              height: Get.height * 0.06,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "community".tr,
                    style: GoogleFonts.poppins(
                      // height: 1.0,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.kHeatlthOrange,
                    ),
                  ),
                  Row(
                    // Adjust alignment
                    children: [
                      Text(
                        "center".tr,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          height: 1,
                          color: ColorManager.kWhiteColor,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                      // Image.asset(
                      //   AppImages.nextArrow,
                      //   color: ColorManager.kWhiteColor,
                      //   scale: 16,
                      // ),
                      const Icon(
                        Icons.arrow_forward,
                        color: ColorManager.kWhiteColor,
                        weight: 10,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Image.asset(
              AppImages.community,
              height: Get.height * 0.07, // Set height explicitly
            ),
          ],
        ),
      ),
    );
  }
}
