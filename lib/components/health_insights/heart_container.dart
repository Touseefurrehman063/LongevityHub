import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomHeartContainer extends StatelessWidget {
  final double width;
  final double height;
  final String image;
  final String text;
  final TextStyle? style;

  const CustomHeartContainer({
    Key? key,
    required this.width,
    required this.height,
    required this.image,
    required this.text,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: Get.height * 0.015,
          ),
          Image.asset(
            image,
            scale: 2,
          ),
          Padding(
            padding: EdgeInsets.only(right: Get.width * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  text,
                  style: style,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
