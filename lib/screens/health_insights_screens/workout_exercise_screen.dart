import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class WorkoutExcerciseScreen extends StatefulWidget {
  const WorkoutExcerciseScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutExcerciseScreen> createState() => _WorkoutExcerciseScreenState();
}

class _WorkoutExcerciseScreenState extends State<WorkoutExcerciseScreen> {
  final List<String> imgList = [
    AppImages.videotemp,
    // AppImages.enerGym,
  ];

  int _currentIndex = 0;

  final List<String> exerciseText = [
    "Exercise (1)",
    "Exercise (2)",
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
            "My Exercises",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: ColorManager.kblackColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    "Exercise (${_currentIndex + 1})",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: ColorManager.kblackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                CarouselSlider(
                  options: CarouselOptions(
                    height: Get.height * 0.2,
                    enlargeCenterPage: true,
                    autoPlay: false,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: imgList
                      .map((item) => GestureDetector(
                            onTap: () {
                              // Get.to(const WorkOutVideoScreen());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage(item),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
                SizedBox(height: Get.height * 0.03),
                Padding(
                  padding: EdgeInsets.only(left: Get.width * .06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Day 7 Advance Work Out Routine",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: ColorManager.kblackColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "4min 20 sec",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: ColorManager.kGreyColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      SizedBox(
                        width: Get.width * 0.8,
                        child: Text(
                          "Run around your house for about 10 mins, and rest for about 2 mins. Do this for 3 reps, and you’re done with day 1.",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: ColorManager.kGreyColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      ...List.generate(3, (index) {
                        return ListTile(
                          leading: Image.asset(
                            AppImages.checkbox,
                            height: Get.height * 0.02,
                          ),
                          title: Text(
                            "1st Reps",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: ColorManager.kblackColor,
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: Get.height * 0.14,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            AppImages.timer,
                            scale: 22,
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          Text(
                            "03 min 30 sec",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: ColorManager.kblackColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.32,
                          ),
                          CustomButton(
                            buttonheight: Get.height * 0.04,
                            backgroundColor: ColorManager.kPrimaryColor,
                            buttonwidth: Get.width * 0.18,
                            onPress: () {
                              Get.back();
                            },
                            radius: 25,
                            mywidget: Text(
                              "Done",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: ColorManager.kblackColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
