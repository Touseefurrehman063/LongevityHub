// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class WaveContainer extends StatefulWidget {
  final int waves;
  final double waveAmplitude;
  final Widget child;
  final double percent;

  const WaveContainer({
    Key? key,
    required this.waves,
    required this.waveAmplitude,
    required this.child,
    required this.percent,
  }) : super(key: key);

  @override
  _WaveContainerState createState() => _WaveContainerState();
}

class _WaveContainerState extends State<WaveContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0),
      ),
      child: Container(
        color: Colors.white,
        child: CustomPaint(
          painter: WavePainter(
            waves: widget.waves,
            waveAmplitude: widget.waveAmplitude,
            controller: _controller,
            percent: widget.percent,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  late final Animation<double> position;
  final int waves;
  final double waveAmplitude;
  final double percent;

  WavePainter({
    required AnimationController controller,
    required this.waves,
    required this.waveAmplitude,
    required this.percent,
  }) : position = Tween(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.linear))
            .animate(controller);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.lightBlue
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(0, size.height / 10 + (size.height * 0.5 * (1 - percent)));

    void drawWave(int wave, double offsetX) {
      double waveWidth = size.width / (2 * waves - 1);
      double waveMinHeight = size.height / 2;

      double x1 = wave * waveWidth + waveWidth / 2 + offsetX;
      double y1 = waveMinHeight + (wave.isOdd ? waveAmplitude : -waveAmplitude);

      x1 = x1.clamp(0, size.width);

      double x2 = x1 + waveWidth / 2;
      double y2 = waveMinHeight;

      x2 = x2.clamp(0, size.width);

      path.quadraticBezierTo(x1, y1, x2, y2);
    }

    final double offset = position.value * size.width;

    for (int wave = 0; wave < 2 * waves - 1; wave++) {
      drawWave(wave, offset);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
