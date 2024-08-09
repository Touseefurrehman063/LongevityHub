import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/steps_screen/age_screen.dart';
import 'package:longevity_hub/screens/steps_screen/welcome_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});
  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String selectedGender = 'male';
  final Map<String, String> genderIds = {
    'male': '4cae3d33-e8aa-e711-80c1-a0b3cce147ba',
    'female': '4dae3d33-e8aa-e711-80c1-a0b3cce147ba',
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: InkWell(
        //   onTap: () {
        //     Get.offAll(() => const LoginScreen());
        //   },
        //   child: Image.asset(
        //     AppImages.backArrow,
        //     scale: 10,
        //     color: ColorManager.kblackColor,
        //   ),
        // ),
        title: Text(
          "step1of7".tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: ColorManager.kblackColor,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: Get.width * 0.02),
            child: InkWell(
              onTap: () {
                Get.offAll(() => const WelcomeLongevity());
              },
              child: Row(
                children: [
                  Text(
                    "skip".tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: ColorManager.kblackColor,
                    ),
                  ),
                  Image.asset(
                    "assets/images/skiparrow.png",
                    scale: 10,
                    color: ColorManager.kblackColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
        child: Container(
          padding: EdgeInsets.symmetric(
              // vertical: Get.height * 0.00,
              horizontal: Get.width * 0.07),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.background),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Align text to the top
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'tellusaboutyourself'.tr,
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.kblackColor,
                    ),
                  ),
                  Text(
                    'toGiveYoubetterexperiance'.tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: ColorManager.kblackColor,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.12,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedGender = 'male';
                      });
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: selectedGender == 'male'
                          ? const Color(0xFFFDA11A)
                          : const Color(0xFFCECECE),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.genderM,
                            scale: 12,
                          ),
                          Text(
                            'male'.tr,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: ColorManager.kblackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedGender = 'female';
                      });
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: selectedGender == 'female'
                          ? const Color(0xFFFDA11A)
                          : const Color(0xFFCECECE),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.genderF,
                            scale: 12,
                          ),
                          Text(
                            'female'.tr,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: ColorManager.kblackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()), // Spacer to push text to the top
              CustomButton(
                buttonheight: Get.height * 0.07,
                backgroundColor: ColorManager.kPrimaryColor,
                buttonwidth: Get.width * 0.85,
                onPress: () async {
                  final genderId = genderIds[selectedGender];
                  if (genderId != null) {
                    await LocalDb().saveGender(genderId);
                    Get.to(() => const AgeScreen());
                  }
                },
                mywidget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "next".tr,
                      style: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    Image.asset(
                      AppImages.nextArrow,
                      scale: 8,
                    ),
                  ],
                ),
                radius: 10,
              ),
              SizedBox(
                height: Get.height * 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
