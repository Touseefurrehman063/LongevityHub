// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:longevity_hub/utils/image_container/image_container.dart';

class CustomIntresetContiner extends StatefulWidget
    implements PreferredSizeWidget {
  final String? trailingImage;
  final String centerText;
  final Color? bkColor;

  const CustomIntresetContiner({
    Key? key,
    required this.centerText,
    this.trailingImage,
    this.bkColor,
  }) : super(key: key);

  @override
  _CustomIntresetContinerState createState() => _CustomIntresetContinerState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomIntresetContinerState extends State<CustomIntresetContiner> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: isSelected == false
                ? Colors.grey
                : Colors.orange, // Border color
            width: 0.5, // Border width
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(12.0), // Adjust padding as needed
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // First, add the image container
              if (widget.trailingImage != null)
                ImageContainer(
                  height: Get.height * 0.085,
                  width: Get.width * 0.18,
                  pic: widget.trailingImage!,
                  // color: ColorManager.kWhiteColor,
                  backgroundColor: widget.bkColor,
                ),
              SizedBox(width: Get.width * 0.05),
              // Then, add the text
              Expanded(
                child: Text(
                  widget.centerText,
                  style: GoogleFonts.poppins(
                      fontWeight: isSelected == true
                          ? FontWeight.w600
                          : FontWeight.normal), // Adjust font style as needed
                ),
              ),
              // Add radio button for multiple selection
              isSelected == true
                  ? Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Image.asset(
                        AppImages.checkbox,
                        height: Get.height * 0.032,
                      ),
                    )
                  : Radio(
                      value: true,
                      groupValue: isSelected,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.orange.withOpacity(.32);
                        }
                        return Colors.grey;
                      }),
                      overlayColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.orange.withOpacity(.32);
                        }
                        return Colors.grey;
                      }),
                      onChanged: (value) {
                        setState(() {
                          isSelected = value!;
                        });
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
