import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_nutrition_plan/custom_cont.dart';
import 'package:longevity_hub/components/custom_nutrition_plan/custom_step_cont.dart';
import 'package:longevity_hub/components/custom_nutrition_plan/custom_table_text.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class FoodDetail extends StatefulWidget {
  final String? image;
  final String? text;
  const FoodDetail({Key? key, required this.image, required this.text})
      : super(key: key);

  @override
  State<FoodDetail> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(
          children: [
            Image.asset(
              AppImages.recipePic,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: Get.height * 0.00,
                left: Get.width * 0.05,
                top: Get.height * 0.3,
                right: Get.width * 0.05,
              ),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Text(
                      "Breakfast",
                      style: GoogleFonts.poppins(
                          color: ColorManager.kblackColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Ketogenic/Paleo diet.",
                      style: GoogleFonts.poppins(
                          color: ColorManager.kblackColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Get.width * 0.015,
                        ),
                        const NutritionContainer(
                          text1: "Protien",
                          text2: "13g",
                        ),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        const NutritionContainer(
                          text1: "Fat",
                          text2: "18g",
                        ),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        const NutritionContainer(
                          text1: "Carbs",
                          text2: "15g",
                        ),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Ingredients",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.kblackColor,
                          ),
                        ),
                        Text(
                          "9 items",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: ColorManager.kblackColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.005,
                    ),
                    const Divider(
                      color: ColorManager.kblackColor,
                      thickness: 1,
                    ),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 9,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: CustomText(text1: "Egg", text2: "1 Whole"),
                        );
                      },
                    ),
                    SizedBox(
                      width: Get.width * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "How to make step by step",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.kblackColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.005,
                    ),
                    const Divider(
                      color: ColorManager.kblackColor,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return const Padding(
                          padding: EdgeInsets.only(bottom: 12.0),
                          child: NutritionStepsContainer(
                            text1: "Step 1",
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.05,
              left: MediaQuery.of(context).size.width * 0.04,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: ColorManager.kWhiteColor,
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.05,
              right: MediaQuery.of(context).size.width * 0.04,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      AppImages.nutritionicon,
                      scale: 5.5,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
