// ignore_for_file: unused_local_variable

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/community_fields/catogary_custom_container.dart';
import 'package:longevity_hub/components/gym_membership/custom_exercise_container.dart';
import 'package:longevity_hub/data/controller/gym_membership_controller/gym_membership_controller.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/repositories/gym_membership_repo/gym_memberShip_repo.dart';
import 'package:longevity_hub/screens/gym_membership_screens/trainers_screens.dart';
import 'package:longevity_hub/screens/gym_membership_screens/workout_detail_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class GymExerciseScreen extends StatefulWidget {
  final bool navigateToMenuScreen;
  const GymExerciseScreen({Key? key, this.navigateToMenuScreen = false})
      : super(key: key);

  @override
  State<GymExerciseScreen> createState() => _GymExerciseScreenState();
}

class _GymExerciseScreenState extends State<GymExerciseScreen> {
  List<bool> isSelectedCategories = List.generate(20, (index) => index == 0);
  bool isLoading = true;

  void selectCategory(int selectedIndex) {
    setState(() {
      for (int i = 0; i < isSelectedCategories.length; i++) {
        isSelectedCategories[i] = (i == selectedIndex);
      }
    });
  }

  @override
  void initState() {
    GymMembershipController.i.videoData.clear();
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    GymMembershipController controller = Get.find<GymMembershipController>();
    try {
      // Show spinner while loading data
      setState(() {
        isLoading = true;
      });

      await GymMembershipRepo().getVideoCatogery();
      await GymMembershipRepo()
          .getGymTrainersVideos(controller.catogaryData[0].id);
      // await _generateThumbnails();
    } finally {
      // Hide spinner once data is loaded
      setState(() {
        isLoading = false;
      });
    }
  }

  // Future<void> _generateThumbnails() async {
  //   GymMembershipController controller = Get.find<GymMembershipController>();
  //   for (var video in controller.videoData) {
  //     final String? thumbnail = await VideoThumbnail.thumbnailFile(
  //       video: baseURL + video.video!,
  //       imageFormat: ImageFormat.JPEG,
  //       maxWidth: 80,
  //       quality: 25,
  //     );
  //     video.thumbnail = thumbnail;
  //   }
  //   controller.update();
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: widget.navigateToMenuScreen
              ? const SizedBox.shrink()
              : InkWell(
                  onTap: () async {
                    String? selectedGymId = await LocalDb().getSelectedGymId();
                    Get.to(() => TrainersScreen(gymId: selectedGymId));
                  },
                  child: Image.asset(
                    AppImages.backArrow,
                    scale: 10,
                    color: ColorManager.kblackColor,
                  ),
                ),
          title: Text(
            "exercise".tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: ColorManager.kblackColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            if (isLoading)
              Center(
                child: BlurryModalProgressHUD(
                  color: Colors.transparent,
                  inAsyncCall: isLoading,
                  blurEffectIntensity: 4,
                  progressIndicator: const SpinKitSpinningLines(
                    color: ColorManager.kPrimaryColor,
                    size: 60,
                  ),
                  child: Container(),
                ),
              ),
            if (!isLoading)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: Get.height * 0.01),
                  GetBuilder<GymMembershipController>(builder: (cont) {
                    return SizedBox(
                      height: Get.height * 0.08,
                      child: ListView.separated(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                        separatorBuilder: (context, index) =>
                            SizedBox(width: Get.width * 0.03),
                        scrollDirection: Axis.horizontal,
                        itemCount: cont.catogaryData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CustomCategoryContainer(
                            text: cont.catogaryData[index].name!,
                            isSelected: isSelectedCategories[index],
                            onTap: () async {
                              cont.videoData.clear();
                              cont.updateIsLoading(true);
                              LocalDb().saveSelectedGymCategoryId(
                                  cont.catogaryData[index].id!);

                              await GymMembershipRepo().getGymTrainersVideos(
                                  cont.catogaryData[index].id!);
                              // _generateThumbnails();
                              cont.updateIsLoading(false);
                              selectCategory(index);
                            },
                          );
                        },
                      ),
                    );
                  }),
                  Expanded(
                    child: GetBuilder<GymMembershipController>(builder: (cont) {
                      if (cont.isLoading) {
                        return Center(
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
                        );
                      }
                      if (cont.videoData.isEmpty) {
                        return Center(
                            child: Text("NoVideoFoundAgainstthisCategory".tr));
                      }
                      return ListView.builder(
                        itemCount: cont.videoData.length,
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                        itemBuilder: (BuildContext context, int index) {
                          Duration duration =
                              GymMembershipController.i.videoDuration;
                          String formattedDuration =
                              "${duration.inMinutes} ${"mInutes".tr}";
                          return Padding(
                            padding: EdgeInsets.only(bottom: Get.height * 0.02),
                            child: CustomExerciseContainer(
                              centerText: cont.videoData[index].description!,
                              centerText2:
                                  "${cont.videoData[index].caloriesConsumed ?? "0"} ${"Kcal"}",
                              centerText3: formattedDuration,
                              bkColor: const Color(0xFF2C2C2E),
                              trailingImage:
                                  // cont.videoData[index].thumbnail !=
                                  //         null
                                  //     ? FileImage(
                                  //         File(cont.videoData[index].thumbnail!),
                                  //         scale: 0.8)
                                  //     :
                                  AssetImage(
                                AppImages.exerciseCont,
                              ),
                              statustext:
                                  cont.videoData[index].gymUserLevelName ?? "",
                              clientText: "16 Active Clients",
                              rowText: "have made an appointment",
                              timingtext: "Available Timings",
                              amText: "09:00 am".tr,
                              pmText: "05:00 pm".tr,
                              onPress: () {
                                Get.to(() => WorkOutDetailScreen(
                                    videoData: cont.videoData[index]));
                              },
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
