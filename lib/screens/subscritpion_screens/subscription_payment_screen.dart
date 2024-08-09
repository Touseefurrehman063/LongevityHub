import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/components/custom_planned_subscribe/custom_planned_subscribe.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/subscritpion_screens/add_card.dart';
import 'package:longevity_hub/screens/subscritpion_screens/subscription_avail_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class SubscriptionPaymentScreen extends StatefulWidget {
  const SubscriptionPaymentScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionPaymentScreen> createState() =>
      _SubscriptionPaymentScreenState();
}

class _SubscriptionPaymentScreenState extends State<SubscriptionPaymentScreen> {
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
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Payment Method",
                style: GoogleFonts.poppins(
                    color: ColorManager.kblackColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const AddCardScreen());
                },
                child: Container(
                  height: Get.height * 0.18,
                  width: Get.width * 0.19,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 47, 45, 45),
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Transform.scale(
                    scale: 0.3,
                    child: Image.asset(
                      AppImages.plus,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Text(
                "Order Details",
                style: GoogleFonts.poppins(
                    color: ColorManager.kblackColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              const Divider(
                color: ColorManager.kblackColor,
                thickness: 0.5,
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              const CustomPlannedsubContainer(
                  centerText: "Yearly Subscription Plan",
                  centerText2: "Unlock exclusive perks and premium content",
                  buttontext: "Popular"),
              SizedBox(
                height: Get.height * 0.01,
              ),
              const Divider(
                color: ColorManager.kblackColor,
                thickness: 0.5,
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Text(
                "Date",
                style: GoogleFonts.poppins(
                  color: ColorManager.kblackColor,
                  fontSize: 11,
                ),
              ),
              Text(
                "20 February 2024 - Wednesday",
                style: GoogleFonts.poppins(
                    color: ColorManager.kblackColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Text(
                "Time",
                style: GoogleFonts.poppins(
                  color: ColorManager.kblackColor,
                  fontSize: 11,
                ),
              ),
              Text(
                "09:30 AM",
                style: GoogleFonts.poppins(
                    color: ColorManager.kblackColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              const Divider(
                color: ColorManager.kblackColor,
                thickness: 0.5,
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Estimated Cost",
                    style: GoogleFonts.poppins(
                      color: ColorManager.kblackColor,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    "\$ 29.99",
                    style: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              const Divider(
                color: ColorManager.kblackColor,
                thickness: 0.5,
              ),
              SizedBox(
                height: Get.height * 0.06,
              ),
              Center(
                child: CustomButton(
                  buttonheight: Get.height * 0.07,
                  backgroundColor: ColorManager.kPrimaryColor,
                  buttonwidth: Get.width * 0.75,
                  onPress: () {
                    Get.to(() => const SubscriptionAvailScreen());
                  },
                  mywidget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Pay Now",
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
