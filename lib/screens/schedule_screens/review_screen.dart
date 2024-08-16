// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/components/custom_review_card/custom_review_card.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/schedule_screens/write_expert_review_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  DateTime _selectedDay = DateTime.now();
  final int _selectedTimeSlotIndex = -1;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
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
          "reviews".tr,
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
          // Background Image
          // Positioned.fill(
          //   child: Image.asset(
          //     AppImages.background,
          //     fit: BoxFit.cover,
          //   ),
          // ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        "4.6", // Assuming the rating is displayed elsewhere
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 48,
                          color: ColorManager.kblackColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          RatingProgressIndicator(
                            text: "5",
                            value: 0.6,
                          ),
                          RatingProgressIndicator(
                            text: "4",
                            value: 0.8,
                          ),
                          RatingProgressIndicator(
                            text: "3",
                            value: 0.3,
                          ),
                          RatingProgressIndicator(
                            text: "2",
                            value: 0.2,
                          ),
                          RatingProgressIndicator(
                            text: "1",
                            value: 0.1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "174 ${"ratings".tr}", // Assuming the rating is displayed elsewhere
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: ColorManager.kblackColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: Get.height * 0.025,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      // Use CustomActivityContainer within itemBuilder
                      return Column(
                        children: [
                          CustomReviewCard(
                            centerText: "Jason Ronald",
                            centerText2: "2d ago",
                            centerText3:
                                "Had such an amazing session with Maria. She instantly picked up on the level of my fitness and adjusted the workout to suit me whilst also pushing me to my limits.",
                            bkColor: const Color(0xFF2C2C2E),
                            buttontext: "4.6",
                            trailingImage: Image.asset(
                              AppImages.avatar,
                              fit: BoxFit.cover,
                              scale: 10,
                            ),
                            statustext: "Booked",
                            dateTimeText:
                                "Feb 20, 2022 | \n                  16:00",
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                // SizedBox(
                //   height: Get.height * 0.04,
                // ),

                SizedBox(
                  height: Get.height * 0.01,
                ),
              ],
            ),
          ),
          // Black fade at the bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: Get.height * 0.15,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.9),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: Get.height * 0.68,
            left: Get.width * 0.12,
            child: Center(
              child: CustomButton(
                buttonheight: Get.height * 0.07,
                backgroundColor: ColorManager.kPrimaryColor,
                buttonwidth: Get.width * 0.75,
                onPress: () {
                  Get.to(() => const WriteExpertReviewScreen());
                },
                mywidget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "writeareview".tr,
                      style: GoogleFonts.poppins(
                          color: ColorManager.kblackColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                radius: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RatingProgressIndicator extends StatelessWidget {
  const RatingProgressIndicator(
      {super.key, required this.text, required this.value});
  final String text;
  final double value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 9,
              color: ColorManager.kPrimaryColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: LinearProgressIndicator(
            value: value,
            minHeight: 5,
            backgroundColor: Colors.black,
            borderRadius: BorderRadius.circular(8),
            valueColor:
                const AlwaysStoppedAnimation(ColorManager.kPrimaryColor),
          ),
        )
      ],
    );
  }
}
