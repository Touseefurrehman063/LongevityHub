// ignore_for_file: unused_field, must_be_immutable

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/components/custom_review_card/custom_review_card.dart';
import 'package:longevity_hub/data/controller/gym_membership_controller/gym_membership_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/repositories/gym_membership_repo/gym_memberShip_repo.dart';
import 'package:longevity_hub/screens/gym_membership_screens/trainers_info_screen.dart';
import 'package:longevity_hub/screens/gym_membership_screens/write_review_screens.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:longevity_hub/utils/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Import for loader animation

class TrainerReviewsScreen extends StatefulWidget {
  String trainerId;
  String ratings;
  TrainerReviewsScreen(
      {Key? key, required this.trainerId, required this.ratings})
      : super(key: key);

  @override
  State<TrainerReviewsScreen> createState() => _TrainerReviewsScreenState();
}

class _TrainerReviewsScreenState extends State<TrainerReviewsScreen> {
  bool isLoading = true; // Add a loading state

  DateTime _selectedDay = DateTime.now();
  final int _selectedTimeSlotIndex = -1;

  Map<String, int> calculateRatings() {
    Map<String, int> ratingsCount = {'5': 0, '4': 0, '3': 0, '2': 0, '1': 0};
    for (var review in GymMembershipController.i.reviewData) {
      if (review.rating != null) {
        int rating = review.rating!.toInt();
        if (ratingsCount.containsKey(rating.toString())) {
          ratingsCount[rating.toString()] =
              ratingsCount[rating.toString()]! + 1;
        }
      }
    }
    return ratingsCount;
  }

  @override
  void initState() {
    super.initState();
    fetchReviews();
    _selectedDay = DateTime.now();
  }

  Future<void> fetchReviews() async {
    try {
      await GymMembershipRepo().getGymTrainerReview(widget.trainerId);
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
    Map<String, int> ratingsCount = calculateRatings();
    int totalRatings = GymMembershipController.i.reviewData.length;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.to(() => TrainersInfoScreen(
                trainersData: GymMembershipController.i.trrainersData[0]));
          },
          child: Image.asset(
            AppImages.backArrow,
            scale: 10,
            color: ColorManager.kblackColor,
          ),
        ),
        title: Text(
          "Reviews".tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: ColorManager.kblackColor,
            fontWeight: FontWeight.bold,
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
            )
          else
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          (widget.ratings).toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 48,
                            color: ColorManager.kblackColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Column(
                          children: [
                            RatingProgressIndicator(
                              text: "5",
                              value: totalRatings == 0
                                  ? 0
                                  : ratingsCount['5']! / totalRatings,
                            ),
                            RatingProgressIndicator(
                              text: "4",
                              value: totalRatings == 0
                                  ? 0
                                  : ratingsCount['4']! / totalRatings,
                            ),
                            RatingProgressIndicator(
                              text: "3",
                              value: totalRatings == 0
                                  ? 0
                                  : ratingsCount['3']! / totalRatings,
                            ),
                            RatingProgressIndicator(
                              text: "2",
                              value: totalRatings == 0
                                  ? 0
                                  : ratingsCount['2']! / totalRatings,
                            ),
                            RatingProgressIndicator(
                              text: "1",
                              value: totalRatings == 0
                                  ? 0
                                  : ratingsCount['1']! / totalRatings,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${GymMembershipController.i.reviewData.length} ${"Ratings".tr}",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: ColorManager.kblackColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.025,
                  ),
                  GetBuilder<GymMembershipController>(builder: (cont) {
                    return Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(bottom: Get.height * 0.15),
                        itemCount: cont.reviewData.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              CustomReviewCard(
                                centerText: cont.reviewData[index].userName ??
                                    "user".tr,
                                centerText2:
                                    cont.reviewData[index].reviewTime ??
                                        "1d ago",
                                centerText3:
                                    cont.reviewData[index].description ?? "",
                                bkColor: const Color(0xFF2C2C2E),
                                buttontext:
                                    (cont.reviewData[index].rating ?? "")
                                        .toString(),
                                trailingImage:
                                    cont.reviewData[index].userPicturePath ==
                                            null
                                        ? Image.asset(
                                            AppImages.avatar,
                                            height: Get.height * 0.035,
                                            width: Get.width * 0.075,
                                          )
                                        : Image.network(
                                            height: Get.height * 0.04,
                                            width: Get.width * 0.08,
                                            baseURL +
                                                cont.reviewData[index]
                                                    .userPicturePath!,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                AppImages.avatar,
                                                height: Get.height * 0.035,
                                                width: Get.width * 0.075,
                                              );
                                            },
                                          ),
                                statustext: "Booked",
                                dateTimeText:
                                    "Feb 20, 2022 | \n                  16:00",
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  }),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                ],
              ),
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: Get.height * 0.15,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: Get.height * 0.68,
            left: Get.width * 0.12,
            child: Center(
              child: CustomButton(
                buttonheight: Get.height * 0.07,
                backgroundColor: ColorManager.kPrimaryColor,
                buttonwidth: Get.width * 0.75,
                onPress: () {
                  Get.to(() =>
                      WriteTrainerReviewsScreen(trainersId: widget.trainerId));
                },
                mywidget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "WriteAReview".tr,
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
          ),
        ],
      ),
    );
  }
}

class RatingProgressIndicator extends StatelessWidget {
  const RatingProgressIndicator(
      {super.key, required this.text, required this.value});
  final String text;
  final double value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 9,
              color: ColorManager.kPrimaryColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: LinearProgressIndicator(
            value: value,
            minHeight: 5,
            backgroundColor: Colors.black,
            borderRadius: BorderRadius.circular(8),
            valueColor:
                const AlwaysStoppedAnimation(ColorManager.kPrimaryColor),
          ),
        )
      ],
    );
  }
}
