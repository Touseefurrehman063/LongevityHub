// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_booking_detail/custom_booking_detail.dart';
import 'package:longevity_hub/components/custom_text_field/custom_text_field.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/dashboard_screens/menu_drawer.dart';
import 'package:longevity_hub/screens/schedule_screens/schedule_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class BookingDetailScreen extends StatefulWidget {
  const BookingDetailScreen({Key? key}) : super(key: key);

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  TextEditingController messagecont = TextEditingController();
  TextEditingController messagecontroller = TextEditingController();
  int selectedIndex = 1;
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode1 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Stack(
            children: [
              Image.asset(
                AppImages.bookingimage,
                fit: BoxFit.cover,
              ),
              Padding(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "High Intensity Training",
                          style: GoogleFonts.poppins(
                              color: ColorManager.kPrimaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        InkWell(
                          onTap: () {
                            // Get.to(() => const ExpertInfoScreen());
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                AppImages.callpage,
                                scale: 14,
                                // color: ColorManager.kblackColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    const CustomBookingDetailCard(
                        exptext: "5",
                        experiancetext: "Experience",
                        comtext: "46",
                        completedText: "Completed",
                        activeclienttext: "Active Clients",
                        activetext: "25"),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: Get.width,
                        height: Get.height * 0.35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: const Color.fromARGB(255, 189, 188, 188)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: messagecont,
                        hintText: "Write your message",
                        focusenode: _focusNode1,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.05,
                left: MediaQuery.of(context).size.width * 0.04,
                child: InkWell(
                  onTap: () {
                    Get.to(() => const ScheduleScreen());
                    Get.to(() => const DrawerScreen());
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: ColorManager.kWhiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
