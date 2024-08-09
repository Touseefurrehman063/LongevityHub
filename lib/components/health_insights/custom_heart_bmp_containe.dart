import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBmpContainer extends StatelessWidget {
  final double width;
  final double height;
  final double scale;
  final Color color;
  final String image;
  final String text;
  final String unitText;
  final String headingtext;

  const CustomBmpContainer({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    required this.image,
    required this.text,
    required this.headingtext,
    required this.unitText,
    this.scale = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        // border: Border.all(color: const Color.fromARGB(255, 207, 205, 205)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: Get.height * 0.015,
          ),
          Image.asset(
            image,
            scale: scale,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * .05,
              ),
              Text(
                headingtext,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            unitText,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
