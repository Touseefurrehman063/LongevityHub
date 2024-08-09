import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDaysConatiner extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomDaysConatiner({
    required this.text,
    required this.isSelected,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          width: 80,
          decoration: BoxDecoration(
            color: isSelected ? Colors.orange : Colors.white,
            border: Border.all(
                width: 1.0, color: const Color.fromARGB(255, 215, 215, 215)),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8),
          child: InkWell(
            onTap: onTap,
            child: Center(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
