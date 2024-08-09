// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/longevity_store_screens/add_to_cart_screen.dart';
import 'package:longevity_hub/screens/longevity_store_screens/favourite_items.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class ProductDetailScreen extends StatefulWidget {
  String? imageUrl;
  final String title;
  final String discPrice;
  final String rating;
  final String subtitle;
  final String price;

  ProductDetailScreen(
      {Key? key,
      required this.imageUrl,
      required this.discPrice,
      required this.price,
      required this.rating,
      required this.subtitle,
      required this.title})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  TextEditingController searchcont = TextEditingController();
  String? selectedColor;
  final List<Map<String, dynamic>> colors = [
    {"name": "Red", "color": Colors.red},
    {"name": "Green", "color": Colors.green},
    {"name": "Blue", "color": Colors.blue},
    {"name": "Yellow", "color": Colors.yellow},
  ];
  int _counter = 1;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    if (_counter > 1) {
      setState(() {
        _counter--;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

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
        title: Image.asset(
          AppImages.dashboardlogo,
          scale: 9,
        ),
        centerTitle: false,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: Get.width * 0.06),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(const FavouriteItemsScreen());
                  },
                  child: Image.asset(
                    AppImages.favIcon,
                    scale: 18,
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.025,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const AddToCartScreen());
                  },
                  child: Image.asset(
                    AppImages.cartIcon,
                    scale: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              AppImages.newBackground,
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * .07),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: ColorManager.kblackColor,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            widget.subtitle,
                            style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: ColorManager.kGreyColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: ColorManager.kWhiteColor,
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(
                            color: const Color.fromARGB(255, 109, 109, 109),
                            width: 1.0,
                          ),
                        ),
                        height: Get.height * 0.02,
                        width: Get.width * 0.1,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 12.0,
                            ),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                            Text(
                              widget.rating,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: Get.height * 0.4,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            AppImages.backgroundcart,
                          ),
                        ),
                        Center(
                          child: Transform.rotate(
                            angle: -0.2,
                            child: Padding(
                              padding: EdgeInsets.only(left: Get.width * .08),
                              child: Image.asset(
                                widget.imageUrl ?? '',
                                scale: 1.8,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.price,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 25.0,
                                fontWeight: FontWeight.w900),
                          ),
                          const Text(
                            "20%OFF",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12.0,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: ColorManager.kWhiteColor,
                              borderRadius: BorderRadius.circular(13.0),
                              border: Border.all(
                                color: const Color.fromARGB(255, 109, 109, 109),
                                width: 1.0,
                              ),
                            ),
                            height: Get.height * 0.04,
                            width: Get.width * 0.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppImages.sleepBadge,
                                  scale: 14,
                                ),
                                SizedBox(
                                  width: Get.width * 0.005,
                                ),
                                const Text(
                                  "300 Points",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 8.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ColorManager.kWhiteColor,
                              borderRadius: BorderRadius.circular(13.0),
                              border: Border.all(
                                color: const Color.fromARGB(255, 109, 109, 109),
                                width: 1.0,
                              ),
                            ),
                            height: Get.height * 0.04,
                            width: Get.width * 0.23,
                            child: Center(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedColor,
                                  hint: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (selectedColor != null)
                                        Container(
                                          color: colors.firstWhere((color) =>
                                              color['name'] ==
                                              selectedColor)['color'],
                                        ),
                                      SizedBox(
                                        width: Get.width * 0.03,
                                      ),
                                      Text(
                                        selectedColor ?? "color".tr,
                                        style: GoogleFonts.poppins(
                                            fontSize: 8,
                                            color: ColorManager.kblackColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.03,
                                      ),
                                      const Icon(
                                        Icons.arrow_drop_down,
                                        color:
                                            Color.fromARGB(255, 213, 212, 212),
                                      ),
                                    ],
                                  ),
                                  icon: Container(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedColor = newValue;
                                    });
                                  },
                                  items: colors.map<DropdownMenuItem<String>>(
                                      (Map<String, dynamic> color) {
                                    return DropdownMenuItem<String>(
                                      value: color['name'],
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: color['color'],
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                            ),
                                            width: 15,
                                            height: 15,
                                            // color: color['color'],
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            color['name'],
                                            style: const TextStyle(
                                                color:
                                                    ColorManager.kblackColor),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  _decrement();
                                },
                                child: Image.asset(
                                  AppImages.decrementImage,
                                  scale: 4.5,
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.03,
                              ),
                              Text(
                                '$_counter',
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: ColorManager.kblackColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: Get.width * 0.03,
                              ),
                              InkWell(
                                onTap: () {
                                  _increment();
                                },
                                child: Image.asset(
                                  AppImages.incrementImage,
                                  scale: 5.5,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Text(
                    "Experience comfort and confidence with our durable weight lifting gloves, designed to protect your hands and enhance your grip during intense workouts.",
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: ColorManager.kblackColor,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: Get.height * 0.06,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        AppImages.redHeartFav,
                        scale: 6,
                      ),
                      CustomButton(
                        buttonheight: Get.height * 0.07,
                        backgroundColor: ColorManager.kPrimaryColor,
                        buttonwidth: Get.width * 0.58,
                        onPress: () async {
                          Get.to(const AddToCartScreen());
                        },
                        mywidget: Text(
                          "addtocart".tr,
                          style: GoogleFonts.poppins(
                              color: ColorManager.kblackColor, fontSize: 20),
                        ),
                        radius: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.08,
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
