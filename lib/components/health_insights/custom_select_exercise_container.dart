// ignore_for_file: unused_field, library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class CustomSelectExerciseContainer extends StatefulWidget
    implements PreferredSizeWidget {
  final String centerText;
  final String centerText2;
  final String clientText;
  final String rowText;
  final String centerText3;
  final String statustext;
  final Color? bkColor;
  final String trailingImage;
  final String timingtext;
  final String amText;
  final String pmText;

  const CustomSelectExerciseContainer({
    Key? key,
    required this.centerText,
    this.bkColor,
    required this.centerText2,
    required this.trailingImage,
    required this.centerText3,
    required this.statustext,
    required this.clientText,
    required this.rowText,
    required this.amText,
    required this.timingtext,
    required this.pmText,
  }) : super(key: key);

  @override
  _CustomSelectExerciseContainerState createState() =>
      _CustomSelectExerciseContainerState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomSelectExerciseContainerState
    extends State<CustomSelectExerciseContainer> {
  final double _value = 1.5;
  final double _maxRating = 2.0;
  String _selectedRadio = '';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          if (_selectedRadio == 'item1') {
            _selectedRadio = '';
          } else {
            _selectedRadio = 'item1';
          }
        });
      },
      child: Stack(
        children: [
          Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (_selectedRadio == 'item1')
                      Padding(
                        padding: EdgeInsets.only(left: Get.width * .023),
                        child: Image.asset(
                          AppImages.checkbox,
                          scale: 6,
                        ),
                      )
                    else
                      Radio<String>(
                        value: 'item1',
                        groupValue: _selectedRadio,
                        onChanged: (String? value) {
                          setState(() {
                            if (_selectedRadio == value) {
                              _selectedRadio = '';
                            } else {
                              _selectedRadio = value!;
                            }
                          });
                        },
                      ),
                    _selectedRadio == 'item1'
                        ? SizedBox(
                            width: Get.width * 0.03,
                          )
                        : const SizedBox.shrink(),
                    Image.asset(
                      widget.trailingImage,
                      scale: 4,
                    ),
                    SizedBox(
                      width: Get.width * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: Get.height * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: Get.width * 0.4,
                            child: Text(
                              widget.centerText,
                              style: GoogleFonts.poppins(
                                  color: _selectedRadio == "item1"
                                      ? ColorManager.kGreyColor
                                      : ColorManager.kblackColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                AppImages.playIcon,
                                scale: 9,
                                color: ColorManager.kPrimaryColor,
                              ),
                              SizedBox(
                                width: Get.width * 0.014,
                              ),
                              Text(
                                widget.centerText2,
                                style: GoogleFonts.poppins(
                                    color: _selectedRadio == "item1"
                                        ? const Color.fromARGB(
                                            255, 211, 210, 210)
                                        : ColorManager.kGreyColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExtensionProgressIndicator extends StatelessWidget {
  const ExtensionProgressIndicator({
    Key? key,
    required this.value,
    required this.maxRating,
  }) : super(key: key);

  final double value;
  final double maxRating;

  @override
  Widget build(BuildContext context) {
    double progress = maxRating > 0 ? value / maxRating : 0.0;
    if (progress.isNaN || progress.isInfinite) {
      progress = 0.0;
    }

    return Row(
      children: [
        Expanded(
          flex: 15,
          child: Stack(
            children: [
              LinearProgressIndicator(
                value: progress,
                minHeight: 5,
                backgroundColor: const Color.fromARGB(255, 185, 184, 184),
                borderRadius: BorderRadius.circular(16),
                valueColor: AlwaysStoppedAnimation(
                  Color.lerp(
                    const Color(0xffececec),
                    const Color(0xffececec),
                    progress,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
