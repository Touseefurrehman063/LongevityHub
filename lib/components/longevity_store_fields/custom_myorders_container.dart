// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/longevity_store_screens/order_detail_screen.dart';

class CustomMyOrdersContainer extends StatefulWidget
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

  const CustomMyOrdersContainer({
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
  _CustomMyOrdersContainerState createState() =>
      _CustomMyOrdersContainerState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomMyOrdersContainerState extends State<CustomMyOrdersContainer> {
  Color getContainerColor() {
    const translatedStatus = "";

    if (translatedStatus == "placed".tr) {
      return const Color(0x35fdc127);
    } else if (translatedStatus == "delivered".tr) {
      return const Color(0x35fd9727);
    } else if (translatedStatus == "cancelled".tr) {
      return const Color(0x35fd2727);
    } else {
      return const Color(0x35fdc127);
    }
  }

  Color getTextColor() {
    final statusText = widget.statusText.tr;

    if (statusText == "placed".tr) {
      return const Color(0xffFDC127);
    } else if (statusText == "delivered".tr) {
      return Colors.orange;
    } else if (statusText == "cancelled".tr) {
      return Colors.red;
    } else {
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
                height: Get.height * 0.01,
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
                padding: EdgeInsets.only(left: Get.width * 0.018),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  SizedBox(
                                    width: Get.width * 0.28,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: getContainerColor(),
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                    height: Get.height * 0.03,
                                    width: Get.width * 0.18,
                                    child: Center(
                                      child: Text(
                                        widget.statusText,
                                        style: GoogleFonts.poppins(
                                          color: getTextColor(),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
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
                                    width: Get.width * 0.37,
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
                height: Get.height * 0.01,
              ),
              widget.statusText == "delivered".tr
                  ? Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * .03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                            buttonheight: Get.height * 0.05,
                            backgroundColor: const Color(0xffefefef),
                            buttonwidth: Get.width * 0.42,
                            onPress: () async {
                              Get.to(() => const OrderDetailScreen());
                            },
                            mywidget: Text(
                              "viewDetails".tr,
                              style: GoogleFonts.poppins(
                                  color: ColorManager.kblackColor,
                                  fontSize: 11),
                            ),
                            radius: 10,
                          ),
                          CustomButton(
                            buttonheight: Get.height * 0.05,
                            backgroundColor: ColorManager.kPrimaryColor,
                            buttonwidth: Get.width * 0.42,
                            onPress: () async {},
                            mywidget: Text(
                              "reorder".tr,
                              style: GoogleFonts.poppins(
                                  color: ColorManager.kWhiteColor,
                                  fontSize: 11),
                            ),
                            radius: 10,
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: CustomButton(
                        buttonheight: Get.height * 0.05,
                        backgroundColor: const Color(0xffefefef),
                        buttonwidth: Get.width * 0.85,
                        onPress: () async {
                          Get.to(() => const OrderDetailScreen());
                        },
                        mywidget: Text(
                          "viewDetails".tr,
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
