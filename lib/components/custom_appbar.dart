// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? trailingImage;
  final String centerText;
  final VoidCallback? leadingOnPressed;
  Color? backgroundcolor;

  CustomAppBar({
    Key? key,
    required this.centerText,
    this.trailingImage,
    this.leadingOnPressed,
    this.backgroundcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundcolor ?? Colors.white,
      leading: InkWell(
          onTap: leadingOnPressed,
          child: Image.asset(
            AppImages.backArrow,
            scale: 10,
            color: ColorManager.kblackColor,
          )),
      title: Text(
        centerText,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorManager.kblackColor),
      ),
      centerTitle: true,
      actions: <Widget>[if (trailingImage != null) trailingImage!],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
