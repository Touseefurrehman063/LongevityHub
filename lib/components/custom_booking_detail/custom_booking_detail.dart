// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';

class CustomBookingDetailCard extends StatefulWidget
    implements PreferredSizeWidget {
  final String exptext;
  final String experiancetext;
  final String comtext;
  final String completedText;
  final String activetext;
  final String activeclienttext;

  const CustomBookingDetailCard({
    Key? key,
    required this.exptext,
    required this.experiancetext,
    required this.comtext,
    required this.completedText,
    required this.activeclienttext,
    required this.activetext,
  }) : super(key: key);

  @override
  _CustomBookingDetailCardState createState() =>
      _CustomBookingDetailCardState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomBookingDetailCardState extends State<CustomBookingDetailCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.to(() => const SubscribePlannedScreen());
      },
      child: Container(
        decoration: ShapeDecoration(
          color: const Color(0xFF2C2C2E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(22.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.exptext,
                        style: GoogleFonts.poppins(
                            color: ColorManager.kWhiteColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                      Text(
                        widget.experiancetext,
                        style: GoogleFonts.poppins(
                            color: ColorManager.kWhiteColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(width: Get.width * 0.14),
                    ],
                  ),
                  SizedBox(
                    width: Get.width * 0.04,
                  ),
                  SizedBox(
                    height: Get.height * 0.06,
                    child: const VerticalDivider(
                      thickness: 1,
                      color: Color.fromARGB(255, 67, 66, 66),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.04,
                  ),
                  Column(
                    children: [
                      Text(
                        widget.comtext,
                        style: GoogleFonts.poppins(
                            color: ColorManager.kWhiteColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        widget.completedText,
                        style: GoogleFonts.poppins(
                            color: ColorManager.kWhiteColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: Get.width * 0.04,
                  ),
                  SizedBox(
                    height: Get.height * 0.06,
                    child: const VerticalDivider(
                      thickness: 1,
                      color: Color.fromARGB(255, 67, 66, 66),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.04,
                  ),
                  Column(
                    children: [
                      Text(
                        widget.activetext,
                        style: GoogleFonts.poppins(
                            color: ColorManager.kWhiteColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        widget.activeclienttext,
                        style: GoogleFonts.poppins(
                            color: ColorManager.kWhiteColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
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
