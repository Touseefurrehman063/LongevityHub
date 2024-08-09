import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';

class CategoryContainer extends StatelessWidget {
  final String image;
  final String heading;
  final String text1;
  final String iconImage;
  final String text2;
  final VoidCallback ontap;

  const CategoryContainer({
    Key? key,
    required this.image,
    required this.heading,
    required this.text1,
    required this.iconImage,
    required this.text2,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return InkWell(
          onTap: ontap,
          child: Padding(
            padding: EdgeInsets.only(left: Get.width * .05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width * 0.28,
                  height: Get.height * 0.065,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      scale: 8,
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                Text(
                  heading,
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: ColorManager.kblackColor,
                      fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                // SizedBox(height: Get.height * 0.005),
                Html(
                  data: text1,
                  style: {
                    "body": Style(
                      fontSize: FontSize(9),
                      color: ColorManager.kblackColor,
                      fontWeight: FontWeight.w300,
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  },
                ),
                // SizedBox(height: Get.height * 0.01),
                Row(
                  children: [
                    Image.asset(
                      iconImage,
                      fit: BoxFit.cover,
                      scale: 10,
                    ),
                    SizedBox(width: Get.width * 0.015),
                    Text(
                      text2,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: ColorManager.kblackColor,
                        decoration: TextDecoration.underline,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
