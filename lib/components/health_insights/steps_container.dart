// ignore_for_file: unused_import, library_private_types_in_public_api

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircularStepsContainer extends StatefulWidget {
  final int waves;
  final double waveAmplitude;

  const CircularStepsContainer({
    Key? key,
    required this.waves,
    required this.waveAmplitude,
  }) : super(key: key);

  @override
  _CircularStepsContainerState createState() => _CircularStepsContainerState();
}

class _CircularStepsContainerState extends State<CircularStepsContainer>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.15,
      width: Get.width * 0.34,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          border: Border.all(
              width: 1.0, color: const Color.fromARGB(255, 255, 243, 224))),
    );
  }
}
