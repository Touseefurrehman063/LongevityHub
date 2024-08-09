import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatefulWidget {
  Color backgroundColor;
  double buttonwidth;
  double buttonheight;
  VoidCallback onPress;
  Color? borderColor;
  double? radius;
  Widget? mywidget;
  // dynamic method;

  CustomButton({
    super.key,
    required this.buttonheight,
    required this.backgroundColor,
    required this.buttonwidth,
    required this.onPress,
    this.borderColor,
    required this.radius,
    required this.mywidget,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          height: widget.buttonheight,
          width: widget.buttonwidth,
          decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(widget.radius!),
              border: Border.all(
                color: widget.borderColor ?? widget.backgroundColor,
                width: 1,
              )),
          child: Center(
            child: widget.mywidget,
          ),
        ),
      ),
    );
  }
}
