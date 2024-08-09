// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:longevity_hub/data/controller/profile_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/repositories/subscription_repo/subscription_repo.dart';
import 'package:longevity_hub/screens/dashboard_screens/home.dart';
import 'package:longevity_hub/screens/exercise_screens/exercise_screen.dart';
import 'package:longevity_hub/screens/gym_membership_screens/excercise_screen.dart';
import 'package:longevity_hub/screens/schedule_screens/schedule_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> with WidgetsBindingObserver {
  bool isKeyboardVisible = false;
  final List<Widget> pages = [
    // const CommunityScreen(navigateToMenuScreen: true),
    const ExerciseScreen(navigateToMenuScreen: true),
    const ScheduleScreen(navigateToMenuScreen: true),
    const HomeScreen(),
    // const NutritionScreen(navigateToMenuScreen: true),
    const ExerciseScreen(),
    const GymExerciseScreen(navigateToMenuScreen: true),
  ];

  void navigateToPage(int index, String moduleId) async {
    await SubscriptionRepo.verifyModuleForUser(moduleId, () {
      ProfileController.i.updateselectedPage(index);
    });
  }

  int tap = 0;
  Future<bool> showExitPopup() async {
    if (ZoomDrawer.of(context)!.isOpen()) {
      ZoomDrawer.of(context)!.close();
    } else if (tap == 0) {
      tap++;
      return false;
    } else if (tap == 1) {
      tap = 0;
      return true;
    }
    return false;
  }

  Future<bool> homeScreenPopup() async {
    ProfileController.i.updateselectedPage(2);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileController>(
        builder: (cont) => IndexedStack(
          index: ProfileController.i.selectedPage,
          children: pages,
        ),
      ),
      bottomNavigationBar: bottomAppbar(context),
    );
  }

  bottomAppbar(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (cont) {
      return WillPopScope(
        onWillPop: ProfileController.i.selectedPage == 2 &&
                ZoomDrawer.of(context)!.isOpen() == false
            ? showExitPopup
            : homeScreenPopup,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(int.parse('#1E1E1E'.substring(1, 7), radix: 16) +
                    0xFF000000),
                blurRadius: 6.0,
                spreadRadius: 0.4,
              )
            ],
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Get.width * 0.08),
              topRight: Radius.circular(Get.width * 0.08),
            ),
          ),
          height: Get.height * 0.11,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              buildBottomNavItem(AppImages.community2, "community".tr, 0, "5",
                  isSvg: false),
              buildBottomNavItem(AppImages.schedule, "schedule".tr, 1, null,
                  isSvg: false),
              buildBottomNavItem(AppImages.home, "home".tr, 2, null,
                  isSvg: false),
              buildBottomNavItem(AppImages.nutrition, 'nutrition'.tr, 3, "6",
                  isSvg: false),
              buildBottomNavItem(AppImages.exercise, 'exercise'.tr, 4, "2",
                  isSvg: false),
            ],
          ),
        ),
      );
    });
  }

  buildBottomNavItem(
      String imagePath, String label, int index, String? moduleId,
      {bool? isSvg = false}) {
    final isSelected = ProfileController.i.selectedPage == index;
    return GetBuilder<ProfileController>(builder: (cont) {
      return InkWell(
        onTap: () {
          if (moduleId != null) {
            navigateToPage(index, moduleId);
          } else {
            ProfileController.i.updateselectedPage(index);
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            imagePath.isEmpty
                ? const SizedBox()
                : isSvg == false
                    ? Container(
                        padding: EdgeInsets.all(Get.width * 0.022),
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: ColorManager.kGreyColor,
                                blurRadius: 1.0,
                                spreadRadius: 1,
                                blurStyle: BlurStyle.normal,
                                offset: Offset(1, 2),
                              )
                            ],
                            shape: BoxShape.circle,
                            color: isSelected == true
                                ? ColorManager.kPrimaryLightGreenColor
                                : ColorManager.kWhiteColor),
                        child: Image.asset(
                          imagePath,
                          height: Get.height * 0.03,
                          color: isSelected
                              ? ColorManager.kBottomNavImageSelected
                              : ColorManager.kblackColor,
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.all(Get.width * 0.022),
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: ColorManager.kWhiteColor,
                                blurRadius: 1.0,
                                spreadRadius: 1,
                                blurStyle: BlurStyle.normal,
                                offset: Offset(1, 3),
                              )
                            ],
                            shape: BoxShape.circle,
                            color: isSelected == true
                                ? ColorManager.kPrimaryLightGreenColor
                                : ColorManager.kWhiteColor),
                        child: SvgPicture.asset(
                          height: Get.height * 0.03,
                          imagePath,
                          color: isSelected
                              ? ColorManager.kWhiteColor
                              : ColorManager.kblackColor,
                        ),
                      ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 10, color: ColorManager.kblackColor),
            )
          ],
        ),
      );
    });
  }
}
