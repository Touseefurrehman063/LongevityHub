// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/longevity_store_screens/order_detail_screen.dart';
import 'package:longevity_hub/screens/longevity_store_screens/shop_online_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class SuccessPaymentScreen extends StatefulWidget {
  const SuccessPaymentScreen({super.key});

  @override
  State<SuccessPaymentScreen> createState() => _SuccessPaymentScreenState();
}

class _SuccessPaymentScreenState extends State<SuccessPaymentScreen> {
  List<Map<String, String>> addresses = [
    {
      'title': 'Home',
      'address': '57, Ward Street, 95700, Harrah, United Arab Emirates',
      'value': 'Home'
    },
    {
      'title': 'Work',
      'address': '57, Ward Street, 95700, Harrah, United Arab Emirates',
      'value': 'Work'
    },
    {
      'title': 'Other',
      'address': '57, Ward Street, 95700, Harrah, United Arab Emirates',
      'value': 'Other'
    },
  ];

  void _addNewAddress(String title, String address, String value) {
    addresses.add({
      'title': title,
      'address': address,
      'value': value,
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.newBackground),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.02,
              horizontal: Get.width * 0.05,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Get.height * 0.01),
                Center(
                  child: Text(
                    "yourpaymentdone".tr,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.kblackColor,
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    AppImages.successImage,
                    scale: 8,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text(
                  "thankyouforshopping".tr,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.kblackColor,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const OrderDetailScreen());
                  },
                  child: Text(
                    "seeorderDetails".tr,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.kPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: Get.width * 0.125,
            child: CustomButton(
              buttonheight: Get.height * 0.06,
              backgroundColor: ColorManager.kPrimaryColor,
              buttonwidth: Get.width * 0.75,
              onPress: () async {
                Get.offAll(() => const ShopOnlineScreen());
              },
              mywidget: Text(
                "continueshopping".tr,
                style: GoogleFonts.poppins(
                  color: ColorManager.kblackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              radius: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressContainer(String title, String address, String value) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromARGB(255, 228, 228, 228),
          width: 0.5,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.kblackColor,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.6,
                        child: Text(
                          address,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: ColorManager.kblackColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: Get.width * 0.16,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      AppImages.editAddress,
                      scale: 15,
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
