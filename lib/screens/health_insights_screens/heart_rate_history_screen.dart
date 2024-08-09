import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/health_insights_screens/heart_rate_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class HeartRateHistoryScreen extends StatefulWidget {
  const HeartRateHistoryScreen({Key? key}) : super(key: key);

  @override
  State<HeartRateHistoryScreen> createState() => _HeartRateHistoryScreenState();
}

class _HeartRateHistoryScreenState extends State<HeartRateHistoryScreen> {
  final double _value = 12.2;
  final double _maxRating = 5.0;
  final double value = 6.2;
  final double maxRating = 5.0;
  String currentDateTime = '';

  @override
  void initState() {
    super.initState();
    currentDateTime = DateFormat('dd-MM-yyyy | HH:mm').format(DateTime.now());
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
          "Heart Rate",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: ColorManager.kblackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.01,
              horizontal: Get.width * 0.04,
            ),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(height: Get.height * 0.03),
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          AppImages.heartImage,
                          scale: 5,
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Text(
                          "89",
                          style: GoogleFonts.poppins(
                            fontSize: 32,
                            color: ColorManager.kblackColor,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "bpm",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: ColorManager.kblackColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Text(
                          currentDateTime,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: ColorManager.kblackColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Get.width * .04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "High",
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
                          padding:
                              EdgeInsets.symmetric(horizontal: Get.width * .04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Low",
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
                        CustomButton(
                          buttonheight: Get.height * 0.07,
                          backgroundColor: ColorManager.kWhiteColor,
                          borderColor: ColorManager.kPrimaryColor,
                          buttonwidth: Get.width * 0.68,
                          onPress: () async {},
                          mywidget: Text(
                            "Start",
                            style: GoogleFonts.poppins(
                                color: ColorManager.kPrimaryColor,
                                fontSize: 20),
                          ),
                          radius: 10,
                        ),
                        SizedBox(
                          height: Get.height * 0.005,
                        ),
                        CustomButton(
                          buttonheight: Get.height * 0.07,
                          backgroundColor:
                              const Color.fromARGB(255, 253, 199, 118),
                          buttonwidth: Get.width * 0.68,
                          onPress: () async {
                            Get.to(() => const HeartRateScreen());
                          },
                          mywidget: Text(
                            "Save",
                            style: GoogleFonts.poppins(
                                color: ColorManager.kGreyColor, fontSize: 20),
                          ),
                          radius: 10,
                        ),
                      ],
                    ),
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
