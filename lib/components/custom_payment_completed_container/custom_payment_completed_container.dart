// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class CustomPaymkentCompletedContainer extends StatefulWidget
    implements PreferredSizeWidget {
  final String centerText;
  final String centerText2;
  final String centerText3;
  final String centerText4;
  final String buttontext;
  final Color? bkColor;

  const CustomPaymkentCompletedContainer({
    Key? key,
    required this.centerText,
    this.bkColor,
    required this.centerText2,
    required this.centerText3,
    required this.centerText4,
    required this.buttontext,
  }) : super(key: key);

  @override
  _CustomPaymkentCompletedContainerState createState() =>
      _CustomPaymkentCompletedContainerState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomPaymkentCompletedContainerState
    extends State<CustomPaymkentCompletedContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: const Color(0xFF2C2C2E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(14.0), // Adjust padding as needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomButton(
                  buttonheight: Get.height * 0.025,
                  backgroundColor: ColorManager.kPrimaryColor,
                  buttonwidth: Get.width * 0.22,
                  onPress: () {
                    // Get.to(() => const SelectDisease());
                  },
                  mywidget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.buttontext,
                        style: GoogleFonts.poppins(
                            color: ColorManager.kWhiteColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  radius: 10,
                ),
                SizedBox(width: Get.width * 0.01),
                Text(
                  widget.centerText,
                  style: GoogleFonts.poppins(
                      color: ColorManager.kWhiteColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                  // Adjust font style as needed
                ),
                Text(
                  widget.centerText2,
                  style: GoogleFonts.poppins(
                      color: ColorManager.kWhiteColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w400),
                  // Adjust font style as needed
                ),
                const Divider(
                  color: ColorManager.kWhiteColor,
                  thickness: 3.0,
                ),
                SizedBox(height: Get.height * 0.01),
                Text(
                  "Date",
                  style: GoogleFonts.poppins(
                      color: ColorManager.kWhiteColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w400),
                  // Adjust font style as needed
                ),
                Text(
                  widget.centerText3,
                  style: GoogleFonts.poppins(
                      color: ColorManager.kWhiteColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                  // Adjust font style as needed
                ),
                SizedBox(height: Get.height * 0.02),
                Text(
                  "Time",
                  style: GoogleFonts.poppins(
                      color: ColorManager.kWhiteColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w400),
                  // Adjust font style as needed
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.centerText4,
                      style: GoogleFonts.poppins(
                          color: ColorManager.kWhiteColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                      // Adjust font style as needed
                    ),
                    SizedBox(
                      width: Get.width * 0.5,
                    ),
                    Image.asset(
                      AppImages.bell,
                      fit: BoxFit.contain,
                      height: Get.height * 0.03,
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
