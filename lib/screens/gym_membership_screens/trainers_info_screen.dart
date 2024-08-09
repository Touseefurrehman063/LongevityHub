// ignore_for_file: deprecated_member_use, unused_element

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_booking_detail/custom_booking_detail.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/components/custom_review_card/custom_review_card.dart';
import 'package:longevity_hub/data/controller/gym_membership_controller/gym_membership_controller.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/models/gym_memberships_model/get_trainer_model.dart';
import 'package:longevity_hub/repositories/gym_membership_repo/gym_memberShip_repo.dart';
import 'package:longevity_hub/screens/gym_membership_screens/excercise_screen.dart';
import 'package:longevity_hub/screens/gym_membership_screens/trainers_review_screen.dart';
import 'package:longevity_hub/screens/gym_membership_screens/trainers_screens.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:longevity_hub/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class TrainersInfoScreen extends StatefulWidget {
  final TrainersData trainersData;
  const TrainersInfoScreen({Key? key, required this.trainersData})
      : super(key: key);

  @override
  State<TrainersInfoScreen> createState() => _TrainersInfoScreenState();
}

class _TrainersInfoScreenState extends State<TrainersInfoScreen> {
  int selectedIndex = 1;
  String? gymIds = LocalDb().getSelectedGymId().toString();
  bool isLoading = true; // Add a loading state

  @override
  void initState() {
    super.initState();
    fetchTrainerReviews();
  }

