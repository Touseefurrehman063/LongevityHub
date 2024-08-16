import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:longevity_hub/components/health_insights/custom_calendar.dart';
import 'package:longevity_hub/components/health_insights/custom_container.dart';
import 'package:longevity_hub/components/health_insights/custom_sleep_container.dart';
import 'package:longevity_hub/components/health_insights/custom_wave_container.dart';
import 'package:longevity_hub/components/health_insights/heart_container.dart';
import 'package:longevity_hub/data/controller/health_insights_controller/health_insights_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/dashboard_screens/menu_drawer.dart';
import 'package:longevity_hub/screens/health_insights_screens/ble_device_data_screen.dart';
import 'package:longevity_hub/screens/health_insights_screens/earn_rewards.dart';
import 'package:longevity_hub/screens/health_insights_screens/heart_rate_screen.dart';
import 'package:longevity_hub/screens/health_insights_screens/scan_screen.dart';
import 'package:longevity_hub/screens/health_insights_screens/set_move_goal_screen.dart';
import 'package:longevity_hub/screens/health_insights_screens/set_workout_goal.dart';
import 'package:longevity_hub/screens/health_insights_screens/steps_count_screen.dart';
import 'package:longevity_hub/screens/health_insights_screens/water_detail_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HealthInsightsScreen extends StatefulWidget {
  const HealthInsightsScreen({super.key});

  @override
  State<HealthInsightsScreen> createState() => _HealthInsightsScreenState();
}

