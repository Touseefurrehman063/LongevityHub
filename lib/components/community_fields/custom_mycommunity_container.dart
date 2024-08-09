import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class CustomMyCommunityContainer extends StatelessWidget {
  final String text;
  final String heading;
  final String imageUrl;
  final VoidCallback onTap;

  const CustomMyCommunityContainer({
    required this.text,
    required this.heading,
    required this.imageUrl,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: Get.height * 0.3,
              width: Get.width * 0.48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border:
                    Border.all(color: const Color.fromARGB(255, 242, 239, 239)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height * 0.15),
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.04),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          heading,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          text,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: onTap,
                          child: Row(
                            children: [
                              Text(
                                'Chat',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: ColorManager.kPrimaryColor),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Image.asset(
                                AppImages.nextArrow,
                                color: ColorManager.kPrimaryColor,
                                scale: 10,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -Get.height * 0.075,
              left: Get.width * 0.03,
              child: Image.asset(
                imageUrl,
                scale: 6,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
