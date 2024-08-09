import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_select_export_card/custom_select_expert_card.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/schedule_screens/book_appointment_screen.dart';
import 'package:longevity_hub/screens/schedule_screens/expert_info_screen.dart';
import 'package:longevity_hub/screens/schedule_screens/schedule_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class SelectExpertScreen extends StatefulWidget {
  const SelectExpertScreen({Key? key}) : super(key: key);

  @override
  State<SelectExpertScreen> createState() => _SelectExpertScreenState();
}

class _SelectExpertScreenState extends State<SelectExpertScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.to(() => const ScheduleScreen());
          },
          child: Image.asset(
            AppImages.backArrow,
            scale: 10,
            color: ColorManager.kblackColor,
          ),
        ),
        title: Text(
          "selectExpert".tr,
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
          // Background Image
          Positioned.fill(
            child: Image.asset(
              AppImages.background,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.025,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          CustomSelectExpertCard(
                            centerText: "Richard Will",
                            centerText2: "05 Years",
                            centerText3: "4.9+",
                            bkColor: const Color(0xFF2C2C2E),
                            trailingImage: AppImages.trainerImage,
                            statustext: "online".tr,
                            clientText: '16 Active Clients',
                            rowText: 'havemadeappointment'.tr,
                            amText: '09:00 am',
                            timingtext: 'availabletimings'.tr,
                            pmText: '05:00 pm',
                            onTap: () {
                              Get.to(() => const ExpertInfoScreen());
                            },
                            onPress: () {
                              Get.to(() => const ExpertAppointmentScreen());
                            },
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
