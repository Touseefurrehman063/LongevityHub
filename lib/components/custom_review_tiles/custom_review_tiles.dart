import 'package:flutter/material.dart';

class ReviewTilePainter extends CustomPainter {
  final double rating;

  ReviewTilePainter(this.rating);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue // Set your desired line color
      ..strokeWidth = 2.0; // Set line thickness

    double lineSpacing = size.height / 5; // Assuming 5 lines for 5-star rating
    double yOffset = 0.0;

    for (int i = 0; i < rating; i++) {
      yOffset = lineSpacing * (i + 1);
      Offset point1 = Offset(0.0, yOffset);
      Offset point2 = Offset(size.width, yOffset);
      canvas.drawLine(point1, point2, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
