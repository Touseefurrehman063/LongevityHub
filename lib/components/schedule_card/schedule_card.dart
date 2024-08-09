// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/helpers/color_manager.dart';

class ScheduleCard extends StatefulWidget implements PreferredSizeWidget {
  final String centerText;
  final String centerText2;
  final String buttontext;
  final String dateTimeText;
  final String centerText3;
  final String statustext;
  final Color? bkColor;
  final String trailingImage;

  const ScheduleCard({
    Key? key,
    required this.centerText,
    this.bkColor,
    required this.centerText2,
    required this.buttontext,
    required this.trailingImage,
    required this.dateTimeText,
    required this.centerText3,
    required this.statustext,
  }) : super(key: key);

  @override
  _ScheduleCardState createState() => _ScheduleCardState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ScheduleCardState extends State<ScheduleCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.to(() => const BookingDetailScreen());
      },
      child: Container(
        decoration: ShapeDecoration(
          color: const Color(0xFF2C2C2E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    widget.trailingImage,
                    scale: 8,
                  ),
                  SizedBox(
                    width: Get.width * 0.04,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.centerText,
                            style: GoogleFonts.poppins(
                                color: ColorManager.kWhiteColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: Get.width * 0.03),
                          CustomButton(
                            buttonheight: Get.height * 0.025,
                            backgroundColor: ColorManager.kPrimaryColor,
                            buttonwidth: Get.width * 0.1,
                            onPress: () {
                              // Get.to(() => const SelectDisease());
                            },
                            mywidget: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.buttontext,
                                  style: GoogleFonts.poppins(
                                      color: ColorManager.kblackColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            radius: 8,
                          ),
                          SizedBox(
                            width: Get.width * 0.04,
                          ),
                        ],
                      ),
                      Text(
                        widget.centerText2,
                        style: GoogleFonts.poppins(
                            color: ColorManager.kWhiteColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            widget.centerText3,
                            style: GoogleFonts.poppins(
                                color: ColorManager.kPrimaryColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(width: Get.width * 0.14),
                        ],
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
