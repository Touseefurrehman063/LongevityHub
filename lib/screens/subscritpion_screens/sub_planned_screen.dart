import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/components/custom_plan_container/custom_plan_container.dart';
import 'package:longevity_hub/components/custom_planned_subscribe/custom_planned_subscribe.dart';
import 'package:longevity_hub/data/controller/subscription_controller/subscription_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/subscritpion_screens/subscription_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class SubscribePlannedScreen extends StatefulWidget {
  const SubscribePlannedScreen({Key? key}) : super(key: key);

  @override
  State<SubscribePlannedScreen> createState() => _SubscribePlannedScreenState();
}

class _SubscribePlannedScreenState extends State<SubscribePlannedScreen> {
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            AppImages.subscribemars,
            fit: BoxFit.cover,
            // width: MediaQuery.of(context).size.width * 0.9,
            // height: MediaQuery.of(context).size.height,
          ),

          // Arrow Button

          // Content
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: Get.height * 0.1,
                  left: Get.width * 0.04,
                  top: Get.height * 0.35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "subscriptionplan".tr,
                    style: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),
                  // SizedBox(height: Get.height * 0.01),
                  Center(
                    child: Text(
                      "unlockyourfullpotiential".tr,
                      style: GoogleFonts.poppins(
                          color: ColorManager.kblackColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  GetBuilder<SubscriptionController>(builder: (controller) {
                    if (controller.packages.isEmpty ||
                        controller.selectedIndex >=
                            controller.packages.length) {
                      return const Center(child: Text(""));
                    }

                    var selectedPackage =
                        controller.packages[controller.selectedIndex];

                    return ListView.builder(
                      itemCount: selectedPackage.features.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            CustomPlanContainer(
                              centerText: selectedPackage.features.isNotEmpty
                                  ? selectedPackage.features[index].name
                                      .toString()
                                  : "nofeaturesfound".tr,
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                          ],
                        );
                      },
                    );
                  }),

                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  GetBuilder<SubscriptionController>(builder: (cont) {
                    String formattedExpiryDate = cont.expiryDate != null
                        ? DateFormat('MMMM d, yyyy').format(cont.expiryDate!)
                        : 'validforlifetime'.tr;

                    String subscriptionDuration =
                        '${cont.remainingMonths} ${"monthsubsricption".tr}';
                    return Padding(
                      padding: EdgeInsets.only(right: Get.width * 0.05),
                      child: CustomPlannedsubContainer(
                        centerText: '${"until".tr} $formattedExpiryDate',
                        centerText2: subscriptionDuration,
                        buttontext: cont.packageName ?? "basic".tr,
                        padding: const EdgeInsets.all(14.0),
                        border: Border.all(
                          color: Colors.orange,
                          // width: 0.7,
                        ),
                      ),
                    );
                  }),

                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  CustomButton(
                    buttonheight: Get.height * 0.07,
                    backgroundColor: ColorManager.kPrimaryColor,
                    buttonwidth: Get.width * 0.75,
                    onPress: () {
                      Get.to(() => const SubscriptionScreen());
                    },
                    mywidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "unsubscribe".tr,
                          style: GoogleFonts.poppins(
                              color: ColorManager.kblackColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    radius: 10,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.05,
            left: MediaQuery.of(context).size.width * 0.04,
            child: InkWell(
              onTap: () {
                Get.back();
                log("Button Pressed!");
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: ColorManager.kblackColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
