import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/gym_membership/gym_container.dart';
import 'package:longevity_hub/data/controller/gym_membership_controller/gym_membership_controller.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/repositories/gym_membership_repo/gym_memberShip_repo.dart';
import 'package:longevity_hub/screens/dashboard_screens/menu_drawer.dart';
import 'package:longevity_hub/screens/gym_membership_screens/trainers_screens.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class SelectGymScreen extends StatefulWidget {
  const SelectGymScreen({Key? key}) : super(key: key);

  @override
  State<SelectGymScreen> createState() => _SelectGymScreenState();
}

class _SelectGymScreenState extends State<SelectGymScreen> {
  final GymMembershipController gymController =
      Get.find<GymMembershipController>();
  bool isLoading = true; // Add a loading state

  @override
  void initState() {
    super.initState();
    fetchGyms();
  }

  Future<void> fetchGyms() async {
    try {
      await GymMembershipRepo().getGyms(); // Fetch gyms data
    } finally {
      // Ensure that the loading state is updated regardless of success or failure
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
        backgroundColor: Colors.orange[700],
        leading: InkWell(
          onTap: () {
            Get.to(() => const DrawerScreen());
          },
          child: Image.asset(
            AppImages.backArrow,
            scale: 10,
            color: ColorManager.kWhiteColor,
          ),
        ),
        title: Text(
          "SelectGym".tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              fontSize: 20,
              color: ColorManager.kWhiteColor,
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: Get.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.gradientBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.background),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
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
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "SelectGymScreenText".tr,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: ColorManager.kWhiteColor,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.1),
                      child: SizedBox(
                        height: Get.height * 0.6,
                        child: GetBuilder<GymMembershipController>(
                          builder: (controller) {
                            if (controller.gymData.isEmpty) {
                              return Center(
                                child: Text(
                                  "NoGymAvailable".tr,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: ColorManager.kWhiteColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            } else {
                              return ListView.separated(
                                separatorBuilder: (context, index) => SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.gymData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final gym = controller.gymData[index];
                                  return InkWell(
                                    onTap: () async {
                                      await LocalDb()
                                          .saveSelectedGymId(gym.id!);
                                      Get.to(
                                          () => TrainersScreen(gymId: gym.id));
                                    },
                                    child: SelectGymContainer(
                                      headingText: gym.name!,
                                      logoImage: AppImages.gymlogoicon,
                                      descriptionText: gym.description!,
                                      gymImage: AppImages.gymImage,
                                      subscriptionText: "SubscribeToPremium".tr,
                                      detailText: "SelectGymScreenText2".tr,
                                      gymId: gym.id,
                                      onPress: () async {
                                        await LocalDb()
                                            .saveSelectedGymId(gym.id!);
                                        Get.to(() =>
                                            TrainersScreen(gymId: gym.id));
                                      },
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
