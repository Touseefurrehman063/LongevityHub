import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';

class CustomNotesField extends StatelessWidget {
  final bool? obscureText;
  final List<TextInputFormatter>? formatters;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final String? hintText;
  final bool? readOnly;
  final int? maxLines;
  final ValueChanged<String>? onChangedwidget;
  final void Function(String)? onsubmitted;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;

  const CustomNotesField({
    super.key,
    this.hintText,
    this.onChangedwidget,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.readOnly,
    this.formatters,
    this.obscureText,
    this.onsubmitted,
    this.focusNode,
    this.keyboardType,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.85,
      child: TextFormField(
        style: const TextStyle(
          fontSize: 12,
          color: ColorManager.kblackColor,
        ),
        keyboardType: keyboardType,
        focusNode: focusNode, // Corrected property name
        onFieldSubmitted: onsubmitted,
        onChanged: onChangedwidget,
        obscureText: obscureText ?? false,
        inputFormatters: formatters,
        readOnly: readOnly ?? false,
        validator: validator,
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          errorStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: ColorManager.kRedColor, fontSize: 12),
          suffixIcon: suffixIcon,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          hintText: hintText,
          alignLabelWithHint: true,
          label: Text(hintText!),
          labelStyle:
              const TextStyle(color: ColorManager.kblackColor, fontSize: 12),
          hintStyle: GoogleFonts.poppins(
              color: ColorManager.kblackColor, fontSize: 12),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 200, 198, 198),
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: ColorManager.kRedColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: ColorManager.kGreyColor)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: ColorManager.kGreyColor),
          ),
        ),

        textAlignVertical: TextAlignVertical.top,
        // Align text to the top
      ),
    );
  }
}
