import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/health_insights_screens/set_workout_goal.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class WorkoutSuccessScreen extends StatefulWidget {
  const WorkoutSuccessScreen({super.key});

  @override
  State<WorkoutSuccessScreen> createState() => _WorkoutSuccessScreenState();
}

class _WorkoutSuccessScreenState extends State<WorkoutSuccessScreen> {
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
          "Workout",
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
                      "Today - 16 Feb",
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
                      "Hi, Aashifa Sheikh",
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
                    AppImages.happyEmoji,
                    scale: 3.5,
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
                            "Congratulations!",
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
                            "Harry has achive \n your goal today",
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
                            "Success is not final, failure is not \nfatal: it is the courage to continue \nthat count.",
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
                        Get.to(() => const WorkoutGoalScreen());
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
                        "Set New Goal",
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
