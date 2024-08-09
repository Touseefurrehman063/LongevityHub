import 'package:animated_weight_picker/animated_weight_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/data/controller/intro_steps_controller/intro_steps_controller.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/steps_screen/physical_activity_level.dart';
import 'package:longevity_hub/screens/steps_screen/welcome_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({Key? key}) : super(key: key);

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  @override
  void initState() {
    StepsController.i.fetchWeightMeasurements();
    StepsController.i.selectedValue = StepsController.i.min.toString();
    StepsController.i.selectedPound = StepsController.i.minp.toString();
    StepsController.i.selectedWeight = "Kilogram";
    super.initState();
  }

  double convertPoundsToKilograms(double pounds) {
    return pounds / 2.20462;
  }

  double convertKilogramsToPounds(double kilograms) {
    return kilograms * 2.20462;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "step4to7".tr,
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
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.07),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.background),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'whatisyourweight'.tr,
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.kblackColor,
                    ),
                  ),
                  Text(
                    'youcanchangelater'.tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: ColorManager.kblackColor,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),

                  Container(
                    height: Get.height * 0.07,
                    width: Get.width * 0.8,
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
                              StepsController.i.weightMeasurements.isNotEmpty
                                  ? StepsController.i.selectedWeight =
                                      StepsController
                                          .i.weightMeasurements[1].name!
                                  : "Pound";
                              setState(() {});
                            },
                            child: Container(
                              height: Get.height * 0.05,
                              width: Get.width * 0.35,
                              decoration: BoxDecoration(
                                color:
                                    StepsController.i.selectedWeight == "Pound"
                                        ? Colors.white
                                        : const Color(0xffFDA11A),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  StepsController
                                          .i.weightMeasurements.isNotEmpty
                                      ? StepsController
                                          .i.weightMeasurements[1].name!
                                      : "Pound",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: ColorManager.kblackColor,
                                    fontWeight:
                                        StepsController.i.selectedWeight ==
                                                "Pound"
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              StepsController.i.weightMeasurements.isNotEmpty
                                  ? StepsController.i.selectedWeight =
                                      StepsController
                                          .i.weightMeasurements[0].name!
                                  : "Kilogram";
                              setState(() {});
                            },
                            child: Container(
                              height: Get.height * 0.05,
                              width: Get.width * 0.35,
                              decoration: BoxDecoration(
                                color: StepsController.i.selectedWeight ==
                                        "Kilogram"
                                    ? Colors.white
                                    : const Color(0xffFDA11A),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  StepsController
                                          .i.weightMeasurements.isNotEmpty
                                      ? StepsController
                                          .i.weightMeasurements[0].name!
                                      : "Kilogram",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: ColorManager.kblackColor,
                                    fontWeight:
                                        StepsController.i.selectedWeight ==
                                                "Kilogram"
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

                  SizedBox(
                    height: Get.height * 0.15,
                  ),

                  // Weight picker based on selected unit
                  StepsController.i.selectedWeight == "Kilogram"
                      ? buildKilogramPicker()
                      : buildPoundPicker(),

                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  CustomButton(
                    buttonheight: Get.height * 0.07,
                    backgroundColor: ColorManager.kPrimaryColor,
                    buttonwidth: Get.width * 0.85,
                    onPress: () async {
                      // Save weight data based on selected unit
                      StepsController.i.selectedWeight == "Pound"
                          ? await LocalDb().saveWeightData(
                              StepsController.i.selectedPound.toString(),
                              StepsController.i.weightMeasurements[1].id!,
                            )
                          : await LocalDb().saveWeightData(
                              StepsController.i.selectedValue.toString(),
                              StepsController.i.weightMeasurements[0].id!,
                            );

                      // Navigate to next screen
                      Get.to(() => const PhysicalActivityScreen());
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
            ],
          ),
        ),
      ),
    );
  }

  Widget buildKilogramPicker() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                StepsController.i.selectedValue,
                style: GoogleFonts.poppins(
                  color: ColorManager.kblackColor,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: Get.width * 0.01,
              ),
              Text(
                "kg",
                style: GoogleFonts.poppins(
                  color: ColorManager.kblackColor,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.1,
          ),
          Transform(
            transform: Matrix4.rotationX(3.14),
            child: AnimatedWeightPicker(
              dialColor: ColorManager.kPrimaryColor,
              dialThickness: 4,
              subIntervalThickness: 3,
              majorIntervalThickness: 3,
              minorIntervalThickness: 3,
              subIntervalHeight: Get.height * 0.065,
              majorIntervalHeight: Get.height * 0.065,
              minorIntervalHeight: Get.height * 0.04,
              dialHeight: Get.height * 0.095,
              suffixTextColor: ColorManager.kblackColor,
              subIntervalColor: ColorManager.kPrimaryColor,
              majorIntervalColor: ColorManager.kPrimaryColor,
              minorIntervalColor: ColorManager.kPrimaryColor,
              selectedValueColor: ColorManager.kblackColor,
              subIntervalTextColor: ColorManager.kPrimaryColor,
              majorIntervalTextColor: ColorManager.kPrimaryColor,
              minorIntervalTextColor: ColorManager.kPrimaryColor,
              showMinorIntervalText: false,
              showMajorIntervalText: false,
              showSelectedValue: false,
              min: StepsController.i.min,
              max: StepsController.i.max,
              onChange: (newValue) {
                setState(() {
                  StepsController.i.selectedValue = newValue;
                  StepsController.i.selectedPound =
                      convertKilogramsToPounds(double.parse(newValue))
                          .toStringAsFixed(2);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPoundPicker() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                StepsController.i.selectedPound,
                style: GoogleFonts.poppins(
                  color: ColorManager.kblackColor,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: Get.width * 0.01,
              ),
              Text(
                "lbs",
                style: GoogleFonts.poppins(
                  color: ColorManager.kblackColor,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.1,
          ),
          Transform(
            transform: Matrix4.rotationX(3.14),
            child: AnimatedWeightPicker(
              dialColor: ColorManager.kPrimaryColor,
              dialThickness: 4,
              subIntervalThickness: 3,
              majorIntervalThickness: 3,
              minorIntervalThickness: 3,
              subIntervalHeight: Get.height * 0.065,
              majorIntervalHeight: Get.height * 0.065,
              minorIntervalHeight: Get.height * 0.04,
              dialHeight: Get.height * 0.095,
              suffixTextColor: ColorManager.kblackColor,
              subIntervalColor: ColorManager.kPrimaryColor,
              majorIntervalColor: ColorManager.kPrimaryColor,
              minorIntervalColor: ColorManager.kPrimaryColor,
              selectedValueColor: ColorManager.kblackColor,
              subIntervalTextColor: ColorManager.kPrimaryColor,
              majorIntervalTextColor: ColorManager.kPrimaryColor,
              minorIntervalTextColor: ColorManager.kPrimaryColor,
              showMinorIntervalText: false,
              showMajorIntervalText: false,
              showSelectedValue: false,
              min: 0,
              max: 400,
              onChange: (newValue) {
                setState(() {
                  StepsController.i.selectedPound = newValue;
                  StepsController.i.selectedValue =
                      convertPoundsToKilograms(double.parse(newValue))
                          .toStringAsFixed(2);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
