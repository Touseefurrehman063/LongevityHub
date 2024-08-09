// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/helpers/color_manager.dart';

class CustomPlannedsubContainer extends StatefulWidget
    implements PreferredSizeWidget {
  final String centerText;
  final String centerText2;
  final String buttontext;
  final Color? bkColor;
  final BoxBorder? border;
  final EdgeInsetsGeometry? padding;

  const CustomPlannedsubContainer({
    Key? key,
    required this.centerText,
    this.bkColor,
    required this.centerText2,
    required this.buttontext,
    this.border,
    this.padding,
  }) : super(key: key);

  @override
  _CustomPlannedsubContainerState createState() =>
      _CustomPlannedsubContainerState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomPlannedsubContainerState extends State<CustomPlannedsubContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.to(() => const SubscribePlannedScreen());
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), border: widget.border),
        child: Container(
          padding: widget.padding, // Adjust padding as needed
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
                        color: ColorManager.kblackColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                    // Adjust font style as needed
                  ),
                  Text(
                    widget.centerText2,
                    style: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
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
