import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/components/longevity_store_fields/custom_myCart_container.dart';
import 'package:longevity_hub/components/longevity_store_fields/custom_myorders_container.dart';
import 'package:longevity_hub/data/controller/longevity_store_controller/longevity_store_cont.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/longevity_store_screens/shipping_address_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class AddToCartScreen extends StatefulWidget {
  const AddToCartScreen({super.key});

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  @override
  void initState() {
    super.initState();
    LongevityStoreController.i.selecetednutrition = "mycart".tr;
  }

  String? selectedBadge;
  final List<String> badges = [
    "Level 1",
    "Level 2",
    "Level 3",
    "Level 4",
    "Level 5",
    "Level 6",
    "Level 7"
  ];
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
          LongevityStoreController.i.selecetednutrition == "mycart".tr
              ? "mycart".tr
              : "myOrders".tr,
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
              horizontal: Get.width * 0.03,
            ),
            child: SingleChildScrollView(
              // physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: Get.height * 0.05,
                        width: Get.width * 0.7,
                        decoration: BoxDecoration(
                          color: const Color(0xffFDA11A),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  LongevityStoreController
                                      .i.selecetednutrition = "mycart".tr;
                                  setState(() {});
                                },
                                child: Container(
                                  height: Get.height * 0.04,
                                  width: Get.width * 0.3,
                                  decoration: BoxDecoration(
                                    color: LongevityStoreController
                                                .i.selecetednutrition ==
                                            "mycart".tr
                                        ? Colors.white
                                        : const Color(0xffFDA11A),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "mycart".tr,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: ColorManager.kblackColor,
                                        fontWeight: LongevityStoreController
                                                    .i.selecetednutrition ==
                                                "mycart".tr
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  LongevityStoreController
                                      .i.selecetednutrition = "myOrders".tr;
                                  setState(() {});
                                },
                                child: Container(
                                  height: Get.height * 0.04,
                                  width: Get.width * 0.3,
                                  decoration: BoxDecoration(
                                    color: LongevityStoreController
                                                .i.selecetednutrition ==
                                            "myOrders".tr
                                        ? Colors.white
                                        : const Color(0xffFDA11A),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "myOrders".tr,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: ColorManager.kblackColor,
                                        fontWeight: LongevityStoreController
                                                    .i.selecetednutrition ==
                                                "myOrders".tr
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.015),
                      LongevityStoreController.i.selecetednutrition ==
                              "mycart".tr
                          ? SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.44,
                                    child: ListView.builder(
                                      itemCount: 3,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                CustomMyCartContainer(
                                                  centerText: "Gloves",
                                                  centerText2: "Weight Lifting",
                                                  centerText3: "AED. 20",
                                                  trailingImage:
                                                      AppImages.items,
                                                  rowText: "Add to card",
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: Get.height * 0.015),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        // horizontal: Get.width * 0.01,

                                        horizontal: Get.width * 0.01),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        border: Border.all(
                                            color: ColorManager.kPrimaryColor,
                                            width: 1.0)),
                                    height: Get.height * 0.06,
                                    width: Get.width * 0.9,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: Get.width * 0.03),
                                      child: Row(children: [
                                        Image.asset(
                                          AppImages.badgeicon,
                                          scale: 10,
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.02,
                                        ),
                                        Text(
                                          "300 Points",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: ColorManager.kblackColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.21,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: ColorManager.kPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            border: Border.all(
                                              color: Colors.transparent,
                                              // width: 1.0,
                                            ),
                                          ),
                                          height: Get.height * 0.045,
                                          width: Get.width * 0.38,
                                          child: Center(
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                value: selectedBadge,
                                                hint: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      selectedBadge ??
                                                          "selectbadge".tr,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 11,
                                                          color: ColorManager
                                                              .kblackColor,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    SizedBox(
                                                      width: Get.width * 0.06,
                                                    ),
                                                    Image.asset(
                                                      AppImages.dropDownIcon,
                                                      scale: 18,
                                                    )
                                                  ],
                                                ),
                                                icon: Container(),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    selectedBadge = newValue;
                                                  });
                                                },
                                                items: badges.map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                    (String badge) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: badge,
                                                    child: Text(
                                                      badge,
                                                      style: const TextStyle(
                                                          color: ColorManager
                                                              .kblackColor),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        // horizontal: Get.width * 0.01,
                                        vertical: Get.height * 0.005,
                                        horizontal: Get.width * 0.01),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                        // horizontal: Get.width * 0.01,
                                        vertical: Get.height * 0.005,
                                        horizontal: Get.width * 0.01),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                        // horizontal: Get.width * 0.01,
                                        vertical: Get.height * 0.005,
                                        horizontal: Get.width * 0.01),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                  SizedBox(
                                    height: Get.height * 0.02,
                                  ),
                                  CustomButton(
                                    buttonheight: Get.height * 0.07,
                                    backgroundColor: ColorManager.kPrimaryColor,
                                    buttonwidth: Get.width * 0.85,
                                    onPress: () async {
                                      Get.to(
                                          () => const ShippingAddressScreen());
                                    },
                                    mywidget: Text(
                                      "ordernow".tr,
                                      style: GoogleFonts.poppins(
                                          color: ColorManager.kblackColor,
                                          fontSize: 20),
                                    ),
                                    radius: 10,
                                  ),
                                ],
                              ),
                            )
                          : GetBuilder<LongevityStoreController>(
                              builder: (_) => SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ListView.builder(
                                      itemCount: 3,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          children: [
                                            CustomMyOrdersContainer(
                                              centerText: "Gloves",
                                              centerText2: "Weight Lifting",
                                              centerText3: "AED. 20",
                                              trailingImage: AppImages.items,
                                              rowText: "Add to card",
                                              orderDateTimeText:
                                                  'Feb 20, 2024 | 15:00',
                                              orderIdText: '00012345',
                                              qtyText: '1',
                                              statusText: "delivered".tr,
                                            ),
                                            SizedBox(height: Get.height * 0.02),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
