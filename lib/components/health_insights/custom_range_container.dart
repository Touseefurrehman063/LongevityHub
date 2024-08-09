import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomHeartRangeContainer extends StatelessWidget {
  final double width;
  final double height;
  final double squareheight;
  final double squarewidth;
  final double scale;
  final Color color;
  final Color contColor;
  final String image;
  final String waveImage;
  final String text;
  final String squaretext;
  final String unitText;
  final String headingtext;

  const CustomHeartRangeContainer({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    required this.image,
    required this.text,
    required this.headingtext,
    required this.unitText,
    required this.squaretext,
    required this.squareheight,
    required this.squarewidth,
    required this.contColor,
    required this.waveImage,
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
        border: Border.all(color: const Color.fromARGB(255, 207, 205, 205)),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    image,
                    scale: scale,
                  ),
                  // SizedBox(
                  //   width: Get.width * 0.02,
                  // ),
                  Text(
                    headingtext,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.015,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * .05,
                    ),
                    Text(
                      text,
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Get.width * .04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: contColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      height: Get.height * 0.03,
                      width: Get.width * 0.18,
                      child: Center(
                        child: Text(
                          unitText,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: Get.width * 0.01,
              ),
              Image.asset(
                waveImage,
                // scale: 3,
              )
            ],
          ),
          Positioned(
            // top: Get.height * 0.09,
            // right: Get.width * 0.23,
            top: squareheight,
            right: squarewidth,
            child: Container(
              padding: const EdgeInsets.all(4),
              child: Text(
                squaretext,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
