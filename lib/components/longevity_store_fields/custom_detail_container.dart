// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/longevity_store_screens/write_product_review_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class CustomDetailContainer extends StatefulWidget
    implements PreferredSizeWidget {
  final String orderIdText;
  final String statusText;
  final String orderDateTimeText;
  final String qtyText;
  final String centerText;
  final String centerText2;
  final String rowText;
  final String centerText3;
  final String trailingImage;

  const CustomDetailContainer({
    Key? key,
    required this.centerText,
    required this.centerText2,
    required this.statusText,
    required this.trailingImage,
    required this.centerText3,
    required this.rowText,
    required this.orderDateTimeText,
    required this.orderIdText,
    required this.qtyText,
  }) : super(key: key);

  @override
  _CustomDetailContainerState createState() => _CustomDetailContainerState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomDetailContainerState extends State<CustomDetailContainer> {
  Color getContainerColor() {
    switch (widget.statusText) {
      case "Placed":
        return const Color(0x35fdc127);
      case "Delivered":
        return const Color(0x35fd9727);
      case "Cancelled":
        return const Color(0x35fd2727);
      default:
        return const Color(0x35fdc127);
    }
  }

  Color getTextColor() {
    switch (widget.statusText) {
      case "Placed":
        return const Color(0xffFDC127);
      case "Delivered":
        return Colors.orange;
      case "Cancelled":
        return Colors.red;
      default:
        return const Color(0xffFDC127);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1.0,
            color: const Color.fromARGB(255, 247, 245, 245),
          ),
          color: ColorManager.kWhiteColor),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: Get.height * .02, left: Get.width * 0.02),
                child: Text(
                  "${"orderId".tr} ${widget.orderIdText}",
                  style: GoogleFonts.poppins(
                    color: ColorManager.kblackColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.005,
              ),
              Padding(
                padding: EdgeInsets.only(left: Get.width * 0.02),
                child: Text(
                  "${"orderDate".tr} ${widget.orderDateTimeText}",
                  style: GoogleFonts.poppins(
                    color: ColorManager.kblackColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: Get.width * 0.018, right: Get.width * 0.018),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1.0,
                      color: const Color.fromARGB(255, 247, 245, 245),
                    ),
                  ),
                  width: Get.width * 0.9,
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            widget.trailingImage,
                            scale: 6,
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.centerText,
                                    style: GoogleFonts.poppins(
                                      color: ColorManager.kblackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                widget.centerText2,
                                style: GoogleFonts.poppins(
                                  color:
                                      const Color.fromARGB(255, 195, 192, 192),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Row(
                                children: [
                                  Text(
                                    widget.centerText3,
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.35,
                                  ),
                                  Text(
                                    "${"qty".tr}${widget.qtyText}",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),

                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: <Widget>[
                                  //     InkWell(
                                  //       onTap: () {
                                  //         _decrement();
                                  //       },
                                  //       child: Image.asset(
                                  //         AppImages.decrementImage,
                                  //         scale: 4.5,
                                  //       ),
                                  //     ),
                                  //     SizedBox(
                                  //       width: Get.width * 0.03,
                                  //     ),
                                  //     Text(
                                  //       '$_counter',
                                  //       style: GoogleFonts.poppins(
                                  //           fontSize: 12,
                                  //           color: ColorManager.kblackColor,
                                  //           fontWeight: FontWeight.w500),
                                  //     ),
                                  //     SizedBox(
                                  //       width: Get.width * 0.03,
                                  //     ),
                                  //     InkWell(
                                  //       onTap: () {
                                  //         _increment();
                                  //       },
                                  //       child: Image.asset(
                                  //         AppImages.incrementImage,
                                  //         scale: 5.5,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(left: Get.width * 0.03),
                child: Image.asset(
                  AppImages.shippingRow,
                  scale: 2,
                  // width: Get.width * 0.06,
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Center(
                child: CustomButton(
                  buttonheight: Get.height * 0.05,
                  backgroundColor: const Color(0xffefefef),
                  buttonwidth: Get.width * 0.85,
                  onPress: () async {},
                  mywidget: Text(
                    "cancelOrder".tr,
                    style: GoogleFonts.poppins(
                        color: ColorManager.kblackColor, fontSize: 11),
                  ),
                  radius: 10,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * .02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      buttonheight: Get.height * 0.05,
                      backgroundColor: const Color(0xffefefef),
                      buttonwidth: Get.width * 0.42,
                      onPress: () async {},
                      mywidget: Text(
                        "return".tr,
                        style: GoogleFonts.poppins(
                            color: ColorManager.kblackColor, fontSize: 11),
                      ),
                      radius: 10,
                    ),
                    CustomButton(
                      buttonheight: Get.height * 0.05,
                      backgroundColor: const Color(0xffefefef),
                      buttonwidth: Get.width * 0.42,
                      onPress: () async {
                        Get.to(() => const WriteProductReviewsScreen());
                      },
                      mywidget: Text(
                        "WriteAReview".tr,
                        style: GoogleFonts.poppins(
                            color: ColorManager.kblackColor, fontSize: 11),
                      ),
                      radius: 10,
                    ),
                  ],
                ),
              ),
              Center(
                child: CustomButton(
                  buttonheight: Get.height * 0.05,
                  backgroundColor: ColorManager.kPrimaryColor,
                  buttonwidth: Get.width * 0.85,
                  onPress: () async {},
                  mywidget: Text(
                    "reorder".tr,
                    style: GoogleFonts.poppins(
                        color: ColorManager.kblackColor, fontSize: 11),
                  ),
                  radius: 10,
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              )
            ],
          ),
        ],
      ),
    );
  }
}