  Future<void> fetchTrainerReviews() async {
    try {
      await GymMembershipRepo().getGymTrainerReview(widget.trainersData.id!);
    } finally {
      // Ensure that the loading state is updated regardless of success or failure
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Widget imageFromPath(String path) {
    if (path.startsWith('https')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(AppImages.avatar); // Fallback image
        },
      );
    } else {
      // If the path is a local asset, use Image.asset
      return Image.asset(
        path,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          widget.trainersData.picturePath != null
              ? Image.network(
                  baseURL + widget.trainersData.picturePath,
                  fit: BoxFit.cover,
                  height: Get.height * 0.28,
                )
              : Image.asset(
                  AppImages.bookingimage,
                  fit: BoxFit.cover,
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
              physics: const NeverScrollableScrollPhysics(),
              child: GetBuilder<GymMembershipController>(builder: (cont) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: Get.height * 0.1,
                    left: Get.width * 0.05,
                    top: Get.height * 0.3,
                    right: Get.width * 0.05,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.trainersData.trainerName ?? "",
                        style: GoogleFonts.poppins(
                            color: ColorManager.kblackColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "HighIntensityTraining".tr,
                            style: GoogleFonts.poppins(
                                color: ColorManager.kPrimaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     _launchPhone(
                          //         widget.trainersData.cellNumber.toString());
                          //   },
                          //   child: Image.asset(
                          //     AppImages.callpage,
                          //     scale: 12,
                          //   ),
                          // )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      CustomBookingDetailCard(
                          exptext: widget.trainersData.experience.toString(),
                          experiancetext: "Experience".tr,
                          comtext: "0",
                          completedText: "Completed".tr,
                          activeclienttext: "ActiveClients".tr,
                          activetext: "0"),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Reviews".tr,
                            style: GoogleFonts.poppins(
                                color: ColorManager.kblackColor,
                                fontSize: 19,
                                fontWeight: FontWeight.w500),
                          ),
                          CustomButton(
                            buttonheight: Get.height * 0.025,
                            backgroundColor: ColorManager.kPrimaryColor,
                            buttonwidth: Get.width * 0.12,
                            onPress: () {
                              // Get.to(() => const SelectDisease());
                            },
                            mywidget: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  (widget.trainersData.trainerRating
                                          ?.toString() ??
                                      "0.0"),
                                  style: GoogleFonts.poppins(
                                      color: ColorManager.kblackColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            radius: 6,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Row(
                                children: List.generate(
                                  4,
                                  (index) {
                                    return ClipOval(
                                      child: (index < cont.reviewData.length)
                                          ? cont.reviewData[index]
                                                      .userPicturePath ==
                                                  null
                                              ? Image.asset(
                                                  AppImages.avatar,
                                                  height: Get.height * 0.045,
                                                  width: Get.width * 0.095,
                                                )
                                              : Image.network(
                                                  height: Get.height * 0.045,
                                                  width: Get.width * 0.095,
                                                  baseURL +
                                                      cont.reviewData[index]
                                                          .userPicturePath!,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Image.asset(
                                                      AppImages.avatar,
                                                      height:
                                                          Get.height * 0.045,
                                                      width: Get.width * 0.095,
                                                    );
                                                  },
                                                )
                                          : Image.asset(
                                              AppImages.avatar,
                                              height: Get.height * 0.045,
                                              width: Get.width * 0.095,
                                            ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.02,
                                    vertical: Get.height * 0.0125),
                                decoration: BoxDecoration(
                                  color: ColorManager.kPrimaryColor,
                                  borderRadius: BorderRadius.circular(
                                      20.0), // Rounded corners
                                ),
                                child: Text(
                                  '${GymMembershipController.i.reviewData.length - 1}+', // Replace with actual review count
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => TrainerReviewsScreen(
                                  trainerId: widget.trainersData.id.toString(),
                                  ratings: widget.trainersData.trainerRating
                                      .toString()));
                            },
                            child: Text(
                              "ReadAllReviews".tr,
                              style: GoogleFonts.poppins(
                                  color: ColorManager.kPrimaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      GetBuilder<GymMembershipController>(builder: (cont) {
                        if (cont.reviewData.isNotEmpty) {
                          final lastIndex = cont.reviewData.length - 1;
                          return CustomReviewCard(
                            centerText: cont.reviewData[lastIndex].userName ??
                                "Jason Ronald",
                            centerText2:
                                (cont.reviewData[lastIndex].reviewTime ??
                                        "Today")
                                    .toString(),
                            centerText3:
                                cont.reviewData[lastIndex].description ?? " ",
                            bkColor: const Color(0xFF2C2C2E),
                            buttontext:
                                (cont.reviewData[lastIndex].rating ?? "0.0")
                                    .toString(),
                            trailingImage: SizedBox(
                              height: Get.height * 0.04,
                              width: Get.width * 0.08,
                              child: imageFromPath(
                                cont.reviewData[lastIndex].userPicturePath ==
                                        null
                                    ? AppImages.avatar
                                    : baseURL +
                                        cont.reviewData[lastIndex]
                                            .userPicturePath!,
                              ),
                            ),
                            statustext: "Booked",
                            dateTimeText:
                                "Feb 20, 2022 | \n                  16:00",
                          );
                        } else {
                          return Center(
                            child: Text(
                              "NoReviewsAvailable".tr,
                              style: GoogleFonts.poppins(
                                  color: ColorManager.kblackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          );
                        }
                      }),
                      SizedBox(
                        height: Get.height * 0.04,
                      ),
                      Center(
                        child: CustomButton(
                          buttonheight: Get.height * 0.07,
                          backgroundColor: ColorManager.kPrimaryColor,
                          buttonwidth: Get.width * 0.75,
                          onPress: () {
                            Get.to(() => const GymExerciseScreen());
                          },
                          mywidget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "beginTraining".tr,
                                style: GoogleFonts.poppins(
                                    color: ColorManager.kblackColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          radius: 10,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.06, vertical: Get.height * 0.05),
            child: InkWell(
              onTap: () {
                Get.to(() => TrainersScreen(
                      gymId: gymIds,
                    ));
              },
              child: Image.asset(
                AppImages.backArrow,
                scale: 10,
                color: ColorManager.kWhiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchPhone(String phoneNumber) async {
    final Uri url = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
