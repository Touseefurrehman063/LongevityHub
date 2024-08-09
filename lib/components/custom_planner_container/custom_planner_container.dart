import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/subscritpion_screens/subscription_plan_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class CustomPllaner extends StatefulWidget {
  final String customtext;
  final String customtext1;
  final String customtext2;
  final bool isSelected;
  final Function(bool isSelected) onSelect;

  const CustomPllaner({
    Key? key,
    required this.customtext,
    required this.isSelected,
    required this.onSelect,
    required this.customtext1,
    required this.customtext2,
  }) : super(key: key);

  @override
  State<CustomPllaner> createState() => _CustomPllanerState();
}

class _CustomPllanerState extends State<CustomPllaner> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onSelect(!widget.isSelected); // Toggle selection
        Get.to(() => const SubscriptionPlanScreen());
      },
      child: Container(
        height: Get.height * 0.16,
        width: Get.width * 0.28,
        decoration: BoxDecoration(
          color: widget.isSelected
              ? const Color.fromARGB(255, 244, 213, 166)
              : const Color.fromARGB(255, 242, 239, 239),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: widget.isSelected
                ? Colors.orange
                : const Color.fromARGB(255, 242, 239, 239),
            width: 0.7,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: Get.height * 0.04,
              width: Get.width * 0.28,
              decoration: BoxDecoration(
                color: widget.isSelected
                    ? ColorManager.kPrimaryColor
                    : const Color.fromARGB(255, 244, 213, 166),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  widget.customtext,
                  style: GoogleFonts.poppins(
                    color: widget.isSelected ? Colors.white : Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            widget.isSelected
                ? SizedBox(height: Get.height * 0.01)
                : SizedBox(height: Get.height * 0.015),
            Center(
              child: Text(
                widget.customtext1,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            widget.isSelected
                ? SizedBox(height: Get.height * 0.01)
                : SizedBox(height: Get.height * 0.015),
            Center(
              child: Text(
                widget.customtext2,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Center(
              child: widget.isSelected
                  ? Image.asset(
                      AppImages.subscheckbox,
                      width: Get.width * 0.04, // Adjust image size as needed
                    )
                  : const SizedBox.shrink(),
            ),
            SizedBox(width: Get.width * 0.02),
          ],
        ),
      ),
    );
  }
}
