// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/subscritpion_screens/sub_planned_screen.dart';

class CustomSubscribeContainer extends StatefulWidget
    implements PreferredSizeWidget {
  final String centerText;
  final String centerText2;
  final String buttontext;
  final Color? bkColor;

  const CustomSubscribeContainer({
    Key? key,
    required this.centerText,
    this.bkColor,
    required this.centerText2,
    required this.buttontext,
  }) : super(key: key);

  @override
  _CustomSubscribeContainerState createState() =>
      _CustomSubscribeContainerState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomSubscribeContainerState extends State<CustomSubscribeContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => const SubscribePlannedScreen());
      },
      child: Container(
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
