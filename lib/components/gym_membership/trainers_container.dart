// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class CustomTrainersContainer extends StatefulWidget
    implements PreferredSizeWidget {
  final String centerText;

  final String centerText2;
  final String clientText;
  final String rowText;
  final String centerText3;
  final String statustext;
  final Color? bkColor;
  final String trailingImage;
  final String timingtext;
  final String amText;
  final String pmText;
  final VoidCallback onTap;
  final VoidCallback onPress;

  const CustomTrainersContainer({
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
    required this.onTap,
    required this.onPress,
  }) : super(key: key);

  @override
  _CustomTrainersContainerState createState() =>
      _CustomTrainersContainerState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomTrainersContainerState extends State<CustomTrainersContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                width: 1.0, color: const Color.fromARGB(255, 229, 228, 228))),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        widget.trailingImage,
                        scale: 4,
                      ),
                      SizedBox(
                        width: Get.width * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Row(
                          //   children: [
                          //     Text(
                          //       widget.statustext,
                          //       style: GoogleFonts.poppins(
                          //           color: ColorManager.kGreyColor,
                          //           fontSize: 14,
                          //           fontWeight: FontWeight.w500),
                          //     ),
                          //     SizedBox(width: Get.width * 0.01),
                          //     Image.asset(
                          //       AppImages.onlineIcon,
                          //       scale: 10,
                          //     ),
                          //     SizedBox(width: Get.width * 0.3),
                          //     Image.asset(
                          //       AppImages.favourateIcon,
                          //       scale: 14,
                          //     ),
                          //   ],
                          // ),
                          Text(
                            widget.centerText,
                            style: GoogleFonts.poppins(
                                color: ColorManager.kblackColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                AppImages.experianceIcon,
                                scale: 10,
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
                              Image.asset(
                                AppImages.reviewIcon,
                                scale: 10,
                              ),
                              SizedBox(
                                width: Get.width * 0.014,
                              ),
                              Text(
                                widget.centerText3,
                                style: GoogleFonts.poppins(
                                    color: ColorManager.kGreyColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          // Container(
                          //   height: Get.height * 0.04,
                          //   width: Get.width * 0.52,
                          //   decoration: BoxDecoration(
                          //     color: const Color(0xffeeeeee),
                          //     borderRadius: BorderRadius.circular(12),
                          //   ),
                          //   child: Row(
                          //     children: [
                          //       SizedBox(
                          //         width: Get.width * 0.02,
                          //       ),
                          //       Text(
                          //         widget.clientText,
                          //         style: GoogleFonts.poppins(
                          //             color: Colors.blue,
                          //             fontSize: 8,
                          //             fontWeight: FontWeight.w500),
                          //       ),
                          //       SizedBox(
                          //         width: Get.width * 0.01,
                          //       ),
                          //       Text(
                          //         widget.rowText,
                          //         style: GoogleFonts.poppins(
                          //             color: ColorManager.kGreyColor,
                          //             fontSize: 8,
                          //             fontWeight: FontWeight.w500),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(),
                  // SizedBox(
                  //   height: Get.height * 0.01,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       widget.timingtext,
                  //       style: GoogleFonts.poppins(
                  //           color: ColorManager.kblackColor,
                  //           fontSize: 10,
                  //           fontWeight: FontWeight.w500),
                  //     ),
                  //     SizedBox(
                  //       width: Get.width * 0.01,
                  //     ),
                  //     // Text(
                  //     //   ":",
                  //     //   style: GoogleFonts.poppins(
                  //     //       color: ColorManager.kblackColor,
                  //     //       fontSize: 10,
                  //     //       fontWeight: FontWeight.w500),
                  //     // ),
                  //     SizedBox(
                  //       width: Get.width * 0.01,
                  //     ),
                  //     Text(
                  //       widget.amText,
                  //       style: GoogleFonts.poppins(
                  //           color: ColorManager.kblackColor,
                  //           fontSize: 10,
                  //           fontWeight: FontWeight.w500),
                  //     ),
                  //     SizedBox(
                  //       width: Get.width * 0.01,
                  //     ),
                  //     // Text(
                  //     //   "-",
                  //     //   style: GoogleFonts.poppins(
                  //     //       color: ColorManager.kblackColor,
                  //     //       fontSize: 10,
                  //     //       fontWeight: FontWeight.w500),
                  //     // ),
                  //     SizedBox(
                  //       width: Get.width * 0.01,
                  //     ),
                  //     Text(
                  //       widget.pmText,
                  //       style: GoogleFonts.poppins(
                  //           color: ColorManager.kblackColor,
                  //           fontSize: 10,
                  //           fontWeight: FontWeight.w500),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Center(
                    child: CustomButton(
                      buttonheight: Get.height * 0.045,
                      backgroundColor: ColorManager.kPrimaryColor,
                      buttonwidth: Get.width * 0.7,
                      onPress: widget.onPress,
                      mywidget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.buttonIcon,
                            scale: 8,
                          ),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          Text(
                            "beginTraining".tr,
                            style: GoogleFonts.poppins(
                                color: ColorManager.kWhiteColor, fontSize: 12),
                          ),
                        ],
                      ),
                      radius: 10,
                    ),
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
