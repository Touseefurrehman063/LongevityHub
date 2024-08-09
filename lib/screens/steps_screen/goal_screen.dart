import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/steps_screen/physical_activity_level.dart';
import 'package:longevity_hub/screens/steps_screen/welcome_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  String selectedGoal = "Gain more flexible B";
  List<String> stringList = [
    'Gain more flexible',
    'Gain more flexible B',
    'Gain more flexible C'
  ];

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
          "Step 8 of 9",
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
                    'skip',
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
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.07),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Align text to the top
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'What’s your goal ?'.tr,
                  style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.kblackColor,
                  ),
                ),
                Text(
                  'You can always change this later.'.tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: ColorManager.kblackColor,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.07,
                ),

                //

                SizedBox(
                  height: Get.height * 0.49,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 2,
                              width: Get.width * 0.8,
                              color: const Color(0xffFDA11A),
                            ),
                            SizedBox(
                              height: Get.height * 0.06,
                            ), // Adjust the vertical spacing as needed
                            Container(
                              height: 2,
                              width: Get.width * 0.8,
                              color: const Color(0xffFDA11A),
                            ),
                          ],
                        ),
                      ),
                      Positioned.fill(
                        child: ListWheelScrollView(
                          itemExtent: 60,
                          clipBehavior: Clip.antiAlias,
                          onSelectedItemChanged: (index) {
                            selectedGoal = stringList[index];
                            setState(() {});
                          },
                          controller: FixedExtentScrollController(
                            initialItem: stringList.indexOf(selectedGoal),
                          ),
                          children: List.generate(stringList.length, (index) {
                            return GoalSelectionButton(
                              goal: stringList[index],
                              isSelected: stringList[index] == selectedGoal,
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
            CustomButton(
              buttonheight: Get.height * 0.07,
              backgroundColor: ColorManager.kPrimaryColor,
              buttonwidth: Get.width * 0.85,
              onPress: () {
                Get.offAll(() => const PhysicalActivityScreen());
              },
              mywidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Next",
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
    );
  }
}

class GoalSelectionButton extends StatelessWidget {
  final String goal;
  final bool isSelected;

  const GoalSelectionButton({
    super.key,
    required this.goal,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        goal,
        style: TextStyle(
          fontSize: isSelected ? 25 : 20,
          color: Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
