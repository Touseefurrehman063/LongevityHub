import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class SelectGymContainer extends StatelessWidget {
  final String? gymId;
  final String? logoImage;
  final String headingText;
  final String descriptionText;
  final String subscriptionText;
  final String detailText;
  final String? gymImage;
  final VoidCallback onPress;

  const SelectGymContainer({
    Key? key,
    required this.gymId,
    required this.headingText,
    required this.logoImage,
    required this.descriptionText,
    required this.gymImage,
    required this.subscriptionText,
    required this.detailText,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.6,
      width: Get.width * 0.8,
      decoration: BoxDecoration(
        color: ColorManager.kWhiteColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
              image: DecorationImage(
                image: AssetImage(AppImages.contimg),
                fit: BoxFit.cover,
              ),
            ),
            height: Get.height * 0.28,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * .06, vertical: Get.height * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        logoImage!,
                        scale: 10,
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      SizedBox(
                        width: Get.width * 0.3,
                        child: Text(
                          headingText,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: ColorManager.kWhiteColor,
                              fontWeight: FontWeight.w900),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      SizedBox(
                        width: Get.width * 0.3,
                        child: Text(
                          descriptionText,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: ColorManager.kWhiteColor,
                              fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      gymImage!,
                      scale: 4,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.06,
          ),
          Text(
            subscriptionText,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 16,
                color: ColorManager.kblackColor,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Text(
            detailText,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 12,
                color: ColorManager.kblackColor,
                fontWeight: FontWeight.w400),
            maxLines: 2,
          ),
          SizedBox(
            height: Get.height * 0.06,
          ),
          Center(
            child: CustomButton(
              buttonheight: Get.height * 0.07,
              backgroundColor: ColorManager.kPrimaryColor,
              buttonwidth: Get.width * 0.65,
              onPress: onPress,
              mywidget: Text(
                "selectgym".tr,
                style: GoogleFonts.poppins(
                    color: ColorManager.kWhiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w800),
              ),
              radius: 2,
            ),
          ),
        ],
      ),
    );
  }
}
