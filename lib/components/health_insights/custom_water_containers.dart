import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';

class CustomWaterContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final String image;
  final String text;
  final String headingtext;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomWaterContainer({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    required this.image,
    required this.text,
    required this.headingtext,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.kLightWater : color,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color.fromARGB(255, 207, 205, 205)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(height: Get.height * .05, width: Get.width * 0.05),
                Text(
                  headingtext,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Row(
              children: [
                SizedBox(height: Get.height * .05, width: Get.width * 0.05),
                Text(
                  text,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.09,
                ),
                image.startsWith('http') || image.startsWith('https')
                    ? Image.network(
                        image,
                        height: Get.height * 0.025,
                        width: Get.width * 0.08,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        image,
                        scale: 8,
                        fit: BoxFit.cover,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
