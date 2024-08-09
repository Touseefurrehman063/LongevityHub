import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';

class EditPhoneCustomField extends StatelessWidget {
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final int? maxlines;
  final Widget? prefixIcon;
  final TextStyle? suffixStyle;
  final String? suffixText;
  final bool? isSizedBoxAvailable;
  final bool readonly;
  final bool? enabled;
  final Widget? suffixIcon;
  final String? hintText;
  final Function(String)? onchanged;
  final void Function(String)? onCountryCodeChanged;
  final TextInputType? keyboardTypenew;
  final int? maxLength;
  final List<TextInputFormatter>? formatters;
  final String? labelText;
  final bool showCountryCodePicker;
  final String initialCountryCode;

  const EditPhoneCustomField({
    super.key,
    this.keyboardTypenew,
    this.hintText,
    this.suffixIcon,
    this.enabled,
    this.readonly = false,
    this.isSizedBoxAvailable = true,
    this.suffixText,
    this.suffixStyle,
    this.prefixIcon,
    this.maxlines,
    this.padding,
    this.onTap,
    this.validator,
    this.inputFormatters,
    this.onchanged,
    this.controller,
    this.maxLength,
    this.formatters,
    this.labelText,
    this.onCountryCodeChanged,
    this.showCountryCodePicker = false,
    required this.initialCountryCode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: Get.height * 0.005),
          child: Text(
            labelText ?? "",
            style: const TextStyle(
                color: ColorManager.kblackColor,
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ),
        TextFormField(
          inputFormatters: formatters,
          maxLength: maxLength,
          keyboardType: keyboardTypenew,
          controller: controller,
          onChanged: onchanged,
          validator: validator,
          onTap: onTap ?? () {},
          maxLines: maxlines ?? 1,
          readOnly: readonly,
          enabled: enabled ?? true,
          decoration: InputDecoration(
            fillColor: ColorManager.kWhiteColor,
            filled: true,
            counterText: "",
            errorStyle: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.red, fontSize: 12),
            prefixIcon: showCountryCodePicker
                ? CountryCodePicker(
                    onChanged: (countryCode) {
                      if (onCountryCodeChanged != null) {
                        onCountryCodeChanged!(countryCode.dialCode!);
                      }
                    },
                    initialSelection: initialCountryCode,
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    flagWidth: 20,
                    alignLeft: false,
                    showFlag: true,
                    searchStyle:
                        GoogleFonts.poppins(color: ColorManager.kblackColor),
                    searchDecoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  )
                : prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black, fontSize: 14),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey)),
          ),
          style: const TextStyle(color: Colors.black),
        ),
        isSizedBoxAvailable == true
            ? SizedBox(
                height: Get.height * 0.02,
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
