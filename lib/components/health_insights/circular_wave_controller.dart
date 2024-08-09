// ignore_for_file: unused_import, library_private_types_in_public_api

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Modify CircularWaveContainer to accept percentage
class CircularWaveContainer extends StatefulWidget {
  final int waves;
  final double waveAmplitude;
  final double percent; // New property to receive percentage

  const CircularWaveContainer({
    Key? key,
    required this.waves,
    required this.waveAmplitude,
    required this.percent, // Initialize with required percentage
  }) : super(key: key);

  @override
  _CircularWaveContainerState createState() => _CircularWaveContainerState();
}

class _CircularWaveContainerState extends State<CircularWaveContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.15,
      width: Get.width * 0.34,
      child: ClipOval(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: CircularWavePainter(
                waves: widget.waves,
                waveAmplitude: widget.waveAmplitude,
                position: _controller.value,
                percent: widget.percent, // Pass the percentage to the painter
              ),
            );
          },
        ),
      ),
    );
  }
}

// Modify CircularWavePainter to adjust centerY dynamically
class CircularWavePainter extends CustomPainter {
  final double position;
  final int waves;
  final double waveAmplitude;
  final double percent; // New property to receive percentage

  CircularWavePainter({
    required this.position,
    required this.waves,
    required this.waveAmplitude,
    required this.percent, // Initialize with required percentage
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xffA5E9FF)
      ..style = PaintingStyle.fill;

    Path path = Path();

    // Calculate centerY based on percent
    final double centerY =
        size.height / 10 + (size.height * 0.5 * (1 - percent));

    final double waveWidth = size.width / waves;

    void drawWave(int wave, double offsetX) {
      double startX = wave * waveWidth + offsetX;
      double controlX = startX + waveWidth / 2;
      double endX = startX + waveWidth;
      double controlY = centerY + (wave.isOdd ? waveAmplitude : -waveAmplitude);

      startX = startX.clamp(0, size.width);
      controlX = controlX.clamp(0, size.width);
      endX = endX.clamp(0, size.width);

      path.quadraticBezierTo(controlX, controlY, endX, centerY);
    }

    final double offset = position * size.width;

    path.moveTo(0, centerY);

    for (int wave = 0; wave <= waves; wave++) {
      drawWave(wave, -offset);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CircularWavePainter oldDelegate) {
    return oldDelegate.position != position || oldDelegate.percent != percent;
  }
}
