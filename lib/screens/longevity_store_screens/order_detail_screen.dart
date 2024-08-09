// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/components/longevity_store_fields/custom_detail_container.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
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
          "orderdetails".tr,
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
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppImages.newBackground,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.02,
              horizontal: Get.width * 0.05,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomDetailContainer(
                    centerText: "Gloves",
                    centerText2: "Weight Lifting",
                    centerText3: "AED. 20",
                    trailingImage: AppImages.items,
                    rowText: "Add to card",
                    orderDateTimeText: 'Feb 20, 2024 | 15:00',
                    orderIdText: '00012345',
                    qtyText: '1',
                    statusText: "Delivered",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "deliveryAddress".tr,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.kblackColor,
                        ),
                      ),
                    ],
                  ),
                  _buildAddressContainer(
                    "Home",
                    "57, Ward Street,95700,Harrah,United Arab Emirates",
                    "Home",
                  ),
                  SizedBox(height: Get.height * 0.005),
                  const Divider(),
                  SizedBox(height: Get.height * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "orderSummary".tr,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.kblackColor,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "itemTotal".tr,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: ColorManager.kblackColor,
                          ),
                        ),
                        Text(
                          "AED. 50",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: ColorManager.kblackColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * 0.005),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Get.height * 0.005,
                      horizontal: Get.width * 0.01,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "discount".tr,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: ColorManager.kblackColor,
                          ),
                        ),
                        Text(
                          "AED. 30",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: ColorManager.kblackColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Get.height * 0.005,
                      horizontal: Get.width * 0.01,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "deliveryfee".tr,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: ColorManager.kPrimaryColor,
                          ),
                        ),
                        Text(
                          "AED. 02",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: ColorManager.kPrimaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Get.height * 0.005,
                      horizontal: Get.width * 0.01,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "grandtotal".tr,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.kblackColor,
                          ),
                        ),
                        Text(
                          "AED. 22",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: ColorManager.kblackColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  CustomButton(
                    buttonheight: Get.height * 0.06,
                    backgroundColor: ColorManager.kPrimaryColor,
                    buttonwidth: Get.width * 0.75,
                    onPress: () async {
                      // Get.to(() => const SuccessPaymentScreen());
                    },
                    mywidget: Text(
                      "viewInvoice".tr,
                      style: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    radius: 10,
                  ),
                ],
              ),
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
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
      // margin: const EdgeInsets.symmetric(vertical: 10),
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
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
