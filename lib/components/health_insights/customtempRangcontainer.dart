// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class CustomTempRangeContainer extends StatelessWidget {
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

  const CustomTempRangeContainer({
    Key? key,
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
  }) : super(key: key);

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
              Padding(
                padding: EdgeInsets.only(left: Get.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      image,
                      scale: scale,
                    ),
                    SizedBox(
                      width: Get.width * 0.03,
                    ),
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
            left: Get.width * 0.16,
            top: Get.height * 0.135,
            child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text(squaretext)),
          ),
          Positioned(
            right: Get.width * 0.02,
            top: Get.height * 0.01,
            child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Image.asset(
                  AppImages.cross,
                  scale: 6,
                )),
          ),
        ],
      ),
    );
  }
}
