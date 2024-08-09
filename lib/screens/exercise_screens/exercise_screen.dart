import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class ExerciseScreen extends StatefulWidget {
  final bool navigateToMenuScreen;
  const ExerciseScreen({super.key, this.navigateToMenuScreen = false});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              AppImages.logo,
              scale: 18,
              // color: ColorManager.kGreyColor,
            ),
          ),
          Center(
            child: Text(
              "comingsoon".tr,
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ),
          SizedBox(
            height: Get.height * 0.04,
          ),
        ],
      ),
    );
  }
}
