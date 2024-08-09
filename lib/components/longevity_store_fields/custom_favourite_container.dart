// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class CustomFavouriteContainer extends StatefulWidget
    implements PreferredSizeWidget {
  final String centerText;

  final String centerText2;
  final String rowText;
  final String centerText3;
  final String trailingImage;

  const CustomFavouriteContainer({
    Key? key,
    required this.centerText,
    required this.centerText2,
    required this.trailingImage,
    required this.centerText3,
    required this.rowText,
  }) : super(key: key);

  @override
  _CustomFavouriteContainerState createState() =>
      _CustomFavouriteContainerState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomFavouriteContainerState extends State<CustomFavouriteContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.to(() => const TrainersInfoScreen());
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                width: 1.0, color: const Color.fromARGB(255, 247, 245, 245))),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        widget.trailingImage,
                        scale: 6,
                      ),
                      SizedBox(
                        width: Get.width * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.centerText,
                                style: GoogleFonts.poppins(
                                    color: ColorManager.kblackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: Get.width * 0.38,
                              ),
                              Image.asset(
                                AppImages.deleteFav,
                                scale: 12,
                              )
                            ],
                          ),
                          Text(
                            widget.centerText2,
                            style: GoogleFonts.poppins(
                                color: const Color.fromARGB(255, 195, 192, 192),
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Row(
                            children: [
                              Text(
                                widget.centerText3,
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: Get.width * 0.2,
                              ),
                              Row(
                                children: [
                                  Text(
                                    widget.rowText,
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  Image.asset(
                                    AppImages.incrementImage,
                                    scale: 6,
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
