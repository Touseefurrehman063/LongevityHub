// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';

class SignupOrLoginText extends StatelessWidget {
  final Function()? onTap;
  final String? pre;
  final String? suffix;
  const SignupOrLoginText({
    super.key,
    this.pre,
    this.suffix,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$pre',
          style: GoogleFonts.poppins(
              fontSize: 15,
              color: ColorManager.kblackColor,
              fontWeight: FontWeight.w400),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            '$suffix',
            style: GoogleFonts.poppins(
                fontSize: 15,
                color: ColorManager.kPrimaryDarkGreenColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
