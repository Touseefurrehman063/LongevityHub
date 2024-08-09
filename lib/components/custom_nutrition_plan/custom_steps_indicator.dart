import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';

class StepIndicator extends StatelessWidget {
  final int steps;
  final int currentStep;

  const StepIndicator({
    super.key,
    required this.steps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Container(
            height: 1.5,
            width: 110,
            color: const Color.fromARGB(255, 161, 161, 161),
          ),
        ),
        SizedBox(
          width: Get.width * 0.05,
        ),
        for (int i = 1; i <= steps; i++)
          Expanded(
            child: Column(
              children: [
                i <= currentStep
                    ? Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.grey,
                          child: Text(
                            '$i',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: ColorManager.kWhiteColor,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color.fromARGB(255, 119, 118,
                                118), // Border color when not selected
                            width: 1.5, // Border width when not selected
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.transparent,
                          child: Text(
                            '$i',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color.fromARGB(255, 79, 79, 79),
                            ),
                          ),
                        ),
                      ),
                i < currentStep
                    ? Container(
                        height: 2,
                        width: 20,
                        color: Colors.blue,
                      )
                    : Container(),
              ],
            ),
          ),
        SizedBox(
          width: Get.width * 0.05,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Container(
            height: 1.5,
            width: 110,
            color: const Color.fromARGB(255, 161, 161, 161),
          ),
        ),
      ],
    );
  }
}
