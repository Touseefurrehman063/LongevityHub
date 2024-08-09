// ignore_for_file: unused_local_variable, library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:longevity_hub/components/health_insights/custom_calendar.dart';
import 'package:longevity_hub/data/controller/health_insights_controller/health_insights_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/repositories/health_insights_repo/water_detail_repo/health_insights_rewards_repo.dart';
import 'package:longevity_hub/screens/health_insights_screens/earn_rewards.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HealthySleepScreen extends StatefulWidget {
  const HealthySleepScreen({super.key});

  @override
  State<HealthySleepScreen> createState() => _HealthySleepScreenState();
}

class _HealthySleepScreenState extends State<HealthySleepScreen> {
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

  bool bedtimeLight = true;
  bool alarmLight = true;

  @override
  void initState() {
    HealthInsightsRewardRepo().getUserSleepsActivityRewardsLevel();
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
          "healthySleep".tr,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.only(left: Get.width * 0.06),
                  child: Text(
                    DateFormat('MMM dd, yyyy').format(selectedDate),
                    style: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
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
            EasyDateTimeLine(
              initialDate: DateTime.now(),
              onDateChange: (selectedDate) {},
              headerProps: const EasyHeaderProps(
                dateFormatter: DateFormatter.custom(""),
                showMonthPicker: false,
              ),
              dayProps: EasyDayProps(
                height: Get.height * 0.08,
                width: Get.width * 0.14,
                dayStructure: DayStructure.dayStrDayNum,
                activeDayStyle: DayStyle(
                  dayNumStyle: const TextStyle(color: ColorManager.kWhiteColor),
                  dayStrStyle: const TextStyle(color: ColorManager.kWhiteColor),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: Colors.orange,
                    border: Border.all(color: Colors.orange),
                  ),
                ),
                inactiveDayStyle: DayStyle(
                  dayNumStyle: const TextStyle(color: ColorManager.kblackColor),
                  dayStrStyle: const TextStyle(color: ColorManager.kblackColor),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: ColorManager.kWhiteColor,
                    border: Border.all(color: Colors.orange),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            Container(
              height: Get.height * 0.13,
              width: Get.width * 0.9,
              decoration: BoxDecoration(
                color: ColorManager.kLightGrewish,
                borderRadius: BorderRadius.circular(17),
                // border: Border.all(color: ColorManager.kLightWater),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircularPercentIndicator(
                        backgroundColor:
                            const Color.fromARGB(255, 214, 212, 212),
                        animation: true,
                        radius: 22.0,
                        lineWidth: 6.0,
                        percent: 0.4,
                        center: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.001),
                          child: Text(
                            "5h",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: ColorManager.kblackColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        progressColor: ColorManager.kPrimaryColor,
                      ),
                      CircularPercentIndicator(
                        backgroundColor:
                            const Color.fromARGB(255, 214, 212, 212),
                        animation: true,
                        radius: 22.0,
                        lineWidth: 6.0,
                        percent: 0.4,
                        center: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.001),
                          child: Text(
                            "5h",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: ColorManager.kblackColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        progressColor: ColorManager.kPrimaryColor,
                      ),
                      CircularPercentIndicator(
                        backgroundColor:
                            const Color.fromARGB(255, 214, 212, 212),
                        animation: true,
                        radius: 22.0,
                        lineWidth: 6.0,
                        percent: 0.3,
                        center: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.001),
                          child: Text(
                            "3h",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: ColorManager.kblackColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        progressColor: ColorManager.kPrimaryColor,
                      ),
                      CircularPercentIndicator(
                        backgroundColor:
                            const Color.fromARGB(255, 214, 212, 212),
                        animation: true,
                        radius: 22.0,
                        lineWidth: 6.0,
                        percent: 0.3,
                        center: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.001),
                          child: Text(
                            "5h",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: ColorManager.kblackColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        progressColor: ColorManager.kPrimaryColor,
                      ),
                      CircularPercentIndicator(
                        backgroundColor:
                            const Color.fromARGB(255, 214, 212, 212),
                        animation: true,
                        radius: 22.0,
                        lineWidth: 6.0,
                        percent: 0.8,
                        center: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.001),
                          child: Text(
                            "2h",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: ColorManager.kblackColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        progressColor: ColorManager.kPrimaryColor,
                      ),
                      CircularPercentIndicator(
                        backgroundColor:
                            const Color.fromARGB(255, 214, 212, 212),
                        animation: true,
                        radius: 22.0,
                        lineWidth: 6.0,
                        percent: 0.8,
                        center: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.001),
                          child: Text(
                            "6h",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: ColorManager.kblackColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        progressColor: ColorManager.kPrimaryColor,
                      ),
                      CircularPercentIndicator(
                        backgroundColor:
                            const Color.fromARGB(255, 214, 212, 212),
                        animation: true,
                        radius: 22.0,
                        lineWidth: 6.0,
                        percent: 0.8,
                        center: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.001),
                          child: Text(
                            "6h",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: ColorManager.kblackColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        progressColor: ColorManager.kPrimaryColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.005,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Get.width * 0.05,
                      ),
                      const Text("M"),
                      SizedBox(
                        width: Get.width * 0.1,
                      ),
                      const Text("T"),
                      SizedBox(
                        width: Get.width * 0.1,
                      ),
                      const Text("W"),
                      SizedBox(
                        width: Get.width * 0.09,
                      ),
                      const Text("T"),
                      SizedBox(
                        width: Get.width * 0.1,
                      ),
                      const Text("F"),
                      SizedBox(
                        width: Get.width * 0.1,
                      ),
                      const Text("S"),
                      SizedBox(
                        width: Get.width * 0.1,
                      ),
                      const Text("S")
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                sleepTimeContainer(),
                qualityContainer(),
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            GetBuilder<HealthInsightsController>(builder: (cont) {
              final double value = cont.sleeplevelUser.isNotEmpty
                  ? (cont.sleeplevelUser[0].achievePoints?.toDouble() ?? 0.0)
                      .clamp(0.0,
                          cont.sleeplevelUser[0].totalPoints?.toDouble() ?? 5.0)
                  : 0.0;
              final double maxRating = cont.sleeplevelUser.isNotEmpty
                  ? cont.sleeplevelUser[0].totalPoints?.toDouble() ?? 5.0
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
                            color: const Color.fromARGB(255, 207, 205, 205)),
                        borderRadius: BorderRadius.circular(6)),
                    height: Get.height * 0.08,
                    width: Get.width * 0.6,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.sleepBadge,
                            scale: 8,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cont.sleeplevelUser.isNotEmpty
                                    ? "${"your".tr} ${cont.sleeplevelUser[0].rewardsLevelName}"
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
                                    cont.sleeplevelUser.isNotEmpty
                                        ? "${cont.sleeplevelUser[0].achievePoints}/${cont.sleeplevelUser[0].totalPoints}"
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
                              color: const Color.fromARGB(255, 207, 205, 205)),
                          borderRadius: BorderRadius.circular(6)),
                      height: Get.height * 0.08,
                      width: Get.width * 0.25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.sleepEarnBadge,
                            scale: 8,
                          ),
                          SizedBox(width: Get.width * 0.02),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Get.height * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
            Container(
              width: Get.width * 0.88,
              height: Get.height * 0.28,
              decoration: BoxDecoration(
                color: ColorManager.kLightGrewish,
                borderRadius: BorderRadius.circular(17),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.04, top: Get.height * 0.02),
                        child: Text(
                          "lastsleepinfo".tr,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: ColorManager.kblackColor,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: Get.height * 0.03),
                            child: Image.asset(
                              AppImages.moon,
                              scale: 8,
                            ),
                          ),
                          SizedBox(width: Get.width * 0.02),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "6h 52m",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "timeinsleep".tr,
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: Get.height * 0.04),
                            child: Image.asset(
                              AppImages.warmweather,
                              scale: 8,
                            ),
                          ),
                          SizedBox(width: Get.width * 0.02),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "07:12 AM",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "wakeuptime".tr,
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: Get.height * 0.03),
                            child: Image.asset(
                              AppImages.clock,
                              scale: 8,
                            ),
                          ),
                          SizedBox(width: Get.width * 0.02),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "7h 23m",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "wenttobed".tr,
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: Get.height * 0.05),
                            child: Image.asset(
                              AppImages.sleep,
                              scale: 3,
                            ),
                          ),
                          SizedBox(width: Get.width * 0.04),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "25 min",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "fellasleep".tr,
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                bedTimeContainer(),
                alarmContainer(),
              ],
            ),
            SizedBox(height: Get.height * 0.03),
          ],
        ),
      ),
    );
  }

  Container qualityContainer() {
    return Container(
      width: Get.width * 0.42,
      height: Get.height * 0.22,
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
              "quality".tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: ColorManager.kblackColor,
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: Get.height * 0.03,
          ),
          Center(
            child: CircularPercentIndicator(
              backgroundColor: const Color.fromARGB(255, 214, 212, 212),
              animation: true,
              radius: 52.0,
              lineWidth: 18.0,
              percent: 0.75,
              center: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.001),
                child: Text(
                  "67%",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: ColorManager.kblackColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
              progressColor: ColorManager.kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Container bedTimeContainer() {
    return Container(
      width: Get.width * 0.42,
      height: Get.height * 0.22,
      decoration: BoxDecoration(
        color: ColorManager.kLightGrewish,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: Get.height * 0.02,
                left: Get.width * 0.04,
                right: Get.width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  AppImages.bedTime,
                  scale: 7,
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  onSelected: (String value) {
                    if (value == 'setbedtime'.tr) {
                      showBedtimePicker(context);
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<String>(
                        value: 'setbedtime'.tr,
                        child: Text(
                          'setbedtime'.tr,
                          style:
                              const TextStyle(color: ColorManager.kblackColor),
                        ),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Padding(
            padding: EdgeInsets.only(left: Get.width * 0.04),
            child: Text(
              "bedtime".tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 53, 52, 52),
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: Get.width * 0.04),
                child: Text(
                  "7h and 28min ",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: ColorManager.kblackColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Padding(
            padding: EdgeInsets.only(left: Get.width * 0.04),
            child: Transform.scale(
              scale: 0.8,
              child: CupertinoSwitch(
                value: bedtimeLight,
                activeColor: ColorManager.kPrimaryColor,
                onChanged: (bool value) {
                  setState(() {
                    bedtimeLight = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container alarmContainer() {
    return Container(
      width: Get.width * 0.42,
      height: Get.height * 0.22,
      decoration: BoxDecoration(
        color: ColorManager.kLightGrewish,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(
                  top: Get.height * 0.02, left: Get.width * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    AppImages.alarm,
                    scale: 7,
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (String value) {
                      if (value == 'setAlarm'.tr) {
                        showAlarmPicker(context);
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<String>(
                          value: 'setAlarm'.tr,
                          child: Text(
                            'setAlarm'.tr,
                            style: const TextStyle(
                                color: ColorManager.kblackColor),
                          ),
                        ),
                      ];
                    },
                  ),
                ],
              )),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Padding(
            padding: EdgeInsets.only(left: Get.width * 0.04),
            child: Text(
              "alarm".tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 53, 52, 52),
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: Get.width * 0.04),
                child: Text(
                  "16h and 18min ",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: ColorManager.kblackColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Padding(
            padding: EdgeInsets.only(left: Get.width * 0.04),
            child: Transform.scale(
              scale: 0.8,
              child: CupertinoSwitch(
                value: alarmLight,
                activeColor: ColorManager.kPrimaryColor,
                onChanged: (bool value) {
                  setState(() {
                    alarmLight = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showAlarmPicker(BuildContext context) {
    TimeOfDay selectedTime = const TimeOfDay(hour: 7, minute: 0);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlarmPickerDialog(
          selectedDate: selectedDate,
          selectedTime: selectedTime,
          onDateTimeChanged: (newDate, newTime) {
            setState(() {
              selectedDate = newDate;
              selectedTime = newTime;
            });
          },
        );
      },
    );
  }
}

class AlarmPickerDialog extends StatefulWidget {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final Function(DateTime, TimeOfDay) onDateTimeChanged;

  const AlarmPickerDialog({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.onDateTimeChanged,
  });

  @override
  _AlarmPickerDialogState createState() => _AlarmPickerDialogState();
}

class _AlarmPickerDialogState extends State<AlarmPickerDialog> {
  late DateTime selectedDate;
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.selectedDate;
    selectedTime = widget.selectedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('setAlarm'.tr,
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.kPrimaryColor)),
            const SizedBox(height: 16.0),
            ListTile(
              title: Text(
                'date'.tr,
                style: const TextStyle(color: Colors.black),
              ),
              trailing: TextButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != selectedDate) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
                child: Text(
                  "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}",
                  style: const TextStyle(color: Colors.orange),
                ),
              ),
            ),
            ListTile(
              title:
                  Text('time'.tr, style: const TextStyle(color: Colors.black)),
              trailing: TextButton(
                onPressed: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                  );
                  if (picked != null && picked != selectedTime) {
                    setState(() {
                      selectedTime = picked;
                    });
                  }
                },
                child: Text(
                  selectedTime.format(context),
                  style: const TextStyle(color: Colors.orange),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text('cancel'.tr,
                      style: const TextStyle(color: Colors.orange)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('ok'.tr,
                      style: const TextStyle(color: Colors.orange)),
                  onPressed: () {
                    widget.onDateTimeChanged(selectedDate, selectedTime);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Container sleepTimeContainer() {
  return Container(
    width: Get.width * 0.42,
    height: Get.height * 0.22,
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
            "average".tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 14,
                color: ColorManager.kblackColor,
                fontWeight: FontWeight.w400),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: Get.width * 0.04),
          child: Text(
            "sleeptime".tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 14,
                color: ColorManager.kblackColor,
                fontWeight: FontWeight.w400),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: Get.width * 0.04),
          child: Text(
            "thisweek".tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 14,
                color: ColorManager.kblackColor,
                fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: Get.width * 0.04),
              child: Text(
                "6.2",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 52,
                    color: ColorManager.kblackColor,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hours".tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: ColorManager.kblackColor,
                      fontWeight: FontWeight.w400),
                ),
                Padding(
                  padding: EdgeInsets.only(left: Get.width * 0.03),
                  child: Text(
                    "perday".tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: ColorManager.kblackColor,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

void showBedtimePicker(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const BedtimePickerDialog();
    },
  ).then((result) {
    if (result != null) {
      TimeOfDay selectedBedtime = result['bedtime'];
      TimeOfDay selectedWakeUpTime = result['wakeUpTime'];
    }
  });
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
            borderRadius: BorderRadius.circular(10), // for circular ends
          ),
        ),
        Container(
          width: 100 * progress,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), // for circular ends
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

final MaterialStateProperty<Color?> trackColor =
    MaterialStateProperty.resolveWith<Color?>(
  (Set<MaterialState> states) {
    // Track color when the switch is selected.
    if (states.contains(MaterialState.selected)) {
      return Colors.amber;
    }
    // Otherwise return null to set default track color
    // for remaining states such as when the switch is
    // hovered, focused, or disabled.
    return null;
  },
);
final MaterialStateProperty<Color?> overlayColor =
    MaterialStateProperty.resolveWith<Color?>(
  (Set<MaterialState> states) {
    // Material color when switch is selected.
    if (states.contains(MaterialState.selected)) {
      return Colors.amber.withOpacity(0.54);
    }
    // Material color when switch is disabled.
    if (states.contains(MaterialState.disabled)) {
      return Colors.grey.shade400;
    }
    // Otherwise return null to set default material color
    // for remaining states such as when the switch is
    // hovered, or focused.
    return null;
  },
);

class BedtimePickerDialog extends StatefulWidget {
  const BedtimePickerDialog({super.key});

  @override
  _BedtimePickerDialogState createState() => _BedtimePickerDialogState();
}

class _BedtimePickerDialogState extends State<BedtimePickerDialog> {
  TimeOfDay selectedBedtime = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay selectedWakeUpTime = const TimeOfDay(hour: 6, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('setbedtime'.tr,
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.kPrimaryColor)),
            const SizedBox(height: 16.0),
            ListTile(
              title: Text(
                'bedTime'.tr,
                style: const TextStyle(color: Colors.black),
              ),
              trailing: TextButton(
                onPressed: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: selectedBedtime,
                  );
                  if (picked != null && picked != selectedBedtime) {
                    setState(() {
                      selectedBedtime = picked;
                    });
                  }
                },
                child: Text(selectedBedtime.format(context),
                    style: const TextStyle(color: Colors.orange)),
              ),
            ),
            ListTile(
              title: Text('wake_uptime'.tr,
                  style: const TextStyle(color: Colors.black)),
              trailing: TextButton(
                onPressed: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: selectedWakeUpTime,
                  );
                  if (picked != null && picked != selectedWakeUpTime) {
                    setState(() {
                      selectedWakeUpTime = picked;
                    });
                  }
                },
                child: Text(selectedWakeUpTime.format(context),
                    style: const TextStyle(color: Colors.orange)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text('cancel'.tr,
                      style: const TextStyle(color: Colors.orange)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('ok'.tr,
                      style: const TextStyle(color: Colors.orange)),
                  onPressed: () {
                    // Pass the selected times back to the previous screen
                    Navigator.of(context).pop(
                      {
                        'bedtime': selectedBedtime,
                        'wakeUpTime': selectedWakeUpTime
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
