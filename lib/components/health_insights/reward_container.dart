import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';

class RewardContainer extends StatelessWidget {
  final String image;
  final String text;
  final String text2;
  final TextStyle? style;
  final double imageScale;
  final bool isLocked;

  const RewardContainer({
    Key? key,
    required this.image,
    required this.text,
    required this.text2,
    this.style,
    this.imageScale = 7.0,
    this.isLocked = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isLocked ? 0.4 : 1.0,
      child: Container(
        width: Get.width * 0.08,
        height: Get.height * 0.05,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color.fromARGB(255, 228, 227, 227)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              scale: imageScale,
            ),
            Text(
              text,
              style: style,
            ),
            Text(
              text2,
              style: GoogleFonts.poppins(
                fontSize: 6,
                color: ColorManager.kblackColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
