// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/subscritpion_screens/sub_planned_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class CustomReviewDetailCard extends StatefulWidget
    implements PreferredSizeWidget {
  final String centerText;
  final String centerText2;
  final String buttontext;
  final String dateTimeText;
  final String centerText3;
  final String statustext;
  final Color? bkColor;
  final String trailingImage;

  const CustomReviewDetailCard({
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
  _CustomReviewDetailCardState createState() => _CustomReviewDetailCardState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomReviewDetailCardState extends State<CustomReviewDetailCard> {
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
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    widget.trailingImage,
                    scale: 10,
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
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
                          SizedBox(width: Get.width * 0.01),
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
                            width: Get.width * 0.02,
                          ),
                          Visibility(
                            visible: widget.statustext != 'Booked',
                            child: Text(
                              widget.dateTimeText,
                              style: GoogleFonts.poppins(
                                  color: ColorManager.kWhiteColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600),
                            ),
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
                          CustomButton(
                            buttonheight: Get.height * 0.025,
                            backgroundColor:
                                _getBackgroundColor(widget.statustext),
                            buttonwidth: Get.width * 0.2,
                            onPress: () {
                              // Get.to(() => const SelectDisease());
                            },
                            mywidget: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.statustext,
                                  style: GoogleFonts.poppins(
                                      color: _getTextColor(widget.statustext),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            radius: 4,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: widget.statustext == 'Booked',
              child: Positioned(
                top: 4,
                right: 5,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    // decoration: BoxDecoration(
                    //   shape: BoxShape.circle,
                    //   color: Colors.black.withOpacity(0.5),
                    // ),
                    child: Image.asset(
                      AppImages.cross,
                      width: Get.width * 0.04,
                      // height: 12,
                      // color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color _getBackgroundColor(String status) {
  switch (status) {
    case 'Completed':
      return ColorManager.kgreenstatus;
    case 'Booked':
      return ColorManager.kyellowstatus;
    case 'Cancel':
      return ColorManager.kredstatus;
    default:
      return Colors.transparent;
  }
}

Color _getTextColor(String status) {
  switch (status) {
    case 'Completed':
      return ColorManager.kPrimaryLightGreenColor;
    case 'Booked':
      return ColorManager.kYellowGolden;
    case 'Cancel':
      return ColorManager.kredstatusText;
    default:
      return Colors.black; // Default text color
  }
}
