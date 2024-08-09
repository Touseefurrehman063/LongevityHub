// ignore_for_file: unused_import

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/data/controller/intro_steps_controller/intro_steps_controller.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/steps_screen/select_activity_screen.dart';
import 'package:longevity_hub/screens/steps_screen/welcome_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class PhysicalActivityScreen extends StatefulWidget {
  const PhysicalActivityScreen({super.key});

  @override
  State<PhysicalActivityScreen> createState() => _PhysicalActivityScreenState();
}

class _PhysicalActivityScreenState extends State<PhysicalActivityScreen> {
  @override
  void initState() {
    func();

    super.initState();
  }

  func() async {
    await StepsController.i.getactivitiylevel();
    setState(() {});
    StepsController.i.activitylevellist;

    await StepsController.i.updateactivitylist();
    setState(() {});
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
          "step5of7".tr,
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
                    'skip'.tr,
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
                  'yourphysicalActivitylevel'.tr,
                  textAlign: TextAlign.center,
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
                  height: Get.height * 0.07,
                ),

                //

                SizedBox(
                  height: Get.height * 0.45,
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
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            StepsController.i.selectedActivity =
                                index.toString();
                            setState(() {});
                          },
                          controller: FixedExtentScrollController(
                            // initialItem: StepsController.i.stringList
                            //     .indexOf(StepsController.i.selectedActivity),
                            initialItem: 1,
                          ),
                          children: List.generate(
                              StepsController.i.stringList.length, (index) {
                            return GoalSelectionButton(
                              goal: StepsController.i.stringList[index],
                              isSelected: index.toString() ==
                                  StepsController.i.selectedActivity,
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
              onPress: () async {
                // StepsController.i.updateselectedactivity();
                await LocalDb().saveActivityLevel(StepsController
                    .i
                    .activitylevellist[
                        int.parse(StepsController.i.selectedActivity)]
                    .id!);

                Get.to(() => const SelectActivity());
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
