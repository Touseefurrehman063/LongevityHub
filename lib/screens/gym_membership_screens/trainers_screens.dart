// ignore_for_file: must_be_immutable

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/gym_membership/trainers_container.dart';
import 'package:longevity_hub/data/controller/gym_membership_controller/gym_membership_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/repositories/gym_membership_repo/gym_memberShip_repo.dart';
import 'package:longevity_hub/screens/dashboard_screens/menu_drawer.dart';
import 'package:longevity_hub/screens/gym_membership_screens/excercise_screen.dart';
import 'package:longevity_hub/screens/gym_membership_screens/trainers_info_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Import for loader animation

class TrainersScreen extends StatefulWidget {
  String? gymId;

  TrainersScreen({required this.gymId, super.key});

  @override
  State<TrainersScreen> createState() => _TrainersScreenState();
}

class _TrainersScreenState extends State<TrainersScreen> {
  bool isLoading = true; // Add a loading state

  @override
  void initState() {
    super.initState();
    fetchTrainers();
  }

  Future<void> fetchTrainers() async {
    try {
      await GymMembershipRepo().getGymTrainers(widget.gymId!);
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.to(() => const DrawerScreen());
          },
          child: Image.asset(
            AppImages.backArrow,
            scale: 10,
            color: ColorManager.kblackColor,
          ),
        ),
        title: Text(
          "FitnessTrainer".tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              fontSize: 20,
              color: ColorManager.kblackColor,
              fontWeight: FontWeight.bold),
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
            )
          else
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.02, horizontal: Get.width * 0.05),
              child: GetBuilder<GymMembershipController>(builder: (cont) {
                if (cont.trrainersData.isEmpty) {
                  return Center(
                    child: Text(
                      "NoTrainersAvailableForThisGym.".tr,
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ListView.builder(
                          itemCount: cont.trrainersData.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                CustomTrainersContainer(
                                  centerText:
                                      cont.trrainersData[index].trainerName ??
                                          "",
                                  centerText2:
                                      "${cont.trrainersData[index].experience} ${"years".tr}",
                                  centerText3: (cont
                                          .trrainersData[index].trainerRating
                                          ?.toString() ??
                                      "0.0"),
                                  bkColor: const Color(0xFF2C2C2E),
                                  trailingImage: AppImages.trainerImage,
                                  statustext: "Online".tr,
                                  clientText: " 0 ${"activeClients".tr}",
                                  rowText: "have made an appointment",
                                  timingtext: "",
                                  amText: " ",
                                  pmText: " ",
                                  onTap: () {
                                    Get.to(() => TrainersInfoScreen(
                                        trainersData:
                                            cont.trrainersData[index]));
                                  },
                                  onPress: () {
                                    Get.to(() => const GymExerciseScreen());
                                  },
                                ),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  );
                }
              }),
            ),
        ],
      ),
    );
  }
}
