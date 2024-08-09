// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class DashboardSupport extends StatelessWidget {
  const DashboardSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.361,
      width: Get.width * 1,
      decoration: const BoxDecoration(color: ColorManager.kDashboardgrey),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.03, horizontal: Get.width * 0.05),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DashboardContainer(
                    image: AppImages.vitalMonitor,
                    title: "AI Vital Monitoring",
                    subtitle:
                        "95% accuracy compared\nto a medical grade device."),
                DashboardContainer(
                    image: AppImages.diffLanguages,
                    title: "Supported Languages",
                    subtitle: "Supported in 2 languages:\nEnglish and Arabic"),
              ],
            ),
            SizedBox(
              height: Get.height * 0.015,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DashboardContainer(
                    image: AppImages.disease,
                    title: "Disease Directory",
                    subtitle: "4000+ Disease articles\n& Videos."),
                DashboardContainer(
                    image: AppImages.securepayments,
                    title: "Secure Payments",
                    subtitle: "100% Safe & encrypted\ntransactions."),
              ],
            ),
            SizedBox(
              height: Get.height * 0.015,
            ),
            DashboardContainer2(
                image: AppImages.helpSupport,
                title: "Help & Customer Support",
                subtitle: "For help or queries call over Customer\nSupport"),
          ],
        ),
      ),
    );
  }
}

class DashboardContainer extends StatelessWidget {
  String image;
  String title;
  String subtitle;

  DashboardContainer(
      {required this.image,
      required this.title,
      required this.subtitle,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.085,
      width: Get.width * 0.435,
      decoration: BoxDecoration(
        color: ColorManager.kWhiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.015, horizontal: Get.width * 0.02),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.025,
                  child: Image.asset(
                    image,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: Get.width * 0.02,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                      color: ColorManager.kblackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 10),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    color: ColorManager.kblackColor,
                    fontSize: 8,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardContainer2 extends StatelessWidget {
  String image;
  String title;
  String subtitle;

  DashboardContainer2(
      {required this.image,
      required this.title,
      required this.subtitle,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.1,
      decoration: BoxDecoration(
        color: ColorManager.kWhiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.015, horizontal: Get.width * 0.02),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.025,
                  child: Image.asset(
                    image,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: Get.width * 0.02,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                      color: ColorManager.kblackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    color: ColorManager.kblackColor,
                    fontSize: 10,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            SizedBox(
              width: Get.width * 0.04,
            ),
            SizedBox(
              width: Get.width * 0.2,
              child: Column(
                children: [
                  CustomButton(
                      buttonheight: Get.height * 0.04,
                      backgroundColor: ColorManager.kPrimaryColor,
                      buttonwidth: Get.width * 0.2,
                      onPress: () {},
                      radius: 10,
                      mywidget: Center(
                        child: Text(
                          "Call Now",
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: ColorManager.kWhiteColor),
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
