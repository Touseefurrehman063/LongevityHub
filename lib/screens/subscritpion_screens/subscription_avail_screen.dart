
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/components/custom_payment_completed_container/custom_payment_completed_container.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/subscritpion_screens/subscription_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class SubscriptionAvailScreen extends StatefulWidget {
  const SubscriptionAvailScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionAvailScreen> createState() =>
      _SubscriptionAvailScreenState();
}

class _SubscriptionAvailScreenState extends State<SubscriptionAvailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              AppImages.backArrow,
              scale: 10,
              color: ColorManager.kblackColor,
            ),
          ),
          title: Text(
            "Payment",
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
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    AppImages.tickSquare,
                    fit: BoxFit.contain,
                    height: Get.height * 0.03,
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Text(
                    "Payment Completed!",
                    style: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Text(
                "You've paid \$29.99 and have availed a popular subscription Plan.",
                style: GoogleFonts.poppins(
                    color: ColorManager.kblackColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: Get.height * 0.08,
              ),
              const CustomPaymkentCompletedContainer(
                buttontext: "Popular",
                centerText: "Until Feb 18, 2025",
                centerText2: "12 Months Subscription",
                centerText3: "20 February 2024 - Wednesday",
                centerText4: "09:30 AM",
              ),
              SizedBox(
                height: Get.height * 0.17,
              ),
              Center(
                child: CustomButton(
                  buttonheight: Get.height * 0.07,
                  backgroundColor: ColorManager.kPrimaryColor,
                  buttonwidth: Get.width * 0.75,
                  onPress: () {
                    Get.to(() => const SubscriptionScreen());
                  },
                  mywidget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Done",
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
        ));
  }
}
