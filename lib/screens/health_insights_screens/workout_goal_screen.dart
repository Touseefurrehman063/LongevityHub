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
import 'package:longevity_hub/screens/health_insights_screens/set_workout_goal.dart';
import 'package:longevity_hub/screens/health_insights_screens/workout_exercise_screen.dart';
import 'package:longevity_hub/screens/health_insights_screens/workout_success_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vertical_percent_indicator/vertical_percent_indicator.dart';

class WorkOutGoalScreen extends StatefulWidget {
  const WorkOutGoalScreen({Key? key}) : super(key: key);

  @override
  State<WorkOutGoalScreen> createState() => _WorkOutGoalScreenState();
}

class _WorkOutGoalScreenState extends State<WorkOutGoalScreen> {
  int _counter = 1;
  // final double _value = 1.5;
  // final double _maxRating = 2.0;
  void _increment() {
    if (_counter < 99) {
      _counter++;
    }
    setState(() {});
  }

  void _decrement() {
    if (_counter > 1) {
      _counter--;
      setState(() {});
    }
  }

  @override
  void initState() {
    HealthInsightsRewardRepo().getUserWorkoutActivityRewardsLevel();
    super.initState();
  }

  void _selectContainer(String container) {
    setState(() {
      HealthInsightsController.i.selectedContainer = container;
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
          "workout".tr,
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
            padding: EdgeInsets.only(right: Get.width * 0.03),
            child: Row(
              children: [
                Image.asset(
                  AppImages.share,
                  scale: 7,
                ),
                SizedBox(
                  width: Get.width * 0.01,
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
                    Center(
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
                            percent: 0.75,
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
                                      AppImages.dumbleWorkoutIcon,
                                      scale: 10,
                                    ),
                                    Text(
                                      "40",
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        color: ColorManager.kPrimaryColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      "Minutes".tr,
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
                            "exercise".tr,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: ColorManager.kGreyColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          GetBuilder<HealthInsightsController>(builder: (cont) {
                            final double value =
                                cont.workoutlevelUser.isNotEmpty
                                    ? (cont.workoutlevelUser[0].achievePoints
                                                ?.toDouble() ??
                                            0.0)
                                        .clamp(
                                            0.0,
                                            cont.workoutlevelUser[0].totalPoints
                                                    ?.toDouble() ??
                                                5.0)
                                    : 0.0;
                            final double maxRating =
                                cont.workoutlevelUser.isNotEmpty
                                    ? cont.workoutlevelUser[0].totalPoints
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
                                              cont.workoutlevelUser.isNotEmpty
                                                  ? "${"your".tr} ${cont.workoutlevelUser[0].rewardsLevelName}"
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
                                                  child: StepsProgressIndicator(
                                                    value: value,
                                                    maxRating: maxRating,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.02,
                                                ),
                                                Text(
                                                  cont.workoutlevelUser
                                                          .isNotEmpty
                                                      ? "${cont.workoutlevelUser[0].achievePoints}/${cont.workoutlevelUser[0].totalPoints}"
                                                      : "",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w500,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffFD9727),
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(8)),
                                height: Get.height * 0.08,
                                width: Get.width * 0.88,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: Get.width * .06,
                                      ),
                                      Image.asset(
                                        AppImages.dumbleWorkoutIcon,
                                        scale: 12,
                                      ),
                                      SizedBox(
                                        width: Get.width * .04,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "exercise".tr,
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Leg Press | $_counter ${"Minutes".tr}",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.08,
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: _decrement,
                                            child: Text(
                                              "-",
                                              style: GoogleFonts.poppins(
                                                fontSize: 35,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.03,
                                          ),
                                          Text(
                                            "$_counter",
                                            style: GoogleFonts.poppins(
                                              fontSize: 35,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.03,
                                          ),
                                          GestureDetector(
                                            onTap: _increment,
                                            child: Text(
                                              "+",
                                              style: GoogleFonts.poppins(
                                                fontSize: 35,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ]),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            "140",
                                            style: GoogleFonts.poppins(
                                                color: ColorManager.kblackColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "KCAL".tr,
                                            style: GoogleFonts.poppins(
                                                color: ColorManager.kblackColor,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            "160",
                                            style: GoogleFonts.poppins(
                                                color: ColorManager.kblackColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "heartRate".tr,
                                            style: GoogleFonts.poppins(
                                                color: ColorManager.kblackColor,
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
                                  // Get.to(() => const CommunityScreen());
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
                                          unitText: "Normal",
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
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const WorkoutGoalScreen());
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
                                    AppImages.playgoalExercise,
                                    scale: 7.2,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const WorkoutExcerciseScreen());
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
                                    AppImages.playExerciseIcon,
                                    scale: 7.8,
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
                            onPress: () async {},
                            mywidget: Text(
                              "editWorkout".tr,
                              style: GoogleFonts.poppins(
                                  color:
                                      const Color.fromARGB(255, 250, 205, 136),
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
                              Get.to(() => const WorkoutSuccessScreen());
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
                    ),
                  if (HealthInsightsController.i.selectedContainer ==
                      "weekly".tr)
                    Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "512",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 40,
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            Text(
                              "KCAL".tr,
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                          ),
                          height: Get.height * 0.26,
                          width: Get.width * 0.9,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: Get.width * 0.09,
                              left: 2.0,
                            ),
                            child: BarChart(
                              BarChartData(
                                alignment: BarChartAlignment.spaceAround,
                                maxY: 170,
                                barTouchData: BarTouchData(
                                  enabled: true,
                                  touchTooltipData: BarTouchTooltipData(
                                    tooltipBgColor: Colors.grey,
                                  ),
                                ),
                                titlesData: FlTitlesData(
                                  rightTitles: SideTitles(showTitles: false),
                                  topTitles: SideTitles(showTitles: false),
                                  leftTitles: SideTitles(
                                    showTitles: true,
                                    getTextStyles: (context, value) =>
                                        const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                    getTitles: (value) {
                                      if (value % 10 == 0) {
                                        return '${value.toInt()}';
                                      }
                                      return '';
                                    },
                                    margin: 14,
                                  ),
                                  bottomTitles: SideTitles(
                                    showTitles: true,
                                    getTextStyles: (context, value) {
                                      bool isHighest = value.toInt() ==
                                          4; // Index of the highest value
                                      return TextStyle(
                                        color: isHighest
                                            ? Colors.black
                                            : Colors.grey,
                                        fontWeight: isHighest
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        fontSize: 10,
                                      );
                                    },
                                    getTitles: (value) {
                                      switch (value.toInt()) {
                                        case 0:
                                          return 'SUN'.tr;
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
                                        default:
                                          return '';
                                      }
                                    },
                                    margin: 6,
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                gridData: FlGridData(
                                  drawHorizontalLine: false,
                                  drawVerticalLine: true,
                                  getDrawingVerticalLine: (value) {
                                    return FlLine(
                                      color: const Color.fromARGB(
                                          255, 229, 229, 229),
                                      strokeWidth: 1,
                                    );
                                  },
                                ),
                                barGroups: [
                                  BarChartGroupData(
                                    x: 0,
                                    barRods: [
                                      BarChartRodData(
                                        y: 80,
                                        colors: [
                                          const Color(0xffFCF2D5),
                                          const Color(0xffFCF2D5),
                                        ],
                                      ),
                                    ],
                                  ),
                                  BarChartGroupData(
                                    x: 1,
                                    barRods: [
                                      BarChartRodData(
                                        y: 40,
                                        colors: [
                                          const Color(0xffFCF2D5),
                                          const Color(0xffFCF2D5),
                                        ],
                                      ),
                                    ],
                                  ),
                                  BarChartGroupData(
                                    x: 2,
                                    barRods: [
                                      BarChartRodData(
                                        y: 20,
                                        colors: [
                                          const Color(0xffFCF2D5),
                                          const Color(0xffFCF2D5),
                                        ],
                                      ),
                                    ],
                                  ),
                                  BarChartGroupData(
                                    x: 3,
                                    barRods: [
                                      BarChartRodData(
                                        y: 60,
                                        colors: [
                                          const Color(0xffFCF2D5),
                                          const Color(0xffFCF2D5),
                                        ],
                                      ),
                                    ],
                                  ),
                                  BarChartGroupData(
                                    x: 4,
                                    barRods: [
                                      BarChartRodData(
                                        y: 140,
                                        colors: [
                                          const Color(0xffFD9727),
                                          const Color(0xffF45C43),
                                        ],
                                      ),
                                    ],
                                  ),
                                  BarChartGroupData(
                                    x: 5,
                                    barRods: [
                                      BarChartRodData(
                                        y: 100,
                                        colors: [
                                          const Color(0xffFCF2D5),
                                          const Color(0xffFCF2D5),
                                        ],
                                      ),
                                    ],
                                  ),
                                  BarChartGroupData(
                                    x: 6,
                                    barRods: [
                                      BarChartRodData(
                                        y: 50,
                                        colors: [
                                          const Color(0xffFCF2D5),
                                          const Color(0xffFCF2D5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
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
                              image: AppImages.leftIcon,
                              text: '512',
                              headingtext: 'caloriesburnt'.tr,
                              scale: 6,
                              unitText: "KCAL".tr,
                            ),
                            SizedBox(
                              width: Get.width * 0.04,
                            ),
                            CustomBmpContainer(
                              width: Get.width * 0.43,
                              height: Get.height * 0.22,
                              color: const Color(0xfffbf1d5),
                              image: AppImages.burntIcon,
                              text: '102',
                              headingtext: 'Caloriesleft'.tr,
                              unitText: "KCAL".tr,
                              scale: 11,
                            ),
                          ],
                        ),
                      ],
                    ),
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
                                          "workoutreport".tr,
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
                                      "${"average".tr} 580${"KCAL".tr}",
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
                                    percent: 0.4,
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
                                    percent: 0.2,
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
                                    percent: 0.4,
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
                                    percent: 0.3,
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
                                    percent: 1,
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
                                    percent: 0.4,
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
                                    percent: 01,
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
                                          "workoutreport".tr,
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
                                      "${"average".tr} 580${"KCAL".tr}",
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
                                    percent: 0.4,
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
                                    percent: 0.2,
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
                                    percent: 0.4,
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
                                    percent: 0.3,
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
                                    percent: 1,
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
                                    percent: 0.4,
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
                                    percent: 01,
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
                                          "workoutreport".tr,
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
                                      "${"average".tr} 580${"KCAL".tr}",
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
                                    percent: 0.4,
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
                                    percent: 0.2,
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
                                    percent: 0.4,
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
                                    percent: 0.3,
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
                                    percent: 1,
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
                                    percent: 0.4,
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
                                    percent: 01,
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
                                          "workoutreport".tr,
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
                                      "${"average".tr} 580${"KCAL".tr}",
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
                                    percent: 0.4,
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
                                    percent: 0.2,
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
                                    percent: 0.4,
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
                                    percent: 0.3,
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
                                    percent: 1,
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
                                    percent: 0.4,
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
                                    percent: 01,
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
                                          "workoutreport".tr,
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
                                      "${"average".tr} 580${"KCAL".tr}",
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
                                    percent: 0.4,
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
                                    percent: 0.2,
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
                                    percent: 0.4,
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
                                    percent: 0.3,
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
                                    percent: 1,
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
                                    percent: 0.4,
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
                                    percent: 01,
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
