import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';

class WellBeingSquare extends StatelessWidget {
  final Color headingTextColor;
  final Color backgroundColor;
  final String headingText;
  final String subheadingText;
  final String image;

  const WellBeingSquare({
    required this.headingTextColor,
    required this.subheadingText,
    required this.headingText,
    required this.image,
    required this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.438,
      height: Get.height * 0.16,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.03,
          vertical: Get.height * 0.014,
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        headingText,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: headingTextColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Text(
                        subheadingText,
                        style: GoogleFonts.poppins(
                          fontSize: 8,
                          color: ColorManager.kblackColor,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(
                    left: Get.width * 0.07, top: Get.height * 0.03),
                child: FractionallySizedBox(
                  widthFactor: 0.55,
                  heightFactor: 1.27,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    // scale: 6,
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
