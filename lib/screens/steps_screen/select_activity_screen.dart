import 'dart:developer';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/Profile/custom_popup.dart';
import 'package:longevity_hub/components/custom_activity_container/custom_activity_container.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/data/controller/intro_steps_controller/intro_steps_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/models/activity_model/activity_model.dart';
import 'package:longevity_hub/repositories/Intro_steps_repo/intro_steps_repo.dart';
import 'package:longevity_hub/screens/steps_screen/select_disease_screen.dart';
import 'package:longevity_hub/screens/steps_screen/welcome_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SelectActivity extends StatefulWidget {
  const SelectActivity({super.key});

  @override
  State<SelectActivity> createState() => _SelectActivityState();
}

class _SelectActivityState extends State<SelectActivity> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    StepsController.i.getPhysicalactivities();
    StepsController.i.isSelected = false;
    _scrollController.addListener(() {
      // var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        var isCallToFetchData = setStartToFetchNextData();
        if (isCallToFetchData == true) {
          StepsRepository().getPhhysicalActivities();
          setState(() {});
        }
      }
    });
    super.initState();
  }

  bool setStartToFetchNextData() {
    final responseData = StepsController.i.responsedata;
    if (responseData != null) {
      final totalRecords = responseData.totalRecords ?? 0;
      if ((StepsController.i.activitylist.length) < totalRecords) {
        StepsController.i.pagenumber = StepsController.i.pagenumber + 1;
        return true;
      } else {
        return false;
      }
    } else {
      // Handle null responseData
      return false;
    }
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
            "step6of7".tr,
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
            padding: EdgeInsets.symmetric(
                // vertical: Get.height * 0.00,
                horizontal: Get.width * 0.07),
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
                      'chooseactivity'.tr,
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.kblackColor,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                  ],
                ),
                Expanded(
                  child: GetBuilder<StepsController>(
                    builder: (cont) {
                      return Stack(
                        children: [
                          if (cont.isLoading)
                            Center(
                              child: BlurryModalProgressHUD(
                                color: Colors.transparent,
                                inAsyncCall: cont.isLoading,
                                blurEffectIntensity: 4,
                                progressIndicator: const SpinKitSpinningLines(
                                  color: ColorManager.kPrimaryColor,
                                  size: 60,
                                ),
                                child: Container(),
                              ),
                            ),
                          if (!cont.isLoading)
                            if (cont.activitylist.isEmpty)
                              Center(
                                child: Text(
                                  "noactivityavailable".tr,
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: ColorManager.kblackColor,
                                  ),
                                ),
                              )
                            else
                              ListView.builder(
                                controller: _scrollController,
                                itemCount: cont.activitylist.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index >= cont.activitylist.length) {
                                    log('Invalid index: $index');
                                    return Container();
                                  }

                                  PhysicalActivities activity =
                                      cont.activitylist[index];
                                  cont.isActivitySelected =
                                      cont.isSelectedActivityMap[
                                              activity.id!] ??
                                          false;
                                  return InkWell(
                                    onTap: () {
                                      StepsController.i.toggleActivitySelection(
                                          activity.id!);
                                      if (StepsController.i.selectedActivityIds
                                          .contains(activity.id.toString())) {
                                        StepsController.i.selectedActivityIds
                                            .remove(activity.id.toString());
                                      } else {
                                        StepsController.i.selectedActivityIds
                                            .add(activity.id.toString());
                                      }
                                      StepsController.i.selectedActivityIds =
                                          StepsController.i.selectedActivityIds
                                              .toSet()
                                              .toList();
                                    },
                                    child: Column(
                                      children: [
                                        CustomActivityContainer(
                                          onTap: () {
                                            StepsController.i
                                                .toggleActivitySelection(
                                                    activity.id!);
                                            if (StepsController
                                                .i.selectedActivityIds
                                                .contains(
                                                    activity.id.toString())) {
                                              StepsController
                                                  .i.selectedActivityIds
                                                  .remove(
                                                      activity.id.toString());
                                            } else {
                                              StepsController
                                                  .i.selectedActivityIds
                                                  .add(activity.id.toString());
                                            }
                                            StepsController
                                                    .i.selectedActivityIds =
                                                StepsController
                                                    .i.selectedActivityIds
                                                    .toSet()
                                                    .toList();
                                            setState(
                                                () {}); // Ensure the state is updated after selection
                                          },
                                          centerText: activity.name ?? "",
                                          trailingImage: AppImages.cardio2,
                                          bkColor: Color(int.parse(
                                              activity.backgroundImageColor!)),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                CustomButton(
                  buttonheight: Get.height * 0.07,
                  backgroundColor: ColorManager.kPrimaryColor,
                  buttonwidth: Get.width * 0.85,
                  onPress: () async {
                    if (StepsController.i.selectedActivityIds.isEmpty) {
                      CustomPopup.showError("pleaseselectoneactivity".tr);
                      return;
                    }
                    Get.to(() => const SelectDisease());
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
        ));
  }
}
