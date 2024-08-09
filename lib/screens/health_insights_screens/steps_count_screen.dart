// ignore_for_file: unused_element, unused_field

import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/components/health_insights/custom_heart_bmp_containe.dart';
import 'package:longevity_hub/components/health_insights/customtempRangcontainer.dart';
import 'package:longevity_hub/components/health_insights/steps_container.dart';
import 'package:longevity_hub/data/controller/health_insights_controller/health_insights_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/repositories/health_insights_repo/water_detail_repo/health_insights_rewards_repo.dart';
import 'package:longevity_hub/screens/exercise_screens/exercise_screen.dart';
import 'package:longevity_hub/screens/health_insights_screens/earn_rewards.dart';
import 'package:longevity_hub/screens/health_insights_screens/health_insights.dart';
import 'package:longevity_hub/screens/health_insights_screens/set_move_goal_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vertical_percent_indicator/vertical_percent_indicator.dart';

class StepCountScreen extends StatefulWidget {
  const StepCountScreen({Key? key}) : super(key: key);

  @override
  State<StepCountScreen> createState() => _StepCountScreenState();
}

class _StepCountScreenState extends State<StepCountScreen> {
  int _counter = 1;
  double _value = 0;
  final double _maxRating = 3.0;
  Timer? timer;
  Timer? timer1;
  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    if (_counter > 1) {
      setState(() {
        _counter--;
      });
    }
  }

  Future<void> checkGoal() async {
    await HealthInsightsController.i.fetchGoal();
    if (HealthInsightsController.i.calories >=
        HealthInsightsController.i.goal) {
      setState(() {
        _value += 0.1;
        HealthInsightsController.i.checkGoal();
      });
    }
  }

  void refreshData() async {
    await HealthInsightsController.i.initPlatformState();
    HealthInsightsRewardRepo().updateFootStepActivityRewardsLevel(
        HealthInsightsController.i.calories.toString());
    // HealthInsightsController.i.fetchWeeklyData();
  }

  void refreshWeeklyData() async {
    HealthInsightsController.i.fetchWeeklyData();
  }

  Timer? goalTimer;

  @override
  void initState() {
    super.initState();
    // HealthInsightsController.i.initPlatformState();
    scheduleDailyReset();
    HealthInsightsController.i.fetchWeeklyData();
    HealthInsightsController.i.saveDailyStepCount();
    HealthInsightsRewardRepo().getUserStepsActivityRewardsLevel();
    HealthInsightsController.i.selectedContainer == "daily".tr;
    // HealthInsightsController.i.fetchMonthlyData();
    timer =
        Timer.periodic(const Duration(seconds: 2), (Timer t) => refreshData());
    // goalTimer = Timer.periodic(const Duration(seconds: 2), (Timer t) async {
    //   await HealthInsightsController.i.fetchGoal();
    //   setState(() {});
    // });
    checkGoal();
  }

  @override
  void dispose() {
    timer?.cancel();
    timer1?.cancel();
    super.dispose();
  }

  void _selectContainer(String container) {
    setState(() {
      HealthInsightsController.i.selectedContainer = container;
    });
  }

  void scheduleDailyReset() {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day + 1);
    final timeUntilMidnight = midnight.difference(now).inMilliseconds;

    Timer(Duration(milliseconds: timeUntilMidnight), () {
      resetDailyCounters();
      scheduleDailyReset();
    });
  }

  void resetDailyCounters() {
    setState(() {
      HealthInsightsController.i.steps = 0;
      HealthInsightsController.i.calories = 0;
      HealthInsightsController.i.heartRate = 0;
      HealthInsightsController.i.distance = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.to(() => const HealthInsightsScreen());
          },
          child: Image.asset(
            AppImages.backArrow,
            scale: 10,
            color: ColorManager.kblackColor,
          ),
        ),
        title: Text(
          "stepscount".tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: ColorManager.kblackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: Get.width * 0.01),
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
        ],
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.02,
              horizontal: Get.width * 0.04,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: Get.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildContainer("daily".tr),
                      SizedBox(width: Get.width * 0.05),
                      _buildContainer("weekly".tr),
                      SizedBox(width: Get.width * 0.05),
                      _buildContainer("monthly".tr),
                    ],
                  ),
                  if (HealthInsightsController.i.selectedContainer ==
                      "daily".tr)
                    GetBuilder<HealthInsightsController>(builder: (cont) {
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.height * 0.03,
                            ),
                            CircularPercentIndicator(
                              backgroundColor: const Color(0xffE4F9FF),
                              animation: true,
                              radius: 100.0,
                              lineWidth: 22.0,
                              percent: (cont.steps / 10000).clamp(0.0, 1.0),
                              circularStrokeCap: CircularStrokeCap.round,
                              startAngle: 0,
                              reverse: false,
                              center: Stack(
                                alignment: Alignment.center,
                                children: [
                                  const CircularStepsContainer(
                                    waves: 2,
                                    waveAmplitude: 20,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AppImages.stepIcon,
                                        scale: 10,
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.02,
                                      ),
                                      Text(
                                        "${cont.steps}",
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color: ColorManager.kPrimaryColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        "steps".tr,
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              progressColor: ColorManager.kPrimaryColor,
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Text(
                              cont.status,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: ColorManager.kGreyColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            GetBuilder<HealthInsightsController>(
                                builder: (cont1) {
                              final double value = cont1
                                      .stepslevelUser.isNotEmpty
                                  ? (cont1.stepslevelUser[0].achievePoints
                                              ?.toDouble() ??
                                          0.0)
                                      .clamp(
                                          0.0,
                                          cont1.stepslevelUser[0].totalPoints
                                                  ?.toDouble() ??
                                              5.0)
                                  : 0.0;
                              final double maxRating =
                                  cont1.stepslevelUser.isNotEmpty
                                      ? cont1.stepslevelUser[0].totalPoints
                                              ?.toDouble() ??
                                          5.0
                                      : 5.0;
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 0.2,
                                            blurRadius: 1,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 207, 205, 205)),
                                        borderRadius: BorderRadius.circular(6)),
                                    height: Get.height * 0.08,
                                    width: Get.width * 0.6,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            AppImages.stepsbadge,
                                            scale: 5,
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.01,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                cont1.stepslevelUser.isNotEmpty
                                                    ? "${"your".tr} ${cont1.stepslevelUser[0].rewardsLevelName}"
                                                    : " ",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.01,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: Get.width * 0.25,
                                                    child:
                                                        StepsProgressIndicator(
                                                      value: value,
                                                      maxRating: maxRating,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.02,
                                                  ),
                                                  Text(
                                                    cont1.stepslevelUser
                                                            .isNotEmpty
                                                        ? "${cont1.stepslevelUser[0].achievePoints}/${cont1.stepslevelUser[0].totalPoints}"
                                                        : "",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 10,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ]),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.03,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => const EarnRewardsScreen());
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 0.2,
                                              blurRadius: 1,
                                              offset: const Offset(0, 1),
                                            ),
                                          ],
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 207, 205, 205)),
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      height: Get.height * 0.08,
                                      width: Get.width * 0.25,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            AppImages.stepsbadgeIcon,
                                            scale: 10,
                                          ),
                                          SizedBox(width: Get.width * 0.02),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: Get.height * 0.02),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "earn".tr,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  "badges".tr,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      AppImages.walkingIcon,
                                      scale: 5,
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Text(
                                      "walking".tr,
                                      style: GoogleFonts.poppins(
                                          color: ColorManager.kblackColor,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${cont.distance}",
                                      style: GoogleFonts.poppins(
                                          color: ColorManager.kblackColor,
                                          fontSize: 36,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "distance".tr,
                                      style: GoogleFonts.poppins(
                                          color: const Color.fromARGB(
                                              255, 159, 158, 158),
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      AppImages.runningIcon,
                                      scale: 3.6,
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Text(
                                      "running".tr,
                                      style: GoogleFonts.poppins(
                                          color: ColorManager.kblackColor,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: Get.height * 0.07,
                                  width: Get.width * 0.35,
                                  decoration: BoxDecoration(
                                    color: const Color(0xfffff0e0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          AppImages.goalIcon,
                                          scale: 25,
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.02,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${cont.calories}",
                                              style: GoogleFonts.poppins(
                                                  color:
                                                      ColorManager.kblackColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "KCAL".tr,
                                              style: GoogleFonts.poppins(
                                                  color:
                                                      ColorManager.kblackColor,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        )
                                      ]),
                                ),
                                Container(
                                  height: Get.height * 0.07,
                                  width: Get.width * 0.002,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                Container(
                                  height: Get.height * 0.07,
                                  width: Get.width * 0.35,
                                  decoration: BoxDecoration(
                                    color: const Color(0xfffff0e0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          AppImages.heartvectorIcon,
                                          scale: 7,
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.02,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${cont.heartRate}",
                                              style: GoogleFonts.poppins(
                                                  color:
                                                      ColorManager.kblackColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "heartRate".tr,
                                              style: GoogleFonts.poppins(
                                                  color:
                                                      ColorManager.kblackColor,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        )
                                      ]),
                                )
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // Get.to(()=>Community)
                                    Get.to(() => const ExerciseScreen());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 230, 230, 230),
                                          width: 0.5,
                                        )),
                                    child: Image.asset(
                                      AppImages.communityContIcon,
                                      scale: 4,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.02,
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          child: CustomTempRangeContainer(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.55,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.4,
                                            color: Colors.white,
                                            image: AppImages.tempIconCont,
                                            text: '99',
                                            headingtext: 'bodytemp'.tr,
                                            scale: 3,
                                            unitText: "normal".tr,
                                            squaretext: "°F",
                                            squareheight: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.13,
                                            squarewidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            contColor: const Color(0xffbbf246),
                                            waveImage: AppImages.bpwave,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 230, 230, 230),
                                          width: 0.5,
                                        )),
                                    child: Image.asset(
                                      AppImages.tempIcon,
                                      scale: 5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            CustomButton(
                              buttonheight: Get.height * 0.07,
                              backgroundColor: ColorManager.kWhiteColor,
                              borderColor:
                                  const Color.fromARGB(255, 249, 200, 127),
                              buttonwidth: Get.width * 0.75,
                              onPress: () async {
                                Get.to(() => const SetMoveGoalScreen());
                              },
                              mywidget: Text(
                                "editgoal".tr,
                                style: GoogleFonts.poppins(
                                    color: const Color.fromARGB(
                                        255, 250, 205, 136),
                                    fontSize: 20),
                              ),
                              radius: 18,
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            CustomButton(
                              buttonheight: Get.height * 0.07,
                              backgroundColor: ColorManager.kPrimaryColor,
                              buttonwidth: Get.width * 0.75,
                              onPress: () async {
                                Get.offAll(() => const HealthInsightsScreen());
                              },
                              mywidget: Text(
                                "finish".tr,
                                style: GoogleFonts.poppins(
                                    color: ColorManager.kblackColor,
                                    fontSize: 20),
                              ),
                              radius: 18,
                            ),
                          ],
                        ),
                      );
                    }),
                  if (HealthInsightsController.i.selectedContainer ==
                      "weekly".tr)
                    GetBuilder<HealthInsightsController>(builder: (contr) {
                      return Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: ColorManager.kWhiteColor,
                            ),
                            height: Get.height * 0.26,
                            width: Get.width * 0.9,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: Get.width * 0.09,
                                left: 2.0,
                              ),
                              child: LineChart(
                                LineChartData(
                                  gridData: FlGridData(
                                    drawHorizontalLine: true,
                                    drawVerticalLine: true,
                                    horizontalInterval: 1000,
                                    verticalInterval: 1,
                                    getDrawingHorizontalLine: (value) {
                                      return FlLine(
                                        color: Colors.grey,
                                        strokeWidth: 0,
                                      );
                                    },
                                    getDrawingVerticalLine: (value) {
                                      return FlLine(
                                        color: Colors.grey,
                                        strokeWidth: 1,
                                      );
                                    },
                                  ),
                                  titlesData: FlTitlesData(
                                    bottomTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 25,
                                      getTextStyles: (context, value) =>
                                          const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                      getTitles: (value) {
                                        switch (value.toInt()) {
                                          case 1:
                                            return 'MON'.tr;
                                          case 2:
                                            return 'TUE'.tr;
                                          case 3:
                                            return 'WED'.tr;
                                          case 4:
                                            return 'THU'.tr;
                                          case 5:
                                            return 'FRI'.tr;
                                          case 6:
                                            return 'SAT'.tr;
                                          case 7:
                                            return 'SUN'.tr;
                                          default:
                                            return '';
                                        }
                                      },
                                      margin: 12,
                                    ),
                                    leftTitles: SideTitles(
                                      showTitles: true,
                                      getTextStyles: (context, value) =>
                                          const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                      getTitles: (value) {
                                        if (value % 1000 == 0) {
                                          return '${value ~/ 5000}k';
                                        }
                                        return '';
                                      },
                                      reservedSize: 32,
                                      margin: 14,
                                    ),
                                    rightTitles: SideTitles(
                                      showTitles: false,
                                    ),
                                    topTitles: SideTitles(showTitles: false),
                                  ),
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  minX: 0,
                                  maxX: 8,
                                  minY: 0,
                                  maxY: 24000,
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: [
                                        FlSpot(
                                          1,
                                          min(
                                              HealthInsightsController
                                                      .i
                                                      .dailyStepCounts[
                                                          "Monday"]!
                                                      .toDouble() *
                                                  4.7,
                                              24000),
                                        ),
                                        FlSpot(
                                          2,
                                          min(
                                              HealthInsightsController
                                                      .i
                                                      .dailyStepCounts[
                                                          "Tuesday"]!
                                                      .toDouble() *
                                                  4.7,
                                              24000),
                                        ),
                                        FlSpot(
                                          3,
                                          min(
                                              HealthInsightsController
                                                      .i
                                                      .dailyStepCounts[
                                                          "Wednesday"]!
                                                      .toDouble() *
                                                  4.7,
                                              24000),
                                        ),
                                        FlSpot(
                                          4,
                                          min(
                                              HealthInsightsController
                                                      .i
                                                      .dailyStepCounts[
                                                          "Thursday"]!
                                                      .toDouble() *
                                                  4.7,
                                              24000),
                                        ),
                                        FlSpot(
                                          5,
                                          min(
                                              HealthInsightsController
                                                      .i
                                                      .dailyStepCounts[
                                                          "Friday"]!
                                                      .toDouble() *
                                                  4.7,
                                              24000),
                                        ),
                                        FlSpot(
                                          6,
                                          min(
                                              HealthInsightsController
                                                      .i
                                                      .dailyStepCounts[
                                                          "Saturday"]!
                                                      .toDouble() *
                                                  4.7,
                                              24000),
                                        ),
                                        FlSpot(
                                          7,
                                          min(
                                              HealthInsightsController
                                                      .i
                                                      .dailyStepCounts[
                                                          "Sunday"]!
                                                      .toDouble() *
                                                  4.7,
                                              24000),
                                        ),
                                      ],
                                      isCurved: true,
                                      barWidth: 4,
                                      colors: [
                                        const Color(0xffB09FFF),
                                        const Color(0xff8D79F6),
                                      ],
                                      dotData: FlDotData(show: false),
                                      belowBarData: BarAreaData(
                                        show: true,
                                        colors: [
                                          const Color.fromARGB(
                                              255, 230, 227, 246),
                                          const Color.fromARGB(
                                              255, 220, 213, 250),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Container(
                            height: Get.height * 0.14,
                            width: Get.width * 0.9,
                            decoration: BoxDecoration(
                              color: ColorManager.kMaroonContainerColor,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: const Color.fromARGB(255, 230, 230, 230),
                                width: 0.5,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: Get.width * 0.06),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "totalsteps".tr,
                                        style: GoogleFonts.poppins(
                                            color: ColorManager.kWhiteColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.005,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${contr.totalSteps}",
                                            style: GoogleFonts.poppins(
                                                color: ColorManager.kWhiteColor,
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.01,
                                          ),
                                          Text(
                                            "(10K)",
                                            style: GoogleFonts.poppins(
                                                color: ColorManager.kGreyColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(AppImages.chartImage),
                                    Text(
                                      "${contr.formattedTotalPercentage} %",
                                      style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomBmpContainer(
                                width: Get.width * 0.43,
                                height: Get.height * 0.22,
                                color: const Color(0xffd7efff),
                                image: AppImages.roundStepsIcon,
                                text: '${HealthInsightsController.i.avgSteps}',
                                headingtext: 'avgsteps'.tr,
                                scale: 6,
                                unitText: "steps".tr,
                              ),
                              SizedBox(
                                width: Get.width * 0.04,
                              ),
                              CustomBmpContainer(
                                width: Get.width * 0.43,
                                height: Get.height * 0.22,
                                color: const Color(0xfffbf1d5),
                                image: AppImages.roundLocationIcon,
                                text: HealthInsightsController
                                    .i.formattedtotalDistance,
                                headingtext: 'distance'.tr,
                                unitText: "km",
                                scale: 18,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomBmpContainer(
                                width: Get.width * 0.43,
                                height: Get.height * 0.22,
                                color: const Color(0xffffe8d9),
                                image: AppImages.roundWalkIcon,
                                text:
                                    "${HealthInsightsController.i.formattedWalkingPercentage} %",
                                headingtext: 'walking'.tr,
                                scale: 4.5,
                                unitText: "",
                              ),
                              SizedBox(
                                width: Get.width * 0.04,
                              ),
                              CustomBmpContainer(
                                width: Get.width * 0.43,
                                height: Get.height * 0.22,
                                color: const Color(0xfffbdcdd),
                                image: AppImages.roundRunIcon,
                                text:
                                    "${HealthInsightsController.i.formattedRunningPercentage} %",
                                headingtext: 'running'.tr,
                                unitText: "",
                                scale: 5,
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                  if (HealthInsightsController.i.selectedContainer ==
                      "monthly".tr)
                    Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Container(
                          height: Get.height * 0.27,
                          width: Get.width * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 226, 225, 225),
                                  width: 1.0)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.04,
                                        top: Get.height * 0.02),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "1stweek".tr,
                                          style: GoogleFonts.poppins(
                                              color: ColorManager.kblackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          "stepsreport".tr,
                                          style: GoogleFonts.poppins(
                                              color: ColorManager.kblackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: Get.width * 0.02),
                                    child: Text(
                                      "${"average".tr} ${HealthInsightsController.i.avgSteps}",
                                      style: GoogleFonts.poppins(
                                          color: ColorManager.kblackColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  VerticalBarIndicator(
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 1"]![
                                        "Wednesday"]!,
                                    // header: '50%',
                                    circularRadius: 6,
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '01',
                                    footerStyle: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  VerticalBarIndicator(
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 1"]![
                                        "Thursday"]!,
                                    // header: '50%',
                                    circularRadius: 6,
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '02',
                                    footerStyle: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  VerticalBarIndicator(
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 1"]![
                                        "Friday"]!,
                                    circularRadius: 6,
                                    // header: '50%',
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '03',
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
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 1"]![
                                        "Saturday"]!,
                                    // header: '50%',
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '04',
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
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 1"]![
                                        "Sunday"]!,
                                    // header: '50%',
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '05',
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
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 1"]![
                                        "Monday"]!,
                                    // header: '50%',
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '06',
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
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 1"]![
                                        "Tuesday"]!,
                                    // header: '50%',
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '07',
                                    footerStyle: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),

                                  // const VerticalBarIndicator(
                                  //   percent: 0.95,
                                  //   height: 250,
                                  //   animationDuration: Duration(seconds: 1),
                                  //   circularRadius: 0,
                                  //   color: [
                                  //     Colors.limeAccent,
                                  //     Colors.green,
                                  //   ],
                                  //   width: 50,
                                  //   header: '95%',
                                  //   footer: 'Available',
                                  // ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "W",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "T",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "F",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "S",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "S",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "M",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "T",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Container(
                          height: Get.height * 0.27,
                          width: Get.width * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 226, 225, 225),
                                  width: 1.0)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.04,
                                        top: Get.height * 0.02),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "2ndweek".tr,
                                          style: GoogleFonts.poppins(
                                              color: ColorManager.kblackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          "stepsreport".tr,
                                          style: GoogleFonts.poppins(
                                              color: ColorManager.kblackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: Get.width * 0.02),
                                    child: Text(
                                      "${"average".tr} ${HealthInsightsController.i.avgSteps}",
                                      style: GoogleFonts.poppins(
                                          color: ColorManager.kblackColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  VerticalBarIndicator(
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 2"]![
                                        "Wednesday"]!,
                                    // header: '50%',
                                    circularRadius: 6,
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '01',
                                    footerStyle: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  VerticalBarIndicator(
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 2"]![
                                        "Thursday"]!,
                                    // header: '50%',
                                    circularRadius: 6,
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '02',
                                    footerStyle: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  VerticalBarIndicator(
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 2"]![
                                        "Friday"]!,
                                    circularRadius: 6,
                                    // header: '50%',
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '03',
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
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 2"]![
                                        "Saturday"]!,
                                    // header: '50%',
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '04',
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
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 2"]![
                                        "Sunday"]!,
                                    // header: '50%',
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '05',
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
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 2"]![
                                        "Monday"]!,
                                    // header: '50%',
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '06',
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
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 2"]![
                                        "Tuesday"]!,
                                    // header: '50%',
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '07',
                                    footerStyle: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),

                                  // const VerticalBarIndicator(
                                  //   percent: 0.95,
                                  //   height: 250,
                                  //   animationDuration: Duration(seconds: 1),
                                  //   circularRadius: 0,
                                  //   color: [
                                  //     Colors.limeAccent,
                                  //     Colors.green,
                                  //   ],
                                  //   width: 50,
                                  //   header: '95%',
                                  //   footer: 'Available',
                                  // ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "W",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "T",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "F",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "S",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "S",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "M",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "T",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Container(
                          height: Get.height * 0.27,
                          width: Get.width * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 226, 225, 225),
                                  width: 1.0)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.04,
                                        top: Get.height * 0.02),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "3rdweek".tr,
                                          style: GoogleFonts.poppins(
                                              color: ColorManager.kblackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          "stepsreport".tr,
                                          style: GoogleFonts.poppins(
                                              color: ColorManager.kblackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: Get.width * 0.02),
                                    child: Text(
                                      "${"average".tr} ${HealthInsightsController.i.avgSteps}",
                                      style: GoogleFonts.poppins(
                                          color: ColorManager.kblackColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  VerticalBarIndicator(
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 3"]![
                                        "Wednesday"]!,
                                    // header: '50%',
                                    circularRadius: 6,
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '01',
                                    footerStyle: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  VerticalBarIndicator(
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 3"]![
                                        "Thursday"]!,
                                    // header: '50%',
                                    circularRadius: 6,
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '02',
                                    footerStyle: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  VerticalBarIndicator(
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 3"]![
                                        "Friday"]!,
                                    circularRadius: 6,
                                    // header: '50%',
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '03',
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
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 3"]![
                                        "Saturday"]!,
                                    // header: '50%',
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '04',
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
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 3"]![
                                        "Sunday"]!,
                                    // header: '50%',
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '05',
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
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 3"]![
                                        "Monday"]!,
                                    // header: '50%',
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '06',
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
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 3"]![
                                        "Tuesday"]!,
                                    // header: '50%',
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '07',
                                    footerStyle: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),

                                  // const VerticalBarIndicator(
                                  //   percent: 0.95,
                                  //   height: 250,
                                  //   animationDuration: Duration(seconds: 1),
                                  //   circularRadius: 0,
                                  //   color: [
                                  //     Colors.limeAccent,
                                  //     Colors.green,
                                  //   ],
                                  //   width: 50,
                                  //   header: '95%',
                                  //   footer: 'Available',
                                  // ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "W",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "T",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "F",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "S",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "S",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "M",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "T",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Container(
                          height: Get.height * 0.27,
                          width: Get.width * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 226, 225, 225),
                                  width: 1.0)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.04,
                                        top: Get.height * 0.02),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "4thweek".tr,
                                          style: GoogleFonts.poppins(
                                              color: ColorManager.kblackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          "stepsreport".tr,
                                          style: GoogleFonts.poppins(
                                              color: ColorManager.kblackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: Get.width * 0.02),
                                    child: Text(
                                      "${"average".tr} ${HealthInsightsController.i.avgSteps}",
                                      style: GoogleFonts.poppins(
                                          color: ColorManager.kblackColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  VerticalBarIndicator(
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 4"]![
                                        "Wednesday"]!,
                                    // header: '50%',
                                    circularRadius: 6,
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '01',
                                    footerStyle: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  VerticalBarIndicator(
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 4"]![
                                        "Thursday"]!,
                                    // header: '50%',
                                    circularRadius: 6,
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '02',
                                    footerStyle: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  VerticalBarIndicator(
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 4"]![
                                        "Friday"]!,
                                    circularRadius: 6,
                                    // header: '50%',
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '03',
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
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 4"]![
                                        "Saturday"]!,
                                    // header: '50%',
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '04',
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
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 4"]![
                                        "Sunday"]!,
                                    // header: '50%',
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '05',
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
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 4"]![
                                        "Monday"]!,
                                    // header: '50%',
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '06',
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
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 4"]![
                                        "Tuesday"]!,
                                    // header: '50%',
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '07',
                                    footerStyle: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),

                                  // const VerticalBarIndicator(
                                  //   percent: 0.95,
                                  //   height: 250,
                                  //   animationDuration: Duration(seconds: 1),
                                  //   circularRadius: 0,
                                  //   color: [
                                  //     Colors.limeAccent,
                                  //     Colors.green,
                                  //   ],
                                  //   width: 50,
                                  //   header: '95%',
                                  //   footer: 'Available',
                                  // ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "W",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "T",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "F",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "S",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "S",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "M",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "T",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Container(
                          height: Get.height * 0.27,
                          width: Get.width * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 226, 225, 225),
                                  width: 1.0)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.04,
                                        top: Get.height * 0.02),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "5thweek".tr,
                                          style: GoogleFonts.poppins(
                                              color: ColorManager.kblackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          "stepsreport".tr,
                                          style: GoogleFonts.poppins(
                                              color: ColorManager.kblackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: Get.width * 0.02),
                                    child: Text(
                                      "${"average".tr} ${HealthInsightsController.i.avgSteps}",
                                      style: GoogleFonts.poppins(
                                          color: ColorManager.kblackColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  VerticalBarIndicator(
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 5"]![
                                        "Wednesday"]!,
                                    // header: '50%',
                                    circularRadius: 6,
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '01',
                                    footerStyle: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  VerticalBarIndicator(
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 5"]![
                                        "Thursday"]!,
                                    // header: '50%',
                                    circularRadius: 6,
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '02',
                                    footerStyle: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  VerticalBarIndicator(
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 5"]![
                                        "Friday"]!,
                                    circularRadius: 6,
                                    // header: '50%',
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '03',
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
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 5"]![
                                        "Saturday"]!,
                                    // header: '50%',
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '04',
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
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 5"]![
                                        "Sunday"]!,
                                    // header: '50%',
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '05',
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
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 5"]![
                                        "Monday"]!,
                                    // header: '50%',
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '06',
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
                                    percent: HealthInsightsController
                                            .i.weeklyStepPercentages["Week 5"]![
                                        "Tuesday"]!,
                                    // header: '50%',
                                    height: Get.height * 0.13,
                                    width: Get.width * 0.1,
                                    color: const [
                                      Color(0xfffd9727),
                                      Color(0xffbbf246),
                                    ],
                                    footer: '07',
                                    footerStyle: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),

                                  // const VerticalBarIndicator(
                                  //   percent: 0.95,
                                  //   height: 250,
                                  //   animationDuration: Duration(seconds: 1),
                                  //   circularRadius: 0,
                                  //   color: [
                                  //     Colors.limeAccent,
                                  //     Colors.green,
                                  //   ],
                                  //   width: 50,
                                  //   header: '95%',
                                  //   footer: 'Available',
                                  // ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "W",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "T",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "F",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "S",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "S",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "M",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "T",
                                    style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContainer(String title) {
    return GestureDetector(
      onTap: () {
        _selectContainer(title);
      },
      child: Container(
        height: Get.height * 0.05,
        width: Get.width * 0.25,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: HealthInsightsController.i.selectedContainer == title
              ? Colors.orange
              : Colors.white,
          border: Border.all(
              width: 1,
              color: HealthInsightsController.i.selectedContainer == title
                  ? Colors.transparent
                  : const Color.fromARGB(255, 222, 221, 221)),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: HealthInsightsController.i.selectedContainer == title
                  ? Colors.white
                  : ColorManager.kPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class StepsProgressIndicator extends StatelessWidget {
  const StepsProgressIndicator({
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
                minHeight: 5,
                backgroundColor: Colors.grey,
                borderRadius: BorderRadius.circular(16),
                valueColor: AlwaysStoppedAnimation(
                  Color.lerp(
                    const Color(0xffFD9727),
                    const Color(0xffBBF246),
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
