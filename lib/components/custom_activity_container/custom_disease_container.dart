import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/data/controller/intro_steps_controller/intro_steps_controller.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:longevity_hub/utils/image_container/image_container.dart';

class CustomDiseaseContainer extends StatelessWidget {
  final String? trailingImage;
  final String centerText;
  final Color? bkColor;
  final VoidCallback onTap;

  const CustomDiseaseContainer({
    Key? key,
    required this.centerText,
    this.trailingImage,
    this.bkColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDiseaseSelected = StepsController.i.isDiseaseSelected;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: isDiseaseSelected ? Colors.orange : Colors.grey,
            width: 0.7,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              if (trailingImage != null)
                ImageContainer(
                  height: Get.height * 0.09,
                  width: Get.width * 0.18,
                  pic: trailingImage!,
                  backgroundColor: bkColor,
                ),
              SizedBox(width: Get.width * 0.05),
              Expanded(
                child: Text(
                  centerText,
                  style: GoogleFonts.poppins(
                    fontWeight:
                        isDiseaseSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
              if (isDiseaseSelected)
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
                  groupValue: isDiseaseSelected,
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
                  onChanged: (_) {
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
