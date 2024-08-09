import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';

class CustomDynamicContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final String? image;
  final String? text;
  final String? steptext;
  final TextStyle? style;
  final Widget? indicator;
  final double? verticaltextheight;
  final double? sizedBoxheight;
  final double? horizentaltextwidth;
  final double? sizedBoxwidth;
  final double? paddingwidth;
  final double? sizedwidth;
  final double? stepheight;
  final double? stepwidth;
  final double? borderradius;

  const CustomDynamicContainer({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    this.image,
    this.text,
    this.style,
    this.indicator,
    this.verticaltextheight,
    this.horizentaltextwidth,
    this.sizedBoxheight,
    this.sizedBoxwidth,
    this.paddingwidth,
    this.sizedwidth,
    this.steptext,
    this.stepheight,
    this.stepwidth,
    this.borderradius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderradius ?? 22),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: verticaltextheight ?? 0.0,
            horizontal: horizentaltextwidth ?? 0.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          if (image != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingwidth ?? 0.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Image.asset(
                  image!,
                  scale: 7,
                ),
                SizedBox(
                  width: sizedwidth ?? 0.0,
                ),
                if (text != null)
                  Text(
                    text!,
                    style: style,
                  ),
              ]),
            ),
          if (image == null && text != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                text!,
                style: style,
              ),
            ),
          SizedBox(
            height: sizedBoxheight ?? 0.0,
            width: sizedBoxwidth ?? 0.0,
          ),
          if (steptext != null && steptext!.isNotEmpty)
            Text(steptext!,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: ColorManager.kblackColor,
                    fontWeight: FontWeight.w600)),
          SizedBox(
            height: stepheight ?? 0.0,
            width: stepwidth ?? 0.0,
          ),
          if (indicator != null) indicator!,
        ]),
      ),
    );
  }
}
