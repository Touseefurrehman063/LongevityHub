import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/data/controller/intro_steps_controller/intro_steps_controller.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:longevity_hub/utils/image_container/image_container.dart';

class CustomActivityContainer extends StatelessWidget {
  final String? trailingImage;
  final String centerText;
  final Color? bkColor;
  final VoidCallback onTap;

  const CustomActivityContainer({
    Key? key,
    required this.centerText,
    this.trailingImage,
    this.bkColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isActivitySelected = StepsController.i.isActivitySelected;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: isActivitySelected ? Colors.orange : Colors.grey,
            width: 0.7,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(14.0), // Adjust padding as needed
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // First, add the image container
              if (trailingImage != null)
                ImageContainer(
                  height: Get.height * 0.09,
                  width: Get.width * 0.18,
                  pic: trailingImage!,
                  backgroundColor: bkColor,
                ),
              SizedBox(width: Get.width * 0.05),
              // Then, add the text
              Expanded(
                child: Text(
                  centerText,
                  style: GoogleFonts.poppins(
                    fontWeight: isActivitySelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
              // Add checkbox for selection indication
              if (isActivitySelected)
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Image.asset(
                    AppImages.checkbox,
                    height: Get.height * 0.032,
                  ),
                )
              else
                Radio(
                  value: true,
                  groupValue: isActivitySelected,
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.orange.withOpacity(.32);
                      }
                      return Colors.grey;
                    },
                  ),
                  overlayColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.orange.withOpacity(.32);
                      }
                      return Colors.grey;
                    },
                  ),
                  onChanged: (value) {
                    onTap();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
