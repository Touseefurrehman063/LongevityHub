// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class CustomExerciseContainer extends StatefulWidget
    implements PreferredSizeWidget {
  final String centerText;

  final String centerText2;
  final String clientText;
  final String rowText;
  final String centerText3;
  final String statustext;
  final Color? bkColor;
  final ImageProvider trailingImage;
  final String timingtext;
  final String amText;
  final String pmText;
  final VoidCallback onPress;

  const CustomExerciseContainer({
    Key? key,
    required this.centerText,
    this.bkColor,
    required this.centerText2,
    required this.trailingImage,
    required this.centerText3,
    required this.statustext,
    required this.clientText,
    required this.rowText,
    required this.amText,
    required this.timingtext,
    required this.pmText,
    required this.onPress,
  }) : super(key: key);

  @override
  _CustomExerciseContainerState createState() =>
      _CustomExerciseContainerState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomExerciseContainerState extends State<CustomExerciseContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPress,
      //  () {
      //   Get.to(() => const WorkOutDetailScreen());
      // },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: Get.width * 0.04),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: widget.trailingImage,
                      height: 100,
                    ),
                    SizedBox(
                      width: Get.width * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.015),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Get.width * 0.4,
                            child: Text(
                              widget.centerText,
                              style: GoogleFonts.poppins(
                                  color: ColorManager.kblackColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                AppImages.kCalimage,
                                scale: 6,
                              ),
                              SizedBox(
                                width: Get.width * 0.014,
                              ),
                              Text(
                                widget.centerText2,
                                style: GoogleFonts.poppins(
                                    color: ColorManager.kGreyColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              // Text(
                              //   "|",
                              //   style: GoogleFonts.poppins(
                              //       color: ColorManager.kGreyColor,
                              //       fontSize: 12,
                              //       fontWeight: FontWeight.w500),
                              // ),
                              // SizedBox(
                              //   width: Get.width * 0.02,
                              // ),
                              // Image.asset(
                              //   AppImages.timewatchimage,
                              //   scale: 6,
                              // ),
                              // SizedBox(
                              //   width: Get.width * 0.014,
                              // ),
                              // Text(
                              //   widget.centerText3,
                              //   style: GoogleFonts.poppins(
                              //       color: ColorManager.kGreyColor,
                              //       fontSize: 12,
                              //       fontWeight: FontWeight.w500),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Text(
                            widget.statustext,
                            style: GoogleFonts.poppins(
                                color: ColorManager.kblackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                const Divider(color: Color.fromARGB(255, 194, 193, 193)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
