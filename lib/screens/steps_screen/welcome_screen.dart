import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/repositories/Intro_steps_repo/intro_steps_repo.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class WelcomeLongevity extends StatefulWidget {
  const WelcomeLongevity({Key? key}) : super(key: key);

  @override
  State<WelcomeLongevity> createState() => _WelcomeLongevityState();
}

class _WelcomeLongevityState extends State<WelcomeLongevity> {
  bool _isLoading = false;

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: Get.height * 0.13),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.background),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'welcometolongevity'.tr,
                      style: GoogleFonts.poppins(
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.kblackColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        AppImages.workOut,
                        width: Get.width * 0.09,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'workoutsforeveryone'.tr,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ColorManager.kblackColor,
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.7,
                          child: Text(
                            'elevenDifferentTypesfromHiit'.tr,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: ColorManager.kblackColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        AppImages.guide,
                        width: Get.width * 0.08,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.03,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'guidedMeditation'.tr,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ColorManager.kblackColor,
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.7,
                          child: Text(
                            'paracticemindfullnesin'.tr,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: ColorManager.kblackColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        AppImages.programs,
                        width: Get.width * 0.07,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.04,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Get.width * 0.7,
                          child: Text(
                            'programandmore'.tr,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: ColorManager.kblackColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.7,
                          child: Text(
                            'paracticemindfullnesin'.tr,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: ColorManager.kblackColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 93, 90, 90),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.subscribe,
                            width: Get.width * 0.09,
                          ),
                          SizedBox(height: Get.height * 0.01),
                          SizedBox(
                            width: Get.width * 0.8,
                            child: Text(
                              'welcomeText'.tr,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: ColorManager.kWhiteColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Text(
                            "seehowmanage".tr,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: ColorManager.kPrimaryColor,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.06,
                          ),
                        ],
                      ),
                    ),
                    Transform.translate(
                      offset: Get.locale?.languageCode == 'ar'
                          ? const Offset(0, 200)
                          : const Offset(0, 235),
                      child: Center(
                        child: CustomButton(
                          buttonheight: Get.height * 0.07,
                          backgroundColor: ColorManager.kPrimaryColor,
                          buttonwidth: Get.width * 0.7,
                          onPress: () async {
                            // Show loading indicator
                            _toggleLoading();
                            // Simulate async task
                            await Future.delayed(const Duration(seconds: 2));

                            _toggleLoading();

                            StepsRepository().consentagreement();
                          },
                          mywidget: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  "agree".tr,
                                  style: GoogleFonts.poppins(
                                      color: ColorManager.kblackColor,
                                      fontSize: 20),
                                ),
                          radius: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
