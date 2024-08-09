// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class CustomMyCartContainer extends StatefulWidget
    implements PreferredSizeWidget {
  final String centerText;
  final String centerText2;
  final String rowText;
  final String centerText3;
  final String trailingImage;

  const CustomMyCartContainer({
    Key? key,
    required this.centerText,
    required this.centerText2,
    required this.trailingImage,
    required this.centerText3,
    required this.rowText,
  }) : super(key: key);

  @override
  _CustomMyCartContainerState createState() => _CustomMyCartContainerState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomMyCartContainerState extends State<CustomMyCartContainer> {
  String _selectedRadio = '';
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
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedRadio = _selectedRadio == 'item1' ? '' : 'item1';
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1.0,
            color: const Color.fromARGB(255, 247, 245, 245),
          ),
        ),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (_selectedRadio == 'item1')
                        Padding(
                          padding: EdgeInsets.only(left: Get.width * .023),
                          child: Image.asset(
                            AppImages.radioSelection,
                            scale: 10,
                          ),
                        )
                      else
                        Radio<String>(
                          value: 'item1',
                          groupValue: _selectedRadio,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedRadio = value!;
                            });
                          },
                        ),
                      _selectedRadio == 'item1'
                          ? SizedBox(
                              width: Get.width * 0.03,
                            )
                          : const SizedBox.shrink(),
                      Container(
                        decoration: BoxDecoration(
                          color: ColorManager.kgreencart,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        height: Get.height * 0.09,
                        width: Get.width * 0.25,
                        child: Image.asset(
                          widget.trailingImage,
                          scale: 6,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.centerText,
                                style: GoogleFonts.poppins(
                                  color: ColorManager.kblackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.25,
                              ),
                              Image.asset(
                                AppImages.deleteFav,
                                scale: 12,
                              ),
                            ],
                          ),
                          Text(
                            widget.centerText2,
                            style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 195, 192, 192),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Row(
                            children: [
                              Text(
                                widget.centerText3,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.11,
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
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
