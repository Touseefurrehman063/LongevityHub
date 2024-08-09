// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';

class CustomTimeSlot extends StatefulWidget {
  final int index;
  final double buttonheight;
  final double buttonwidth;
  final Color backgroundColor;
  final Function(int) onSelect;
  final bool isSelected;
  final double radius;
  final Widget mywidget;

  const CustomTimeSlot({
    Key? key,
    required this.index,
    required this.buttonheight,
    required this.buttonwidth,
    required this.backgroundColor,
    required this.onSelect,
    required this.isSelected,
    required this.radius,
    required this.mywidget,
  }) : super(key: key);

  @override
  _CustomTimeSlotState createState() => _CustomTimeSlotState();
}

class _CustomTimeSlotState extends State<CustomTimeSlot> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelect(widget.index);
      },
      child: Container(
        height: widget.buttonheight,
        width: widget.buttonwidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius),
          color: widget.backgroundColor,
          border: Border.all(
            color: widget.isSelected ? Colors.orange : Colors.grey,
            width: 1.5,
          ),
        ),
        child: Center(child: widget.mywidget),
      ),
    );
  }
}
