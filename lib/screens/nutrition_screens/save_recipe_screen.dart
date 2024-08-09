import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_nutrition_plan/custom_nutrition_plan.dart';
import 'package:longevity_hub/data/controller/intro_steps_controller/intro_steps_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class SavedRecipiesScreen extends StatefulWidget {
  const SavedRecipiesScreen({super.key});

  @override
  State<SavedRecipiesScreen> createState() => _SavedRecipiesScreenState();
}

class _SavedRecipiesScreenState extends State<SavedRecipiesScreen> {
  @override
  void initState() {
    super.initState();
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
          "Save Recipe",
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
                // Get.to(() => const WelcomeLongevity());
              },
              child: Row(
                children: [
                  Image.asset(
                    AppImages.filterImage,
                    scale: 12,
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
              SizedBox(
                height: Get.height,
                child: ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Breakfast",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: ColorManager.kblackColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        CustomNutritionContainer(
                          ricepeText: "BreakFast",
                          dietText: "Ketogenic/Paleo diet.",
                          caltext: "135 kcal",
                          bkColor: const Color.fromARGB(255, 238, 255, 213),
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
