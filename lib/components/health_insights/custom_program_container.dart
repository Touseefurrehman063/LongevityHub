// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/models/gym_memberships_model/get_gym_video_model.dart';
import 'package:longevity_hub/screens/gym_membership_screens/workout_detail_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class CustomProgramContainer extends StatefulWidget
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

  const CustomProgramContainer({
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
  }) : super(key: key);

  @override
  _CustomProgramContainerState createState() => _CustomProgramContainerState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomProgramContainerState extends State<CustomProgramContainer> {
  final double _value = 1.5;
  final double _maxRating = 2.0;
  VideoData? videoData;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => WorkOutDetailScreen(
              videoData: videoData!,
            ));
      },
      child: Stack(
        children: [
          Container(
            // padding: EdgeInsets.only(left: Get.width * 0.001),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.trailingImage,
                      scale: 8,
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
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
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
                                AppImages.playIcon,
                                scale: 9,
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
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          SizedBox(
                            width: Get.width * 0.39,
                            child: ExtensionProgressIndicator(
                              value: _value,
                              maxRating: _maxRating,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExtensionProgressIndicator extends StatelessWidget {
  const ExtensionProgressIndicator({
    Key? key,
    required this.value,
    required this.maxRating,
  }) : super(key: key);

  final double value;
  final double maxRating;

  @override
  Widget build(BuildContext context) {
    double progress = maxRating > 0 ? value / maxRating : 0.0;
    if (progress.isNaN || progress.isInfinite) {
      progress = 0.0;
    }

    return Row(
      children: [
        Expanded(
          flex: 15,
          child: Stack(
            children: [
              LinearProgressIndicator(
                value: progress,
                minHeight: 5,
                backgroundColor: const Color.fromARGB(255, 185, 184, 184),
                borderRadius: BorderRadius.circular(16),
                valueColor: AlwaysStoppedAnimation(
                  Color.lerp(
                    const Color(0xffececec),
                    const Color(0xffececec),
                    progress,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
