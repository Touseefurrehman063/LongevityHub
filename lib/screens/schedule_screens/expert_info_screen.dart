import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_booking_detail/custom_booking_detail.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/components/custom_review_card/custom_review_card.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/schedule_screens/book_appointment_screen.dart';
import 'package:longevity_hub/screens/schedule_screens/review_screen.dart';
import 'package:longevity_hub/screens/schedule_screens/select_expert_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class ExpertInfoScreen extends StatefulWidget {
  const ExpertInfoScreen({Key? key}) : super(key: key);

  @override
  State<ExpertInfoScreen> createState() => _ExpertInfoScreenState();
}

class _ExpertInfoScreenState extends State<ExpertInfoScreen> {
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.bookingimage,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
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
                    "Richard will",
                    style: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "High Intensity Training",
                    style: GoogleFonts.poppins(
                        color: ColorManager.kPrimaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  CustomBookingDetailCard(
                      exptext: "5",
                      experiancetext: "experiance".tr,
                      comtext: "46",
                      completedText: "cOmpleted".tr,
                      activeclienttext: "activeClients".tr,
                      activetext: "25"),
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
                              "4.6",
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
                      Image.asset(
                        AppImages.reviewgroup,
                        scale: 2.5,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => const ReviewsScreen());
                        },
                        child: Text(
                          "readallReviews".tr,
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
                  CustomReviewCard(
                    centerText: "Jason Ronald",
                    centerText2: "2d ago",
                    centerText3:
                        "Had such an amazing session with Maria. She instantly picked up on the level of my fitness and adjusted the workout to suit me whilst also pushing me to my limits.",
                    bkColor: const Color(0xFF2C2C2E),
                    buttontext: "4.6",
                    trailingImage: Image.asset(
                      AppImages.avatar,
                      fit: BoxFit.cover,
                      scale: 10,
                    ),
                    statustext: "Booked",
                    dateTimeText: "Feb 20, 2022 | \n                  16:00",
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  Center(
                    child: CustomButton(
                      buttonheight: Get.height * 0.07,
                      backgroundColor: ColorManager.kPrimaryColor,
                      buttonwidth: Get.width * 0.75,
                      onPress: () {
                        Get.to(() => const ExpertAppointmentScreen());
                      },
                      mywidget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "bookanAppointment".tr,
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
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.06, vertical: Get.height * 0.05),
            child: InkWell(
              onTap: () {
                Get.offAll(() => const SelectExpertScreen());
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
}
