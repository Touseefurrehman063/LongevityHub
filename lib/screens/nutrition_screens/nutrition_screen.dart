// import 'package:flutter/material.dart';

// class NutritionScreen extends StatefulWidget {
//   const NutritionScreen({super.key});

//   @override
//   State<NutritionScreen> createState() => _NutritionScreenState();
// }

// class _NutritionScreenState extends State<NutritionScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(body: Center(child: Text("Nutrition")));
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_nutrition_plan/custom_circular.dart';
import 'package:longevity_hub/components/custom_nutrition_plan/custom_nutrition_plan.dart';
import 'package:longevity_hub/components/custom_nutrition_plan/custom_nutrition_recommended.dart';
import 'package:longevity_hub/components/custom_search_textfield/custom_search_textfield.dart';
import 'package:longevity_hub/data/controller/intro_steps_controller/intro_steps_controller.dart';
import 'package:longevity_hub/data/controller/nutrition_controller/nutrition_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/dashboard_screens/menu_drawer.dart';
import 'package:longevity_hub/screens/nutrition_screens/save_recipe_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class NutritionScreen extends StatefulWidget {
  final bool navigateToMenuScreen;
  const NutritionScreen({this.navigateToMenuScreen = false, super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  @override
  void initState() {
    super.initState();

    NutritionController.i.selecetednutrition = "yourplan".tr;
    NutritionController.i.searchcont.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: widget.navigateToMenuScreen
            ? const SizedBox.shrink()
            : InkWell(
                onTap: () {
                  Get.to(() => const DrawerScreen());
                },
                child: Image.asset(
                  AppImages.backArrow,
                  scale: 10,
                  color: ColorManager.kblackColor,
                ),
              ),
        title: Text(
          "nutrition".tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              fontSize: 20,
              color: ColorManager.kblackColor,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: Get.width * 0.05),
            child: InkWell(
              onTap: () {
                Get.to(() => const SavedRecipiesScreen());
              },
              child: Row(
                children: [
                  Image.asset(
                    AppImages.nutritionicon,
                    scale: 5,
                    // color: ColorManager.kblackColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.02, horizontal: Get.width * 0.07),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: Get.height * 0.055,
                    width: Get.width * 0.7,
                    decoration: BoxDecoration(
                        color: const Color(0xffFDA11A),
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              // StepsController.i.heightMeasurements.isNotEmpty
                              //     ? StepsController.i.selectedHeight =
                              //         StepsController
                              //             .i.heightMeasurements[1].name!
                              //     : "Feet"; //feet
                              NutritionController.i.selecetednutrition =
                                  "yourplan".tr;
                              setState(() {});
                            },
                            child: Container(
                              height: Get.height * 0.04,
                              width: Get.width * 0.3,
                              decoration: BoxDecoration(
                                color:
                                    NutritionController.i.selecetednutrition ==
                                            "yourplan".tr
                                        ? Colors.white
                                        : const Color(0xffFDA11A),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  "yourplan".tr,
                                  // StepsController
                                  //         .i.heightMeasurements.isNotEmpty
                                  //     ? StepsController
                                  //         .i.heightMeasurements[1].name!
                                  //     : "Feet", //feet
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: ColorManager.kblackColor,
                                      fontWeight: NutritionController
                                                  .i.selecetednutrition ==
                                              "yourplan".tr
                                          ? FontWeight.w600
                                          : FontWeight.normal),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // StepsController.i.heightMeasurements.isNotEmpty
                              //     ? StepsController.i.selectedHeight =
                              //         StepsController
                              //             .i.heightMeasurements[0].name!
                              //     : "Centimeter"; //cm
                              NutritionController.i.selecetednutrition =
                                  "recipe".tr;

                              setState(() {});
                            },
                            child: Container(
                              height: Get.height * 0.04,
                              width: Get.width * 0.3,
                              decoration: BoxDecoration(
                                  color: NutritionController
                                              .i.selecetednutrition ==
                                          "recipe".tr
                                      ? Colors.white
                                      : const Color(0xffFDA11A),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                child: Text(
                                  "recipe".tr,
                                  // StepsController
                                  //         .i.heightMeasurements.isNotEmpty
                                  //     ? StepsController
                                  //         .i.heightMeasurements[0].name!
                                  //     : "Centimeter",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: ColorManager.kblackColor,
                                      fontWeight: NutritionController
                                                  .i.selecetednutrition ==
                                              "recipe".tr
                                          ? FontWeight.w600
                                          : FontWeight.normal),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  NutritionController.i.selecetednutrition == "yourplan".tr
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "today".tr,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      color: ColorManager.kblackColor,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.6,
                              child: ListView.builder(
                                itemCount: 6,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "breakfast".tr,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                color: ColorManager.kblackColor,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                      CustomNutritionContainer(
                                        dietText: "Ketogenic/Paleo diet.",
                                        caltext: "135 kcal",
                                        bkColor: const Color.fromARGB(
                                            255, 238, 255, 213),
                                        timetext: "30 min",
                                        image: AppImages.maskgroup,
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.02,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      : GetBuilder<NutritionController>(
                          builder: (_) => SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: Get.width * 0.7,
                                            height: Get.height * 0.045,
                                            child: SearchTextField(
                                              controller: NutritionController
                                                  .i.searchcont,
                                            )),
                                        SizedBox(
                                          width: Get.width * 0.04,
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Image.asset(
                                            AppImages.filterImage,
                                            scale: 9,
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          // horizontal: Get.width * 0.01,
                                          vertical: Get.height * 0.015),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "category".tr,
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: ColorManager.kblackColor,
                                            ),
                                          ),
                                          Text(
                                            "seeall".tr,
                                            style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              color: ColorManager.kblackColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                        height: Get.height * 0.14,
                                        child: ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                            width: Get.width * 0.03,
                                          ),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 10,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return NutritionCircularCategories(
                                                text: "breakfast".tr,
                                                image: AppImages.breakfast);
                                          },
                                        )),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          // horizontal: Get.width * 0.01,
                                          vertical: Get.height * 0.015),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "recommended".tr,
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: ColorManager.kblackColor,
                                            ),
                                          ),
                                          Text(
                                            "seeall".tr,
                                            style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              color: ColorManager.kblackColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                        height: Get.height * 0.14,
                                        child: ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                            width: Get.width * 0.025,
                                          ),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 10,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return CustomRecommendedContainer(
                                              dietText: "Ketogenic/Paleo diet.",
                                              caltext: "135 kcal",
                                              bkColor: const Color.fromARGB(
                                                  255, 238, 255, 213),
                                              timetext: "30 min",
                                              image: AppImages.meal,
                                            );
                                          },
                                        )),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "breakfast".tr,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: ColorManager.kblackColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    ListView.builder(
                                      itemCount: 2,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          children: [
                                            SizedBox(
                                              height: Get.height * 0.01,
                                            ),
                                            CustomNutritionContainer(
                                              dietText: "Ketogenic/Paleo diet.",
                                              caltext: "135 kcal",
                                              bkColor: const Color.fromARGB(
                                                  255, 238, 255, 213),
                                              timetext: "30 min",
                                              image: AppImages.maskgroup,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ))
                ],
              ),
              // Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}

class CmSelectionButton extends StatelessWidget {
  final int number;
  final bool isSelected;

  const CmSelectionButton({
    Key? key,
    required this.number,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$number',
            style: TextStyle(
              fontSize: isSelected ? 40 : 30,
              color: Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isSelected)
            Padding(
              padding: EdgeInsets.only(top: Get.height * 0.02),
              child: Text(
                StepsController.i.heightMeasurements.isNotEmpty
                    ? StepsController.i.heightMeasurements[0].prefix!
                    : "cm",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class FeetSelectionButton extends StatelessWidget {
  final double number;
  final bool isSelected;

  const FeetSelectionButton({
    Key? key,
    required this.number,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$number',
            style: TextStyle(
              fontSize: isSelected ? 40 : 30,
              color: Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isSelected)
            Padding(
              padding: EdgeInsets.only(top: Get.height * 0.02),
              child: Text(
                StepsController.i.heightMeasurements.isNotEmpty
                    ? StepsController.i.heightMeasurements[1].prefix!
                    : "ft",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
