// ignore_for_file: unused_element, deprecated_member_use

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/health_insights/custom_heart_bmp_containe.dart';
import 'package:longevity_hub/data/controller/health_insights_controller/health_insights_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/health_insights_screens/heart_rate_history_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class HeartRateScreen extends StatefulWidget {
  const HeartRateScreen({Key? key}) : super(key: key);

  @override
  State<HeartRateScreen> createState() => _HeartRateScreenState();
}

class _HeartRateScreenState extends State<HeartRateScreen> {
  final double _value = 12.2;
  final double _maxRating = 5.0;
  final double value = 6.2;
  final double maxRating = 5.0;

  @override
  void initState() {
    super.initState();
    HealthInsightsController.i.selecetedrate = "heartRate".tr;
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
          "heartRate".tr,
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
            child: InkWell(
              onTap: () {
                // Handle info icon tap
              },
              child: Image.asset(
                AppImages.info,
                scale: 17,
              ),
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
                  Container(
                    height: Get.height * 0.05,
                    width: Get.width * 0.7,
                    decoration: BoxDecoration(
                      color: const Color(0xffFDA11A),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              HealthInsightsController.i.selecetedrate =
                                  "heartRate".tr;
                              setState(() {});
                            },
                            child: Container(
                              height: Get.height * 0.04,
                              width: Get.width * 0.3,
                              decoration: BoxDecoration(
                                color:
                                    HealthInsightsController.i.selecetedrate ==
                                            "heartRate".tr
                                        ? Colors.white
                                        : ColorManager.kPrimaryColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  "heartRate".tr,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: ColorManager.kblackColor,
                                    fontWeight: HealthInsightsController
                                                .i.selecetedrate ==
                                            "heartRate".tr
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              HealthInsightsController.i.selecetedrate =
                                  "history".tr;
                              setState(() {});
                            },
                            child: Container(
                              height: Get.height * 0.04,
                              width: Get.width * 0.3,
                              decoration: BoxDecoration(
                                color:
                                    HealthInsightsController.i.selecetedrate ==
                                            "history".tr
                                        ? Colors.white
                                        : ColorManager.kPrimaryColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  "history".tr,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: ColorManager.kblackColor,
                                    fontWeight: HealthInsightsController
                                                .i.selecetedrate ==
                                            "history".tr
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.03),
                  HealthInsightsController.i.selecetedrate == "heartRate".tr
                      ? SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    Get.to(
                                        () => const HeartRateHistoryScreen());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: const Color(0xff5d0000),
                                    ),
                                    height: Get.height * 0.26,
                                    width: Get.width * 0.9,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: Get.height * 0.015,
                                            horizontal: Get.width * 0.04,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "heartbpms".tr,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 18,
                                                  color:
                                                      ColorManager.kWhiteColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    AppImages.heartbpmicon,
                                                    scale: 12,
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.02,
                                                  ),
                                                  Image.asset(
                                                    AppImages.shareIcon,
                                                    scale: 10,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              right: Get.width * 0.09,
                                              left: 2.0,
                                            ),
                                            child: LineChart(
                                              LineChartData(
                                                gridData: FlGridData(
                                                  drawHorizontalLine: true,
                                                  drawVerticalLine: false,
                                                  horizontalInterval: 35,
                                                  getDrawingHorizontalLine:
                                                      (value) {
                                                    return FlLine(
                                                      color: Colors.white,
                                                      strokeWidth: 2,
                                                    );
                                                  },
                                                ),
                                                titlesData: FlTitlesData(
                                                  bottomTitles: SideTitles(
                                                    showTitles: true,
                                                    reservedSize: 25,
                                                    getTextStyles:
                                                        (context, value) =>
                                                            const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10,
                                                    ),
                                                    getTitles: (value) {
                                                      if (value >= 0 &&
                                                          value <= 24) {
                                                        int hour =
                                                            value.toInt();
                                                        int minute =
                                                            ((value - hour) *
                                                                    60)
                                                                .toInt();

                                                        String formattedTime =
                                                            '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

                                                        return formattedTime;
                                                      } else {
                                                        return '';
                                                      }
                                                    },
                                                    margin: 6,
                                                  ),
                                                  leftTitles: SideTitles(
                                                    showTitles: true,
                                                    getTextStyles:
                                                        (context, value) =>
                                                            const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10,
                                                    ),
                                                    getTitles: (value) {
                                                      return value.toString();
                                                    },
                                                    reservedSize: 32,
                                                    margin: 14,
                                                  ),
                                                  rightTitles: SideTitles(
                                                    showTitles: false,
                                                  ),
                                                  topTitles: SideTitles(
                                                      showTitles: false),
                                                ),
                                                borderData: FlBorderData(
                                                  show: false,
                                                ),
                                                minX: 6,
                                                maxX: 21.5,
                                                minY: 0,
                                                maxY: 200,
                                                lineBarsData: [
                                                  LineChartBarData(
                                                    spots: [
                                                      const FlSpot(6, 70),
                                                      const FlSpot(8.5, 120),
                                                      const FlSpot(11, 70),
                                                      const FlSpot(14, 160),
                                                      const FlSpot(17, 110),
                                                    ],
                                                    isCurved: true,
                                                    barWidth: 4,
                                                    colors: [
                                                      const Color(0xffFF0000),
                                                    ],
                                                    dotData:
                                                        FlDotData(show: false),
                                                    belowBarData: BarAreaData(
                                                        show: false),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
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
                                  CustomBmpContainer(
                                    width: Get.width * 0.43,
                                    height: Get.height * 0.22,
                                    color: ColorManager.kLightPink,
                                    image: AppImages.bmpRangeIcon,
                                    text: '60-100',
                                    headingtext: 'bpmrange'.tr,
                                    scale: 9,
                                    unitText: "bpm",
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.04,
                                  ),
                                  CustomBmpContainer(
                                    width: Get.width * 0.43,
                                    height: Get.height * 0.22,
                                    color: ColorManager.kGreenLight,
                                    image: AppImages.restingIcon,
                                    text: '20',
                                    headingtext: 'resting'.tr,
                                    unitText: "bpm",
                                    scale: 7.5,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * .04),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "hightoday".tr,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      "150 bpm",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              HighRatingProgressIndicator(
                                value: _value,
                                maxRating: _maxRating,
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * .04),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "lowtoday".tr,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      "68 bpm",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              LowRatingProgressIndicator(
                                value: value,
                                maxRating: maxRating,
                              ),
                              SizedBox(
                                height: Get.height * 0.03,
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     CustomHeartRangeContainer(
                              //       width: Get.width * 0.43,
                              //       height: Get.height * 0.28,
                              //       color: ColorManager.kWhiteColor,
                              //       image: AppImages.tempIconCont,
                              //       text: '99',
                              //       headingtext: 'Body\nTemperature',
                              //       scale: 4,
                              //       unitText: "Normal",
                              //       squaretext: "°F",
                              //       squareheight: Get.height * 0.09,
                              //       squarewidth: Get.width * 0.22,
                              //       contColor: const Color(0xffbbf246),
                              //       waveImage: AppImages.bpwave,
                              //     ),
                              //     SizedBox(
                              //       width: Get.width * 0.04,
                              //     ),
                              //     CustomHeartRangeContainer(
                              //       width: Get.width * 0.43,
                              //       height: Get.height * 0.28,
                              //       color: ColorManager.kWhiteColor,
                              //       image: AppImages.sugarIconCont,
                              //       text: '80',
                              //       headingtext: 'Blood\nSugar',
                              //       unitText: "Normal",
                              //       scale: 4,
                              //       squaretext: "mg/dL",
                              //       squareheight: Get.height * 0.09,
                              //       squarewidth: Get.width * 0.16,
                              //       contColor: const Color(0xfff8debd),
                              //       waveImage: AppImages.sugarwave,
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(
                                    'bloodpressure'.tr,
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: ColorManager.kPrimaryColor),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.05,
                                  ),
                                  Container(
                                    height: Get.height * 0.55,
                                    width: Get.width * 1,
                                    decoration: BoxDecoration(
                                      color: const Color(0xfffff0e0),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: Get.width * 0.25,
                                            vertical: Get.height * 0.02,
                                          ),
                                          child: Text(
                                            'history'.tr,
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color:
                                                    ColorManager.kPrimaryColor),
                                          ),
                                        ),
                                        Table(
                                          border: TableBorder.all(
                                              color: Colors
                                                  .transparent), // Hide table borders
                                          children: [
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Center(
                                                    child: Text(
                                                      'values'.tr,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: ColorManager
                                                              .kblackColor),
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Center(
                                                    child: Text(
                                                      'condition'.tr,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: ColorManager
                                                              .kblackColor),
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Center(
                                                    child: Text(
                                                      'date/time'.tr,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: ColorManager
                                                              .kblackColor),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // Add spacing between the header and the rows
                                            TableRow(
                                              children: [
                                                SizedBox(
                                                    height: Get.height * 0.01),
                                                SizedBox(
                                                    height: Get.height * 0.01),
                                                SizedBox(
                                                    height: Get.height * 0.01),
                                              ],
                                            ),

                                            buildTableRow('132/90', 'High'.tr,
                                                '16-06-2023- 15:23'),
                                            buildTableRow('132/90', 'High'.tr,
                                                '16-06-2023- 15:23'),
                                            buildTableRow('132/90', 'High'.tr,
                                                '16-06-2023- 15:23'),
                                            buildTableRow('132/90', 'High'.tr,
                                                '16-06-2023- 15:23'),
                                            buildTableRow('132/90', 'High'.tr,
                                                '16-06-2023- 15:23'),
                                            buildTableRow('132/90', 'High'.tr,
                                                '16-06-2023- 15:23'),
                                            buildTableRow('132/90', 'High'.tr,
                                                '16-06-2023- 15:23'),
                                          ],
                                        ),
                                      ],
                                    ),
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
}

class HighRatingProgressIndicator extends StatelessWidget {
  const HighRatingProgressIndicator({
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
          width: Get.width * 0.85,
          height: Get.height * 0.04,
          decoration: BoxDecoration(
            color: const Color(0xffebeff4),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        Container(
          width: 100 * progress,
          height: Get.height * 0.04,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [
                Color(0xffeb3349),
                Color(0xfffd9727),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LowRatingProgressIndicator extends StatelessWidget {
  const LowRatingProgressIndicator({
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
          width: Get.width * 0.85,
          height: Get.height * 0.04,
          decoration: BoxDecoration(
            color: const Color(0xffebeff4),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        Container(
          width: 100 * progress,
          height: Get.height * 0.04,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [
                Color(0xff396afc),
                Color(0xffbbf246),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

TableRow buildTableRow(String value, String condition, String dateTime) {
  return TableRow(
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(4),
      // padding:EdgeInsets.symmetric(vertical: 4), // Add vertical spacing
    ),
    children: [
      Center(
        child: Text(
          value,
          style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: ColorManager.kblackColor),
        ),
      ),
      Center(
        child: Text(
          condition.tr,
          style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: ColorManager.kblackColor),
        ),
      ),
      Center(
        child: Text(
          dateTime,
          style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: ColorManager.kblackColor),
        ),
      ),
    ],
  );
}
