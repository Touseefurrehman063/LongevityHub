import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/utils/AppImages.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final bool? obscureText;
  final List<TextInputFormatter>? formatters;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final String? hintText;
  final bool? readOnly;
  final ValueChanged<String>? onChangedwidget;
  void Function(String)? onsubmitted;
  FocusNode? focusenode;
  TextInputType? keyboardType;
  final int? maxLines; // New property to specify the maximum number of lines

  CustomTextField({
    Key? key, // Add key parameter
    this.hintText,
    this.onChangedwidget,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.readOnly,
    this.formatters,
    this.obscureText,
    this.onsubmitted,
    this.focusenode,
    this.keyboardType,
    this.maxLines,
  }) : super(key: key); // Initialize key parameter in super constructor

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.85,
      child: TextFormField(
        style: const TextStyle(
            fontSize: 13,
            color: ColorManager.kblackColor,
            fontWeight: FontWeight.w600),
        keyboardType: keyboardType,
        focusNode: focusenode,
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
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (suffixIcon != null) suffixIcon!,
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      AppImages.microphone,
                      scale: 6,
                      // color: ColorManager.kblackColor,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      AppImages.send,
                      scale: 6,
                      // color: ColorManager.kblackColor,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.04,
                  )
                ],
              ),
            ],
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          hintText: hintText,
          label: Text(hintText!),
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 174, 172, 172), fontSize: 12),
          hintStyle:
              GoogleFonts.poppins(color: ColorManager.kGreyColor, fontSize: 12),
          disabledBorder: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 226, 222, 222),
              )),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.kRedColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: ColorManager.kGreyColor)),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 226, 222, 222)),
          ),
        ),
      ),
    );
  }
}
