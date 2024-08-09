import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/health_insights_screens/water_detail_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class TodayWaterScreen extends StatefulWidget {
  const TodayWaterScreen({super.key});

  @override
  State<TodayWaterScreen> createState() => _TodayWaterScreenState();
}

class _TodayWaterScreenState extends State<TodayWaterScreen> {
  String? username;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    String? fetchedUsername = await LocalDb().getUsername();
    setState(() {
      username = fetchedUsername;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Image.asset(
            AppImages.backArrow,
            scale: 10,
            color: ColorManager.kblackColor,
          ),
        ),
        title: Text(
          "water".tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: ColorManager.kblackColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.01,
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Center(
                    child: Text(
                      "${"today".tr} - 16 Feb",
                      style: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Center(
                    child: Text(
                      "${"hi".tr}, ${username ?? ""}",
                      style: GoogleFonts.poppins(
                        color: ColorManager.kGreyColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Image.asset(
                    AppImages.sadEmoji,
                    scale: 10,
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Container(
                    height: Get.height * 0.4,
                    width: Get.width * 0.85,
                    decoration: BoxDecoration(
                      color: ColorManager.kLightBlue,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: ColorManager.kLightWater),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: Get.width * 0.1, top: Get.height * 0.07),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "oop".tr,
                            style: GoogleFonts.poppins(
                              color: ColorManager.kblackColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Text(
                            "${username ?? ""} ${"hasnotachieve".tr}",
                            style: GoogleFonts.poppins(
                              color: ColorManager.kblackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          Text(
                            "successisnotfinal".tr,
                            style: GoogleFonts.poppins(
                              color: ColorManager.kblackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Center(
                    child: CustomButton(
                      buttonheight: Get.height * 0.07,
                      backgroundColor: ColorManager.kPrimaryColor,
                      buttonwidth: Get.width * 0.75,
                      onPress: () async {
                        Get.to(() => const WaterDetailScreen());
                      },
                      mywidget:
                          // AuthController
                          //             .i.isLoading ==
                          //         true
                          //     ? const CircularProgressIndicator(
                          //         color: Colors.white,
                          //       )
                          //     :
                          Text(
                        "tryagain".tr,
                        style: GoogleFonts.poppins(
                            color: ColorManager.kblackColor, fontSize: 20),
                      ),
                      radius: 10,
                    ),
                  ),
                ],
              ),
              Positioned(
                top: Get.height * 0.23,
                left: Get.width * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 5.0),
                    Image.asset(
                      AppImages.confetti,
                      scale: 8,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: Get.height * 0.5,
                left: Get.width * 0.09,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 5.0),
                    Image.asset(
                      AppImages.goldTrophy,
                      scale: 25,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
