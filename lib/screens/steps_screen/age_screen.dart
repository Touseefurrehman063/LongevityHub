import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/steps_screen/height_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({Key? key}) : super(key: key);

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  int selectedDay = 15;
  String selectedMonth = 'Jun';
  int selectedYear = 2000;

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
          "step2of7".tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: ColorManager.kblackColor,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: Get.width * 0.02),
            child: Row(
              children: [
                Text(
                  'skip'.tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: ColorManager.kblackColor,
                  ),
                ),
                Image.asset(
                  "assets/images/skiparrow.png",
                  scale: 10,
                  color: ColorManager.kblackColor,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
        child: Container(
          padding: EdgeInsets.symmetric(
              // vertical: Get.height * 0.00,
              horizontal: Get.width * 0.07),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.background),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'howoldareyou'.tr,
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.kblackColor,
                    ),
                  ),
                  Text(
                    'thishelpuscreateplan'.tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: ColorManager.kblackColor,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.11,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _buildDateSelector(selectedDay, (value) {
                          setState(() {
                            selectedDay = value;
                          });
                        }, 31),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildMonthSelector(selectedMonth, (value) {
                          setState(() {
                            selectedMonth =
                                value; // Update selectedMonth directly with the month name
                          });
                        }),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildYearSelector(selectedYear, (value) {
                          setState(() {
                            selectedYear = value;
                          });
                        }, 2024 - 1940 + 1),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(child: Container()),
              CustomButton(
                buttonheight: Get.height * 0.07,
                backgroundColor: ColorManager.kPrimaryColor,
                buttonwidth: Get.width * 0.85,
                onPress: () async {
                  // Do something with selected day, month, and year

                  await LocalDb().saveDateOfBirth(
                      selectedDay, selectedMonth, selectedYear);
                  log('$selectedYear-$selectedMonth-$selectedDay');
                  Get.to(() => const HeightScreen());
                },
                mywidget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "next".tr,
                      style: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    Image.asset(
                      AppImages.nextArrow,
                      scale: 8,
                    ),
                  ],
                ),
                radius: 10,
              ),
              SizedBox(height: Get.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector(
      dynamic selectedValue, Function(dynamic) onChanged, int itemCount) {
    return SizedBox(
      height: Get.height * 0.35,
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: Get.height * 0.06),
                Container(
                  height: 1,
                  width: Get.width * 0.4,
                  color: const Color(0xffFDA11A),
                ),
                SizedBox(height: Get.height * 0.06),
                Container(
                  height: 1,
                  width: Get.width * 0.4,
                  color: const Color(0xffFDA11A),
                ),
                SizedBox(height: Get.height * 0.05),
              ],
            ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTapUp: (details) {
                final RenderBox renderBox =
                    context.findRenderObject() as RenderBox;
                final tapPosition =
                    renderBox.globalToLocal(details.globalPosition).dy;
                final itemHeight = Get.height * 0.49 / itemCount;
                final selectedIndex = (tapPosition / itemHeight).floor();
                onChanged(selectedIndex + 1);
              },
              child: Container(color: Colors.transparent),
            ),
          ),
          Positioned.fill(
            child: ListWheelScrollView(
              itemExtent: 50,
              clipBehavior: Clip.antiAlias,
              onSelectedItemChanged: (index) {
                onChanged(index + 1);
              },
              controller:
                  FixedExtentScrollController(initialItem: selectedValue - 1),
              children: List.generate(itemCount, (index) {
                return NumberSelectionButton(
                  number: index + 1,
                  isSelected: index + 1 == selectedValue,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthSelector(String selectedValue, Function(String) onChanged) {
    final monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    return SizedBox(
      height: Get.height * 0.38,
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: Get.height * 0.06),
                Container(
                  height: 1,
                  width: Get.width * 0.4,
                  color: const Color(0xffFDA11A),
                ),
                SizedBox(height: Get.height * 0.06),
                Container(
                  height: 1,
                  width: Get.width * 0.4,
                  color: const Color(0xffFDA11A),
                ),
                SizedBox(height: Get.height * 0.05),
              ],
            ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTapUp: (details) {
                final RenderBox renderBox =
                    context.findRenderObject() as RenderBox;
                final tapPosition =
                    renderBox.globalToLocal(details.globalPosition).dy;
                final itemHeight = Get.height * 0.49 / monthNames.length;
                final selectedIndex = (tapPosition / itemHeight).floor();
                onChanged(monthNames[selectedIndex]);
              },
              child: Container(color: Colors.transparent),
            ),
          ),
          Positioned.fill(
            child: ListWheelScrollView(
              itemExtent: 50,
              clipBehavior: Clip.antiAlias,
              onSelectedItemChanged: (index) {
                onChanged(monthNames[index]);
              },
              controller: FixedExtentScrollController(
                  initialItem: monthNames.indexOf(selectedValue)),
              children: List.generate(monthNames.length, (index) {
                return NumberSelectionButton(
                  number: monthNames[index],
                  isSelected: monthNames[index] == selectedValue,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYearSelector(
      int selectedValue, Function(int) onChanged, int itemCount) {
    // Get the current year
    int currentYear = DateTime.now().year;
    // Set the last selectable year as 5 years ago from the current year
    int lastSelectableYear = currentYear - 5;
    // Calculate the number of years between 1940 and the last selectable year
    int yearsCount = lastSelectableYear - 1940 + 1;

    return SizedBox(
      height: Get.height * 0.38,
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: Get.height * 0.06),
                Container(
                  height: 1,
                  width: Get.width * 0.4,
                  color: const Color(0xffFDA11A),
                ),
                SizedBox(height: Get.height * 0.06),
                Container(
                  height: 1,
                  width: Get.width * 0.4,
                  color: const Color(0xffFDA11A),
                ),
                SizedBox(height: Get.height * 0.05),
              ],
            ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTapUp: (details) {
                final RenderBox renderBox =
                    context.findRenderObject() as RenderBox;
                final tapPosition =
                    renderBox.globalToLocal(details.globalPosition).dy;
                final itemHeight = Get.height * 0.49 / itemCount;
                final selectedIndex = (tapPosition / itemHeight).floor();
                onChanged(1940 + selectedIndex);
              },
              child: Container(color: Colors.transparent),
            ),
          ),
          Positioned.fill(
            child: ListWheelScrollView(
              itemExtent: 50,
              clipBehavior: Clip.antiAlias,
              onSelectedItemChanged: (index) {
                onChanged(1940 + index);
              },
              controller: FixedExtentScrollController(
                  initialItem: selectedValue - 1940),
              children: List.generate(yearsCount, (index) {
                return NumberSelectionButton(
                  number: 1940 + index,
                  isSelected: 1940 + index == selectedValue,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class NumberSelectionButton extends StatelessWidget {
  final dynamic number;
  final bool isSelected;

  const NumberSelectionButton({
    Key? key,
    required this.number,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$number',
        style: TextStyle(
          fontSize: isSelected ? 25 : 20,
          color: Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
