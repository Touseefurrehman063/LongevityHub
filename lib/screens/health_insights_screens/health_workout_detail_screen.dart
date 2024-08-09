import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/components/health_insights/custom_days_list_conatiner.dart';
import 'package:longevity_hub/components/health_insights/custom_select_exercise_container.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/health_insights_screens/workout_goal_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class WorkoutDetailScreen extends StatefulWidget {
  const WorkoutDetailScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  List<bool> isSelectedCategories = List.generate(10, (index) => index == 0);
  void selectCategory(int selectedIndex) {
    setState(() {
      for (int i = 0; i < isSelectedCategories.length; i++) {
        isSelectedCategories[i] = (i == selectedIndex);
      }
    });
  }

  @override
  void initState() {
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
          "workoutdetail".tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: ColorManager.kblackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: Get.height * 0.02,
          horizontal: Get.width * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Monday, Feb 16, 2024",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: ColorManager.kblackColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    "seeall".tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: ColorManager.kPrimaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            SizedBox(
              height: Get.height * 0.08,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                separatorBuilder: (context, index) =>
                    SizedBox(width: Get.width * 0.03),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return CustomDaysConatiner(
                    text: "${"day".tr} 1",
                    isSelected: isSelectedCategories[index],
                    onTap: () {
                      selectCategory(index);
                    },
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Select Any 5 Exercises",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: ColorManager.kblackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: Get.height * 0.02),
                    child: CustomSelectExerciseContainer(
                      centerText: "legpressMachine".tr,
                      centerText2: "3 ${"minutes".tr} (20s ${"Each".tr})",
                      centerText3: "10 min",
                      bkColor: const Color(0xFF2C2C2E),
                      trailingImage: AppImages.videoTempIcon,
                      statustext: "Beginner",
                      clientText: "16 Active Clients",
                      rowText: "have made an appointment",
                      timingtext: "Available Timings",
                      amText: "09:00 am",
                      pmText: "05:00 pm",
                    ),
                  );
                },
              ),
            ),
            CustomButton(
              buttonheight: Get.height * 0.07,
              backgroundColor: ColorManager.kPrimaryColor,
              buttonwidth: Get.width * 0.78,
              onPress: () async {
                Get.to(() => const WorkOutGoalScreen());
              },
              mywidget: Text(
                "setGoal".tr,
                style: GoogleFonts.poppins(
                    color: ColorManager.kblackColor, fontSize: 20),
              ),
              radius: 10,
            ),
          ],
        ),
      ),
    );
  }
}
