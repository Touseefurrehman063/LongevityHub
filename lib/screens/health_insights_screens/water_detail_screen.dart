// ignore_for_file: unused_import, unused_element, library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/Login/authTextField.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/components/health_insights/add_category_dialog.dart';
import 'package:longevity_hub/components/health_insights/circular_wave_controller.dart';
import 'package:longevity_hub/components/health_insights/custom_water_containers.dart';
import 'package:longevity_hub/components/health_insights/custom_water_field.dart';
import 'package:longevity_hub/data/controller/health_insights_controller/health_insights_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/repositories/health_insights_repo/water_detail_repo/health_insights_rewards_repo.dart';
import 'package:longevity_hub/repositories/health_insights_repo/water_detail_repo/water_detail_repo.dart';
import 'package:longevity_hub/screens/health_insights_screens/earn_rewards.dart';
import 'package:longevity_hub/screens/health_insights_screens/health_insights.dart';
import 'package:longevity_hub/screens/health_insights_screens/todays_water_detail_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:longevity_hub/utils/constants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class WaterDetailScreen extends StatefulWidget {
  const WaterDetailScreen({super.key});

  @override
  State<WaterDetailScreen> createState() => _WaterDetailScreenState();
}

class _WaterDetailScreenState extends State<WaterDetailScreen> {
  // final double _value = HealthInsightsController.i.waterlevelUser.isNotEmpty
  //     ? HealthInsightsController.i.waterlevelUser[0].achievePoints
  //             ?.toDouble() ??
  //         0.0
  //     : 0.0;
  // final double _maxRating = 5.0;

  void _onContainerTap(String waterActivityId) {
    setState(() {
      // Check if the selected waterActivityId is different from the current one
      if (HealthInsightsController.i.selectedWaterActivityId !=
          waterActivityId) {
        HealthInsightsController.i.setSelectedWaterActivityId(waterActivityId);
        // WaterRepository().getIntakeWaterGlassActivity();
        HealthInsightsController.i.counter = 0;

        if (HealthInsightsController.i.intakeWaterModel != null) {
          HealthInsightsController.i.intakeWaterModel!.waterCompletionLevel = 0;
        }
      }
    });
  }

