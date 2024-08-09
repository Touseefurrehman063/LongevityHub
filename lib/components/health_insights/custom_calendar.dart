import 'package:flutter/material.dart';

class CustomCalendar extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const CustomCalendar(
      {super.key, required this.selectedDate, required this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: CalendarDatePicker(
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        onDateChanged: onDateSelected,
      ),
    );
  }
}
