// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/helpers/color_manager.dart';

class CustomReviewCard extends StatefulWidget implements PreferredSizeWidget {
  final String centerText;
  final String centerText2;
  final String buttontext;
  final String dateTimeText;
  final String centerText3;
  final String statustext;
  final Color? bkColor;
  final Widget trailingImage;

  const CustomReviewCard({
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
  _CustomReviewCardState createState() => _CustomReviewCardState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomReviewCardState extends State<CustomReviewCard> {
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
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.02, horizontal: Get.width * 0.04),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: Get.width * 0.02,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: widget.trailingImage,
                      ),
                      SizedBox(
                        width: Get.width * 0.03,
                      ),
                      SizedBox(
                        width: Get.width * 0.25,
                        child: Text(
                          widget.centerText,
                          style: GoogleFonts.poppins(
                              color: ColorManager.kWhiteColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.01,
                      ),
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
                                  color: ColorManager.kWhiteColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        radius: 8,
                      ),
                      SizedBox(
                        width: Get.width * 0.16,
                      ),
                      Text(
                        widget.centerText2,
                        style: GoogleFonts.poppins(
                            color: ColorManager.kWhiteColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  SizedBox(
                    width: Get.width * 0.8,
                    child: Text(
                      widget.centerText3,
                      style: GoogleFonts.poppins(
                          color: ColorManager.kWhiteColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
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
