import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/data/controller/intro_steps_controller/intro_steps_controller.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/steps_screen/weight_screen.dart';
import 'package:longevity_hub/screens/steps_screen/welcome_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class HeightScreen extends StatefulWidget {
  const HeightScreen({super.key});

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  late Future<String> heightUnitFuture;

  @override
  void initState() {
    super.initState();
    StepsController.i.selectedFeet = 5.6;
    StepsController.i.selectedCm = 165;
    StepsController.i.selectedHeight = "Feet";
    StepsController.i.fetchHeightMeasurements();
    heightUnitFuture = _fetchHeightUnit();
  }

  Future<String> _fetchHeightUnit() async {
    return StepsController.i.selectedHeight;
  }

  void _changeHeightUnit(String unit) {
    setState(() {
      if (unit == "Feet" && StepsController.i.selectedHeight == "Centimeter") {
        StepsController.i.selectedFeet = (StepsController.i.selectedCm / 30.48);
      } else if (unit == "Centimeter" &&
          StepsController.i.selectedHeight == "Feet") {
        StepsController.i.selectedCm =
            (StepsController.i.selectedFeet * 30.48).round();
      }
      StepsController.i.selectedHeight = unit;
      heightUnitFuture = _fetchHeightUnit();
    });
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
          "step3of7".tr,
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
                    'selectHeight'.tr,
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.kblackColor,
                    ),
                  ),
                  Text(
                    'thishelpcreateyourplan'.tr,
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
                              _changeHeightUnit("Feet");
                            },
                            child: Container(
                              height: Get.height * 0.05,
                              width: Get.width * 0.35,
                              decoration: BoxDecoration(
                                color:
                                    StepsController.i.selectedHeight == "Feet"
                                        ? Colors.white
                                        : const Color(0xffFDA11A),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  StepsController
                                          .i.heightMeasurements.isNotEmpty
                                      ? StepsController
                                          .i.heightMeasurements[1].name!
                                      : "Feet", //feet
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: ColorManager.kblackColor,
                                    fontWeight:
                                        StepsController.i.selectedHeight ==
                                                "Feet"
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _changeHeightUnit("Centimeter");
                            },
                            child: Container(
                              height: Get.height * 0.05,
                              width: Get.width * 0.35,
                              decoration: BoxDecoration(
                                color: StepsController.i.selectedHeight ==
                                        "Centimeter"
                                    ? Colors.white
                                    : const Color(0xffFDA11A),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  StepsController
                                          .i.heightMeasurements.isNotEmpty
                                      ? StepsController
                                          .i.heightMeasurements[0].name!
                                      : "Centimeter",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: ColorManager.kblackColor,
                                    fontWeight:
                                        StepsController.i.selectedHeight ==
                                                "Centimeter"
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
                  FutureBuilder<String>(
                    future: heightUnitFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else if (!snapshot.hasData) {
                        return const Text("No data");
                      } else {
                        return snapshot.data == "Feet"
                            ? SizedBox(
                                height: Get.height * 0.49,
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 2,
                                            width: Get.width * 0.4,
                                            color: const Color(0xffFDA11A),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.07,
                                          ),
                                          Container(
                                            height: 2,
                                            width: Get.width * 0.4,
                                            color: const Color(0xffFDA11A),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: ListWheelScrollView(
                                        itemExtent: 85,
                                        clipBehavior: Clip.antiAlias,
                                        physics:
                                            const FixedExtentScrollPhysics(),
                                        onSelectedItemChanged: (index) {
                                          StepsController.i.selectedFeet =
                                              (index + 17) / 10;
                                          setState(() {});
                                        },
                                        controller: FixedExtentScrollController(
                                          initialItem:
                                              (StepsController.i.selectedFeet *
                                                          10)
                                                      .round() -
                                                  17,
                                        ),
                                        children: List.generate(65, (index) {
                                          double feetValue = (index + 17) / 10;
                                          return FeetSelectionButton(
                                            number: feetValue,
                                            isSelected: feetValue ==
                                                StepsController.i.selectedFeet,
                                            prefix: StepsController
                                                    .i
                                                    .heightMeasurements
                                                    .isNotEmpty
                                                ? StepsController
                                                    .i
                                                    .heightMeasurements[1]
                                                    .prefix!
                                                : "ft",
                                          );
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(
                                height: Get.height * 0.49,
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 2,
                                            width: Get.width * 0.4,
                                            color: const Color(0xffFDA11A),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.07,
                                          ),
                                          Container(
                                            height: 2,
                                            width: Get.width * 0.4,
                                            color: const Color(0xffFDA11A),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: ListWheelScrollView(
                                        itemExtent: 85,
                                        clipBehavior: Clip.antiAlias,
                                        physics:
                                            const FixedExtentScrollPhysics(),
                                        onSelectedItemChanged: (index) {
                                          StepsController.i.selectedCm =
                                              index + 51;
                                          setState(() {});
                                        },
                                        controller: FixedExtentScrollController(
                                          initialItem:
                                              StepsController.i.selectedCm - 51,
                                        ),
                                        children: List.generate(197, (index) {
                                          int cmValue = index + 51;
                                          return CmSelectionButton(
                                            number: cmValue,
                                            isSelected: cmValue ==
                                                StepsController.i.selectedCm,
                                            prefix: StepsController
                                                    .i
                                                    .heightMeasurements
                                                    .isNotEmpty
                                                ? StepsController
                                                    .i
                                                    .heightMeasurements[0]
                                                    .prefix!
                                                : "cm",
                                          );
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      }
                    },
                  ),
                ],
              ),
              Expanded(child: Container()),
              CustomButton(
                buttonheight: Get.height * 0.07,
                backgroundColor: ColorManager.kPrimaryColor,
                buttonwidth: Get.width * 0.85,
                onPress: () async {
                  StepsController.i.selectedHeight == "Feet"
                      ? await LocalDb().saveHeightData(
                          StepsController.i.selectedFeet.toString(),
                          StepsController.i.heightMeasurements[1]
                              .id!) // Potential cause of RangeError
                      : await LocalDb().saveHeightData(
                          StepsController.i.selectedCm.toString(),
                          StepsController.i.heightMeasurements[0]
                              .id!); // Potential cause of RangeError
                  Get.to(() => const WeightScreen());
                },
                mywidget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "next",
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

class CmSelectionButton extends StatelessWidget {
  final int number;
  final bool isSelected;
  final String prefix;

  const CmSelectionButton({
    Key? key,
    required this.number,
    required this.isSelected,
    required this.prefix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$number',
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          SizedBox(
            width: Get.width * 0.02,
          ),
          Text(
            isSelected ? prefix : "",
            style: TextStyle(
              fontSize: isSelected ? 24 : 30,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class FeetSelectionButton extends StatelessWidget {
  final double number;
  final bool isSelected;
  final String prefix;

  const FeetSelectionButton({
    Key? key,
    required this.number,
    required this.isSelected,
    required this.prefix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$number',
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          SizedBox(
            width: Get.width * 0.02,
          ),
          Text(
            isSelected ? prefix : "",
            style: TextStyle(
              fontSize: isSelected ? 24 : 30,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