class _HealthInsightsScreenState extends State<HealthInsightsScreen>
    with SingleTickerProviderStateMixin {
  DateTime selectedDate = DateTime.now();
  void _openCustomCalendar(BuildContext context) async {
    DateTime? pickedDate = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return CustomCalendar(
          selectedDate: selectedDate,
          onDateSelected: (DateTime date) {
            Navigator.of(context).pop(date);
          },
        );
      },
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  double progressPercent = 0.8;
  double progressPercentStart = 0;
  String circleStatus = "80%";
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int? getSelectedActivityIndex(String selectedId) {
    return HealthInsightsController.i.waterActivities
        .indexWhere((activity) => activity.waterActivityId == selectedId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Get.to(() => const DrawerScreen());
            },
            child: Image.asset(
              AppImages.backArrow,
              scale: 10,
              color: ColorManager.kblackColor,
            ),
          ),
          title: Text(
            "healthInsights".tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 20,
                color: ColorManager.kblackColor,
                fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: Get.width * 0.03),
              child: InkWell(
                onTap: () {
                  // Get.to(() => const SavedRecipiesScreen());
                },
                child: Row(
                  children: [
                    Image.asset(
                      AppImages.share,
                      scale: 7,
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Image.asset(
                      AppImages.info,
                      scale: 17,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('MMM dd, yyyy').format(selectedDate),
                    style: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    width: Get.width * 0.01,
                  ),
                  InkWell(
                    onTap: () => _openCustomCalendar(context),
                    child: Image.asset(
                      AppImages.calendarIcon,
                      scale: 7,
                      // color: ColorManager.kblackColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => const WorkoutGoalScreen());
                      },
                      child: CustomDynamicContainer(
                        width: Get.width * 0.32,
                        height: Get.height * 0.19,
                        color: const Color(0xffe9ebff),
                        text: "todayworkout".tr,
                        verticaltextheight: Get.height * 0.02,
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: ColorManager.kblackColor,
                            fontWeight: FontWeight.w500),
                        sizedBoxheight: Get.height * 0.01,
                        indicator: CircularPercentIndicator(
                          backgroundColor: ColorManager.kWhiteColor,
                          animation: true,
                          radius: 40.0,
                          lineWidth: 14.0,
                          percent: 0.8,
                          circularStrokeCap: CircularStrokeCap.round,
                          startAngle: progressPercentStart.round().toDouble(),
                          reverse: true,
                          center: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.001),
                            child: Text(
                              "80%",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: ColorManager.kblackColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          progressColor: ColorManager.kMaroonColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.03,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const HeartRateScreen());
                      },
                      child: CustomDynamicContainer(
                        width: Get.width * 0.54,
                        height: Get.height * 0.19,
                        color: const Color(0xffffeaea),
                        text: "heartRate".tr,
                        image: AppImages.hearticon,
                        paddingwidth: Get.width * 0.05,
                        verticaltextheight: Get.height * 0.022,
                        sizedwidth: Get.width * 0.02,
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: ColorManager.kblackColor,
                            fontWeight: FontWeight.w500),
                        sizedBoxheight: Get.height * 0.02,
                        indicator: CustomHeartContainer(
                          height: Get.height * 0.09,
                          width: Get.width * 0.485,
                          image: AppImages.heartgraph,
                          text: "79 BPM",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: ColorManager.kblackColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        bool isFirstClick =
                            prefs.getBool('isFirstClick') ?? true;

                        if (isFirstClick) {
                          Get.to(() => const SetMoveGoalScreen());
                          await prefs.setBool('isFirstClick', false);
                        } else {
                          Get.to(() => const StepCountScreen());
                        }
                      },
                      child: CustomDynamicContainer(
                        borderradius: 12,
                        width: Get.width * 0.435,
                        height: Get.height * 0.19,
                        color: const Color(0xffffe8c5),
                        text: "steps".tr,
                        image: AppImages.stepsicon,
                        sizedwidth: Get.width * 0.03,
                        paddingwidth: Get.width * 0.1,
                        verticaltextheight: Get.height * 0.022,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: ColorManager.kblackColor,
                          fontWeight: FontWeight.w500,
                        ),
                        sizedBoxheight: Get.height * 0.05,
                        steptext: "${HealthInsightsController.i.steps} / 10000",
                        stepheight: Get.height * 0.01,
                        indicator: SizedBox(
                          width: Get.width * 0.38,
                          child: RatingProgressIndicator(
                            value: HealthInsightsController.i.steps.toDouble(),
                            maxRating: 10000,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.03,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const WaterDetailScreen());
                      },
                      child:
                          GetBuilder<HealthInsightsController>(builder: (cont) {
                        return CustomDynamicContainer(
                          width: Get.width * 0.435,
                          height: Get.height * 0.19,
                          color: const Color(0xffcaefff),
                          text: "water".tr,
                          image: AppImages.watericon,
                          sizedwidth: Get.width * 0.02,
                          paddingwidth: Get.width * 0.1,
                          verticaltextheight: Get.height * 0.022,
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: ColorManager.kblackColor,
                              fontWeight: FontWeight.w500),
                          sizedBoxheight: Get.height * 0.03,
                          // stepheight: Get.height * 0.01,
                          indicator: AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              final selectedActivityIndex =
                                  getSelectedActivityIndex(
                                      cont.selectedWaterActivityId);
                              final numberOfGlass = selectedActivityIndex !=
                                          null &&
                                      selectedActivityIndex >= 0
                                  ? cont.waterActivities[selectedActivityIndex]
                                          .numberOfGlass ??
                                      "0"
                                  : "0";

                              final waterText =
                                  '${cont.counter}/$numberOfGlass glasses';
                              // print(waterText);
                              return SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                child: WaveContainer(
                                  waves: 2,
                                  waveAmplitude: 20,
                                  percent: (HealthInsightsController
                                              .i
                                              .intakeWaterModel
                                              ?.waterCompletionLevel
                                              ?.toDouble() ??
                                          0.0) /
                                      100.0,
                                  child: Center(
                                    child: Text(
                                      waterText,
                                      style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          color: ColorManager.kblackColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Get.to(() => const HealthySleepScreen());
                        Get.to(() => const BLEDeviceDataScreen());
                      },
                      child: SleepContainer(
                        imagePath: AppImages.sleeping,
                        heading: "sleeping".tr,
                        text: "9 ${"hours".tr}",
                        color: const Color(0xffbbf246),
                        headingtextColor: ColorManager.kblackColor,
                      ),
                    ),
                    // SizedBox(
                    //   width: Get.width * 0.0005,
                    // ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const EarnRewardsScreen());
                      },
                      child: SleepContainer(
                        imagePath: AppImages.badgeicon,
                        heading: "earn".tr,
                        text: "badges".tr,
                        color: const Color(0xffe9ecef),
                        headingtextColor: ColorManager.kblackColor,
                        headingTextSize: 13,
                        textSize: 13,
                        verticalSize: Get.height * 0.005,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * .02,
              ),
              Center(
                child: Text(
                  "connectwearable".tr,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    // color: textColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * .03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * .04),
                child: InkWell(
                  onTap: () {
                    Get.to(() => const ScanScreen());
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      AppImages.connectwatch,
                      scale: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class RatingProgressIndicator extends StatelessWidget {
  const RatingProgressIndicator({
    Key? key,
    required this.value,
    required this.maxRating,
  }) : super(key: key);

  final double value;
  final double maxRating;

  @override
  Widget build(BuildContext context) {
    double progress = maxRating > 0 ? value / maxRating : 0.0;
    if (progress.isNaN || progress.isInfinite) {
      progress = 0.0;
    }

    return Row(
      children: [
        Expanded(
          flex: 15,
          child: Stack(
            children: [
              LinearProgressIndicator(
                value: progress,
                minHeight: 20,
                backgroundColor: Colors.white,
                borderRadius: BorderRadius.circular(16),
                valueColor: AlwaysStoppedAnimation(
                  Color.lerp(
                    ColorManager.kYellowIndicator,
                    ColorManager.kYellowIndicator,
                    progress,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