  Future<void> _showAddCategoryDialog() async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: const AddCategoryDialog(),
        );
      },
    );

    if (result == true) {
      await WaterRepository().getWaterActivity();
      setState(() {});
    }
  }

  void _incrementCounter() async {
    if (HealthInsightsController.i.selectedWaterActivityId.isEmpty) {
      Fluttertoast.showToast(
        msg: "pleaseselectactivity".tr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    var selectedActivity =
        HealthInsightsController.i.waterActivities.firstWhere(
      (activity) =>
          activity.waterActivityId ==
          HealthInsightsController.i.selectedWaterActivityId,
    );
    int maxGlasses = selectedActivity.numberOfGlass ?? 0;

    if (HealthInsightsController.i.counter < maxGlasses) {
      setState(() {
        HealthInsightsController.i.counter++;
        double completionLevel =
            (HealthInsightsController.i.counter / maxGlasses) * 100;
        if (HealthInsightsController.i.intakeWaterModel != null) {
          HealthInsightsController.i.intakeWaterModel!.waterCompletionLevel =
              completionLevel.toInt();
        }
      });

      await WaterRepository().updateHealthInsightWaterActivity();
      await HealthInsightsRewardRepo().updateUserWaterActivityRewardsLevel();
      HealthInsightsController.i.update();
    }
  }

  void _decrementCounter() {
    setState(() {
      if (HealthInsightsController.i.counter > 0) {
        HealthInsightsController.i.counter--;
      }
    });
  }

  void initializeState() async {
    await WaterRepository().getWaterActivity();
    await WaterRepository().getIntakeWaterGlassActivity();
    await func();
    setState(() {
      // HealthInsightsController.i.intakeWaterModel?.waterCompletionLevel = 0.0;
    });
  }

  @override
  void initState() {
    initializeState();
    HealthInsightsRewardRepo().getIntakeWaterGlassActivity();
    WaterRepository().getcategory();
    // _selectedContainerIndex = 0;

    // func();
    // HealthInsightsController.i.intakeWaterModel?.waterCompletionLevel == 0.0;
    super.initState();
  }

  @override
  void dispose() {
    HealthInsightsController.i.waterActivities.clear();
    super.dispose();
  }

  func() async {
    await WaterRepository().getIntakeWaterGlassActivity();
  }

  String getCompletionMessage(int? completionLevel) {
    if (completionLevel == null || completionLevel == 50) {
      return "inprogress".tr;
    } else if (completionLevel > 50 && completionLevel <= 90) {
      return "almostdone".tr;
    } else if (completionLevel == 100) {
      return "completed".tr;
    } else {
      return "inprogress".tr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final int? waterCompletionLevel =
        HealthInsightsController.i.intakeWaterModel?.waterCompletionLevel;
    final String completionMessage = getCompletionMessage(waterCompletionLevel);

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
          "water".tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: ColorManager.kblackColor,
            fontWeight: FontWeight.w700,
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
                  width: Get.width * 0.02,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const TodayWaterScreen());
                  },
                  child: Image.asset(
                    AppImages.info,
                    scale: 17,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  if (waterCompletionLevel != null &&
                      waterCompletionLevel >= 50)
                    Center(
                      child: Text(
                        "goodjob".tr,
                        style: GoogleFonts.poppins(
                          color: ColorManager.kblackColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Center(
                    child: Text(
                      "yourdailytask".tr,
                      style: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      completionMessage,
                      style: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const TodayWaterScreen());
                    },
                    child: CircularPercentIndicator(
                      backgroundColor: Colors.lightBlue[50]!,
                      animation: true,
                      radius: 100.0,
                      lineWidth: 20.0,
                      percent: (HealthInsightsController
                                  .i.intakeWaterModel?.waterCompletionLevel
                                  ?.toDouble() ??
                              0.0) /
                          100.0,
                      circularStrokeCap: CircularStrokeCap.round,
                      startAngle: 0,
                      reverse: false,
                      center: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularWaveContainer(
                            waves: 2,
                            waveAmplitude: 20,
                            percent: (HealthInsightsController.i
                                        .intakeWaterModel?.waterCompletionLevel
                                        ?.toDouble() ??
                                    0.0) /
                                100.0,
                          ),
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [Color(0xff1572C8), Color(0xff00EFFF)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ).createShader(bounds),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  HealthInsightsController.i.intakeWaterModel
                                          ?.waterCompletionLevel
                                          .toString() ??
                                      "0",
                                  style: GoogleFonts.poppins(
                                    fontSize: 45,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "%",
                                  style: GoogleFonts.poppins(
                                    fontSize: 28,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      progressColor: const Color.fromARGB(255, 124, 185, 238),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  GetBuilder<HealthInsightsController>(builder: (cont) {
                    final double value = cont.waterlevelUser.isNotEmpty
                        ? (cont.waterlevelUser[0].achievePoints?.toDouble() ??
                                0.0)
                            .clamp(
                                0.0,
                                cont.waterlevelUser[0].totalPoints
                                        ?.toDouble() ??
                                    5.0)
                        : 0.0;
                    final double maxRating = cont.waterlevelUser.isNotEmpty
                        ? cont.waterlevelUser[0].totalPoints?.toDouble() ?? 5.0
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
                                color:
                                    const Color.fromARGB(255, 207, 205, 205)),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          height: Get.height * 0.08,
                          width: Get.width * 0.6,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImages.badgeBase2,
                                scale: 8,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cont.waterlevelUser.isNotEmpty
                                        ? "${"your".tr} ${cont.waterlevelUser[0].rewardsLevelName}"
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
                                      RatingProgressIndicator(
                                        value: value,
                                        maxRating: maxRating,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.02,
                                      ),
                                      Text(
                                        cont.waterlevelUser.isNotEmpty
                                            ? "${cont.waterlevelUser[0].achievePoints}/${cont.waterlevelUser[0].totalPoints}"
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
                              ),
                            ],
                          ),
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
                                  color:
                                      const Color.fromARGB(255, 207, 205, 205)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            height: Get.height * 0.08,
                            width: Get.width * 0.25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppImages.badgeBase,
                                  scale: 8,
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
                  Center(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: const AddCategoryDialog(),
                            );
                          },
                        );
                      },
                      child: Text(
                        "+addactivity".tr,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xff00c2ff),
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
                                AppImages.glass,
                                scale: 10,
                              ),
                              SizedBox(
                                width: Get.width * .04,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "water".tr,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${HealthInsightsController.i.counter}",
                                        style: GoogleFonts.poppins(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      HealthInsightsController.i.counter == 1 ||
                                              HealthInsightsController
                                                      .i.counter ==
                                                  0
                                          ? Text(
                                              "glassofwater".tr,
                                              style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          : Text(
                                              "glassesofWater".tr,
                                              style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                              Row(
                                children: [
                                  // GestureDetector(
                                  //   onTap: _decrementCounter,
                                  //   child: Text(
                                  //     "-",
                                  //     style: GoogleFonts.poppins(
                                  //       fontSize: 35,
                                  //       color: Colors.white,
                                  //       fontWeight: FontWeight.w700,
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(
                                    width: Get.width * 0.03,
                                  ),
                                  Text(
                                    "${HealthInsightsController.i.counter}",
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
                                    onTap: _incrementCounter,
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
                              ),
                              SizedBox(
                                width: Get.width * 0.05,
                              ),
                            ]),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  GetBuilder<HealthInsightsController>(builder: (cont) {
                    if (cont.waterActivities.isEmpty) {
                      return Center(
                        child: Text(
                          "noactivityfound".tr,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                      child: Column(
                        children: List.generate(
                          (cont.waterActivities.length + 1) ~/
                              2, // Calculate number of rows
                          (index) {
                            final firstIndex = index * 2;
                            final secondIndex = firstIndex + 1;

                            return Padding(
                              padding:
                                  EdgeInsets.only(bottom: Get.height * 0.02),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (firstIndex < cont.waterActivities.length)
                                    CustomWaterContainer(
                                      width: Get.width * 0.43,
                                      height: Get.height * 0.14,
                                      color: Colors.transparent,
                                      image: (cont.waterActivities[firstIndex]
                                                      .imagePath ==
                                                  null ||
                                              cont.waterActivities[firstIndex]
                                                  .imagePath!.isEmpty)
                                          ? AppImages.iceIcon
                                          : baseURL +
                                              (cont.waterActivities[firstIndex]
                                                      .imagePath ??
                                                  ''),
                                      text:
                                          "${cont.waterActivities[firstIndex].numberOfGlass ?? ""} ${"glass".tr}",
                                      headingtext:
                                          "${cont.waterActivities[firstIndex].name ?? ""} ",
                                      onTap: () {
                                        _onContainerTap(cont
                                            .waterActivities[firstIndex]
                                            .waterActivityId
                                            .toString());
                                      },
                                      isSelected: HealthInsightsController
                                              .i.selectedWaterActivityId ==
                                          cont.waterActivities[firstIndex]
                                              .waterActivityId,
                                    ),
                                  if (secondIndex < cont.waterActivities.length)
                                    SizedBox(width: Get.width * 0.02),
                                  if (secondIndex < cont.waterActivities.length)
                                    CustomWaterContainer(
                                      width: Get.width * 0.43,
                                      height: Get.height * 0.14,
                                      color: Colors.transparent,
                                      image: (cont.waterActivities[secondIndex]
                                                      .imagePath ==
                                                  null ||
                                              cont.waterActivities[secondIndex]
                                                  .imagePath!.isEmpty)
                                          ? AppImages.tree
                                          : baseURL +
                                              (cont.waterActivities[secondIndex]
                                                      .imagePath ??
                                                  ''),
                                      text:
                                          "${cont.waterActivities[secondIndex].numberOfGlass ?? ""} ${"glass".tr}",
                                      headingtext:
                                          "${cont.waterActivities[secondIndex].name ?? ""} ",
                                      onTap: () {
                                        _onContainerTap(cont
                                            .waterActivities[secondIndex]
                                            .waterActivityId
                                            .toString());
                                      },
                                      isSelected: HealthInsightsController
                                              .i.selectedWaterActivityId ==
                                          cont.waterActivities[secondIndex]
                                              .waterActivityId,
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }),
                  SizedBox(
                    height: Get.height * 0.02,
                  )
                ],
              ),
              Positioned(
                top: Get.height * 0.23,
                left: Get.width * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.12),
                      child: Text(
                        "totalIntake".tr,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    Image.asset(
                      AppImages.totalintake,
                      height: 20.0,
                    ),
                  ],
                ),
              ),
              if (waterCompletionLevel != 100)
                Positioned(
                  top: Get.height * 0.18,
                  left: Get.width * 0.06,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: Get.width * 0.19),
                        child: Text(
                          "pending".tr,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      Image.asset(
                        AppImages.pendingline,
                        height: 20.0,
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

    return Stack(
      children: [
        Container(
          width: Get.width * 0.33,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          width: 100 * progress,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [
                ColorManager.kPrimaryColor,
                ColorManager.kgreenstatus,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
