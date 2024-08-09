import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/components/custom_interest_container/custom_interest_container.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/dashboard_screens/menu_drawer.dart';
import 'package:longevity_hub/screens/schedule_screens/schedule_screen.dart';
import 'package:longevity_hub/screens/schedule_screens/select_expert_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class SelectIntresetScreen extends StatefulWidget {
  const SelectIntresetScreen({super.key});

  @override
  State<SelectIntresetScreen> createState() => _SelectIntresetScreenState();
}

class _SelectIntresetScreenState extends State<SelectIntresetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Get.to(() => const ScheduleScreen());
              Get.to(() => const DrawerScreen());
            },
            child: Image.asset(
              AppImages.backArrow,
              scale: 10,
              color: ColorManager.kblackColor,
            ),
          ),
          title: Text(
            "Take Appointment",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: ColorManager.kblackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.07),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Align text to the top
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Choose activities \n     that interest.'.tr,
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.kblackColor,
                    ),
                  ),

                  SizedBox(
                    height: Get.height * 0.02,
                  ),

                  //
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    // Use CustomActivityContainer within itemBuilder
                    return Column(
                      children: [
                        CustomIntresetContiner(
                          centerText: "Stretch",
                          trailingImage: AppImages.cardio2,
                          bkColor: const Color.fromARGB(255, 238, 255, 213),
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
              CustomButton(
                buttonheight: Get.height * 0.07,
                backgroundColor: ColorManager.kPrimaryColor,
                buttonwidth: Get.width * 0.85,
                onPress: () {
                  Get.offAll(() => const SelectExpertScreen());
                },
                mywidget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Next",
                      style: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 20,
                      ),
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
        ));
  }
}
