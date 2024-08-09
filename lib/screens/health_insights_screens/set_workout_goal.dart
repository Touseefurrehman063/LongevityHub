import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/components/health_insights/custom_program_container.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/health_insights_screens/health_workout_detail_screen.dart';
import 'package:longevity_hub/screens/nutrition_screens/nutrition_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vertical_percent_indicator/vertical_percent_indicator.dart';

class WorkoutGoalScreen extends StatefulWidget {
  const WorkoutGoalScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutGoalScreen> createState() => _WorkoutGoalScreenState();
}

class _WorkoutGoalScreenState extends State<WorkoutGoalScreen> {
  @override
  void initState() {
    super.initState();
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
          "setworkoutgoal".tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: ColorManager.kblackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: Get.height * 0.02,
          horizontal: Get.width * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "activitystats".tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: ColorManager.kblackColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                CustomButton(
                  buttonheight: Get.height * 0.04,
                  backgroundColor: ColorManager.kPrimaryColor,
                  buttonwidth: Get.width * 0.35,
                  onPress: () {
                    Get.to(() => const WorkoutDetailScreen());
                  },
                  radius: 8,
                  mywidget: Text(
                    "setGoal".tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: ColorManager.kWhiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Container(
              height: Get.height * 0.14,
              width: Get.width * 0.9,
              decoration: BoxDecoration(
                color: const Color(0xffececec),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.04),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "calories".tr,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: ColorManager.kblackColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "160,56",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: ColorManager.kblackColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                            Text(
                              "KCal".tr,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: ColorManager.kGreyColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Text(
                          "timespend".tr,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: ColorManager.kblackColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "12:29:84",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: ColorManager.kblackColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                  VerticalBarIndicator(
                    circularRadius: 6,
                    percent: 0.4,
                    // header: '50%',
                    height: Get.height * 0.088,
                    width: Get.width * 0.025,
                    color: const [Color(0xfffd9727), Color(0xfffd9727)],
                    footer: "SUN",
                    footerStyle: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  VerticalBarIndicator(
                    circularRadius: 6,
                    percent: 0.3,
                    // header: '50%',
                    height: Get.height * 0.088,
                    width: Get.width * 0.025,
                    color: const [Color(0xfffd9727), Color(0xfffd9727)],
                    footer: "MON",
                    footerStyle: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  VerticalBarIndicator(
                    circularRadius: 6,
                    percent: 0.7,
                    // header: '50%',
                    height: Get.height * 0.088,
                    width: Get.width * 0.025,
                    color: const [Color(0xfffd9727), Color(0xfffd9727)],
                    footer: "TUE",
                    footerStyle: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  VerticalBarIndicator(
                    circularRadius: 6,
                    percent: 0.5,
                    // header: '50%',
                    height: Get.height * 0.088,
                    width: Get.width * 0.025,
                    color: const [Color(0xfffd9727), Color(0xfffd9727)],
                    footer: "WED",
                    footerStyle: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  VerticalBarIndicator(
                    circularRadius: 6,
                    percent: 1,
                    // header: '50%',
                    height: Get.height * 0.088,
                    width: Get.width * 0.03,
                    color: const [Color(0xff67FF5B), Color(0xff67FF5B)],
                    footer: "THU",
                    footerStyle: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  VerticalBarIndicator(
                    circularRadius: 6,
                    percent: 0.6,
                    // header: '50%',
                    height: Get.height * 0.088,
                    width: Get.width * 0.03,
                    color: const [Color(0xfffd9727), Color(0xfffd9727)],
                    footer: "FRI",
                    footerStyle: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  VerticalBarIndicator(
                    circularRadius: 6,
                    percent: 1,
                    // header: '50%',
                    height: Get.height * 0.088,
                    width: Get.width * 0.03,
                    color: const [Color(0xff67FF5B), Color(0xff67FF5B)],
                    footer: "SAT",
                    footerStyle: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "summary".tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: ColorManager.kblackColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                qualityContainer(),
                InkWell(
                    onTap: () {
                      Get.to(() => const NutritionScreen());
                    },
                    child: mealContainer()),
              ],
            ),
            SizedBox(height: Get.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "myprogram".tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: ColorManager.kblackColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: Get.height * 0.02),
                    child: CustomProgramContainer(
                      centerText: "overheadextension".tr,
                      centerText2: "4 ${"minutesleft".tr}",
                      centerText3: "10 min",
                      bkColor: const Color(0xFF2C2C2E),
                      trailingImage: AppImages.extensionIcon,
                      statustext: "Beginner",
                      clientText: "16 Active Clients",
                      rowText: "have made an appointment",
                      timingtext: "Available Timings",
                      amText: "09:00 am",
                      pmText: "05:00 pm",
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Container qualityContainer() {
  return Container(
    width: Get.width * 0.42,
    height: Get.height * 0.25,
    decoration: BoxDecoration(
      color: ColorManager.kLightGrewish,
      borderRadius: BorderRadius.circular(17),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.only(top: Get.height * 0.02, left: Get.width * 0.04),
          child: Text(
            "overallprogress".tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 14,
                color: ColorManager.kblackColor,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: Get.height * 0.03,
        ),
        Center(
          child: CircularPercentIndicator(
            backgroundColor: const Color.fromARGB(255, 214, 212, 212),
            animation: true,
            radius: 62.0,
            lineWidth: 24.0,
            percent: 0.25,
            center: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.001),
              child: Text(
                "25%",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: ColorManager.kblackColor,
                    fontWeight: FontWeight.w600),
              ),
            ),
            progressColor: const Color.fromARGB(255, 248, 189, 101),
          ),
        ),
      ],
    ),
  );
}

Container mealContainer() {
  return Container(
    width: Get.width * 0.42,
    height: Get.height * 0.25,
    decoration: BoxDecoration(
      color: ColorManager.kPrimaryColor,
      borderRadius: BorderRadius.circular(17),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.only(top: Get.height * 0.02, left: Get.width * 0.03),
          child: Text(
            "mealGuide".tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 14,
                color: ColorManager.kWhiteColor,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: Get.height * 0.03,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "8am",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: const Color.fromARGB(255, 233, 232, 232),
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "breakfast".tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: ColorManager.kWhiteColor,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Image.asset(
              AppImages.info,
              scale: 18,
              color: Colors.white,
            )
          ],
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "12am",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: const Color.fromARGB(255, 233, 232, 232),
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "lunch".tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: ColorManager.kWhiteColor,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(
              width: Get.width * 0.05,
            ),
            Image.asset(
              AppImages.info,
              scale: 18,
              color: Colors.white,
            )
          ],
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "6pm",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: const Color.fromARGB(255, 233, 232, 232),
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "dinner".tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: ColorManager.kWhiteColor,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(
              width: Get.width * 0.05,
            ),
            Image.asset(
              AppImages.info,
              scale: 18,
              color: Colors.white,
            )
          ],
        ),
      ],
    ),
  );
}
