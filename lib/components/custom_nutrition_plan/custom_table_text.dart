import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';

class CustomText extends StatelessWidget {
  final String text1;
  final String text2;

  const CustomText({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: ColorManager.kblackColor,
          ),
        ),
        Text(
          text2,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: ColorManager.kblackColor,
          ),
        ),
      ],
    );
  }
}
