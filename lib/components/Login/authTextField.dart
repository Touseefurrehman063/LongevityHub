// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:country_code_picker/country_code_picker.dart';

class AuthTextField extends StatelessWidget {
  final bool? obscureText;
  final List<TextInputFormatter>? formatters;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final String? hintText;
  final bool? readOnly;
  final ValueChanged<String>? onChangedwidget;
  final void Function(String)? onsubmitted;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final void Function(String)? onCountryCodeChanged;
  final bool showCountryCodePicker;
  final String? obscuringCharacter;

  const AuthTextField({
    Key? key,
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
    this.showCountryCodePicker = false,
    this.onCountryCodeChanged,
    this.obscuringCharacter,
  }) : super(key: key);

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
        focusNode: focusNode,
        onFieldSubmitted: onsubmitted,
        onChanged: onChangedwidget,
        obscureText: obscureText ?? false,
        inputFormatters: formatters,
        readOnly: readOnly ?? false,
        validator: validator,
        controller: controller,
        obscuringCharacter: obscuringCharacter ?? '*',
        decoration: InputDecoration(
          errorStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: ColorManager.kRedColor, fontSize: 10),
          prefixIcon: showCountryCodePicker
              ? CountryCodePicker(
                  onChanged: (countryCode) {
                    if (onCountryCodeChanged != null) {
                      onCountryCodeChanged!(countryCode.dialCode!);
                    }
                  },
                  initialSelection: 'AE',
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  flagWidth: 20,
                  alignLeft: false,
                  searchStyle:
                      GoogleFonts.poppins(color: ColorManager.kblackColor),
                  showFlag: true,
                  textStyle:
                      GoogleFonts.poppins(color: ColorManager.kblackColor),
                  searchDecoration: InputDecoration(
                    // isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.black,
                    ),
                  ),
                )
              : null,
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: hintText,
          label: Text(hintText!),
          labelStyle: const TextStyle(
            color: ColorManager.kPrimaryColor,
            fontSize: 12,
          ),
          hintStyle: GoogleFonts.poppins(
            color: ColorManager.kPrimaryDarkGreenColor,
            fontSize: 12,
          ),
          disabledBorder: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.kblackColor),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.kRedColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: ColorManager.kblackColor),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.kblackColor),
          ),
        ),
      ),
    );
  }
}
