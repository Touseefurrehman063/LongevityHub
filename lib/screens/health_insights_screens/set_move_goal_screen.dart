import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/data/controller/health_insights_controller/health_insights_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/repositories/health_insights_repo/water_detail_repo/health_insights_rewards_repo.dart';
import 'package:longevity_hub/screens/exercise_screens/exercise_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class SetMoveGoalScreen extends StatefulWidget {
  const SetMoveGoalScreen({Key? key}) : super(key: key);

  @override
  State<SetMoveGoalScreen> createState() => _SetMoveGoalScreenState();
}

class _SetMoveGoalScreenState extends State<SetMoveGoalScreen> {
  bool _isLoading = false;
  void _increment() {
    setState(() {
      int currentGoal =
          int.tryParse(HealthInsightsController.i.goalController.text) ?? 0;
      HealthInsightsController.i.goalController.text =
          (currentGoal + 1).toString();
    });
  }

  void _decrement() {
    setState(() {
      int currentGoal =
          int.tryParse(HealthInsightsController.i.goalController.text) ?? 0;
      if (currentGoal > 1) {
        HealthInsightsController.i.goalController.text =
            (currentGoal - 1).toString();
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

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
            "setmovegoal".tr,
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
                    SizedBox(height: Get.height * 0.06),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "yourdailymovegoal".tr,
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: ColorManager.kblackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "setactivegoal".tr,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: ColorManager.kblackColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          Image.asset(
                            AppImages.goalIcon,
                            scale: 7,
                          ),
                          SizedBox(
                            height: Get.height * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: _decrement,
                                child: Image.asset(
                                  AppImages.deccrementIcon,
                                  scale: 10,
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.1,
                              ),
                              SizedBox(
                                width: Get.width * 0.3,
                                child: TextFormField(
                                  controller:
                                      HealthInsightsController.i.goalController,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 35,
                                    color: ColorManager.kblackColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          12), // Adjust radius as needed
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(
                                            0.3), // Light grey border
                                        width: 1, // Border width
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal:
                                            8), // Adjust padding as needed
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.1,
                              ),
                              InkWell(
                                onTap: _increment,
                                child: Image.asset(
                                  AppImages.incrementIcon,
                                  scale: 12,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Text(
                            "kilocalperday".tr,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: ColorManager.kblackColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.06,
                          ),
                          InkWell(
                            onTap: () {
                              // Get.to(() => const CommunityScreen());
                              Get.to(() => const ExerciseScreen());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 230, 230, 230),
                                    width: 0.5,
                                  )),
                              child: Image.asset(
                                AppImages.communityContIcon,
                                scale: 4,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          CustomButton(
                            buttonheight: Get.height * 0.07,
                            backgroundColor: ColorManager.kWhiteColor,
                            borderColor:
                                const Color.fromARGB(255, 249, 200, 127),
                            buttonwidth: Get.width * 0.68,
                            // onPress: () async {
                            //   HealthInsightsRewardRepo().saveFootStepActivity(
                            //       HealthInsightsController
                            //           .i.goalController.text);
                            // },
                            onPress: () async {
                              setState(() {
                                _isLoading = true;
                              });

                              await HealthInsightsRewardRepo()
                                  .saveFootStepActivity(HealthInsightsController
                                      .i.goalController.text);

                              setState(() {
                                _isLoading = false;
                              });
                            },
                            mywidget: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.orange,
                                  )
                                : Text(
                                    "setGoal".tr,
                                    style: GoogleFonts.poppins(
                                        color: const Color.fromARGB(
                                            255, 250, 205, 136),
                                        fontSize: 20),
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
      ),
    );
  }
}
