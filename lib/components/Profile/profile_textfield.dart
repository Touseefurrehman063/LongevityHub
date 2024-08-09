// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/data/controller/auth_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';

class EditProfileCustomTextField extends StatelessWidget {
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
  TextInputType? keyboardTypenew;
  final int? maxLength;
  final List<TextInputFormatter>? formatters;
  String? labelText;
  EditProfileCustomTextField({
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
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
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
                  borderSide: const BorderSide(color: Colors.grey))),
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

class EditProfileCustomTextFieldLeading extends StatelessWidget {
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
  final Widget? suffixIcon;
  final String? hintText;
  final Function(String)? onchanged;
  TextInputType? keyboardTypenew;
  final int? maxLength;
  final List<TextInputFormatter>? formatters;
  String? labelText;
  Widget? sufixWidget;
  EditProfileCustomTextFieldLeading({
    super.key,
    this.sufixWidget,
    this.keyboardTypenew,
    this.hintText,
    this.suffixIcon,
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
          decoration: InputDecoration(
              fillColor: ColorManager.kGreyColor.withOpacity(0.15),
              filled: true,
              counterText: "",
              errorStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.red, fontSize: 12),
              suffix: sufixWidget,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
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
                  borderSide: const BorderSide(color: Colors.grey))),
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

class EditProfileCustomTextFieldWeight extends StatefulWidget {
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
  final Widget? suffixIcon;
  final String? hintText;
  final Function(String)? onChanged;
  TextInputType? keyboardTypenew;
  final int? maxLength;
  final List<TextInputFormatter>? formatters;
  final String? labelText;

  EditProfileCustomTextFieldWeight({
    Key? key,
    this.controller,
    this.inputFormatters,
    this.validator,
    this.onTap,
    this.padding,
    this.maxlines,
    this.prefixIcon,
    this.suffixStyle,
    this.suffixText,
    this.isSizedBoxAvailable = true,
    this.readonly = false,
    this.suffixIcon,
    this.hintText,
    this.onChanged,
    this.keyboardTypenew,
    this.maxLength,
    this.formatters,
    this.labelText,
  }) : super(key: key);

  @override
  _EditProfileCustomTextFieldWeightState createState() =>
      _EditProfileCustomTextFieldWeightState();
}

class _EditProfileCustomTextFieldWeightState
    extends State<EditProfileCustomTextFieldWeight> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    AuthController.i.isKgSelected =
        AuthController.i.user?.weightMeasurementCategoryName == "Pound";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            widget.labelText ?? "",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextFormField(
          controller: _controller,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
            CustomValueFormatter(),
            ...?widget.inputFormatters,
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter weight'.tr;
            }
            final double? weight = double.tryParse(value);
            if (weight == null || weight > 401) {
              return 'Weight must be less than 400.0'.tr;
            }
            if (RegExp(r'^\d+\.?\d{0,2}$').hasMatch(value) == false) {
              return 'Please enter a valid weight with up to 2 decimal places'
                  .tr;
            }
            return null;
          },
          onTap: widget.onTap,
          keyboardType: widget.keyboardTypenew,
          maxLength: widget.maxLength,
          maxLines: widget.maxlines ?? 1,
          readOnly: widget.readonly,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.15),
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.005, horizontal: Get.height * 0.005),
              child: GestureDetector(
                onTap: _toggleUnit,
                child: Container(
                  width: Get.width * 0.25,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            AuthController.i.isKgSelected = true;
                            AuthController.i.toggleWeightUnit();
                          });
                        },
                        child: Container(
                          width: Get.width * 0.1,
                          height: Get.height * 0.04,
                          decoration: BoxDecoration(
                            color: AuthController.i.isKgSelected
                                ? Colors.white
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              'LBS',
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            AuthController.i.isKgSelected = false;
                            AuthController.i.toggleWeightUnit();
                          });
                        },
                        child: Container(
                          width: Get.width * 0.1,
                          height: Get.height * 0.04,
                          decoration: BoxDecoration(
                            color: !AuthController.i.isKgSelected
                                ? Colors.white
                                : Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              'KG',
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
          style: const TextStyle(color: Colors.black),
        ),
        widget.isSizedBoxAvailable == true
            ? const SizedBox(height: 10)
            : const SizedBox.shrink(),
      ],
    );
  }

  void _toggleUnit() {
    setState(() {
      AuthController.i.isKgSelected = !AuthController.i.isKgSelected;
      AuthController.i.toggleWeightUnit();
    });
  }
}

class CustomValueFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final double? value = double.tryParse(newValue.text);
    if (value == null || value > 401) {
      return oldValue;
    }

    final RegExp regExp = RegExp(r'^\d+\.?\d{0,2}');
    final String newText = regExp.stringMatch(newValue.text) ?? '';
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class EditProfileCustomTextFieldHeight extends StatefulWidget {
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
  final Widget? suffixIcon;
  final String? hintText;
  final Function(String)? onChanged;
  TextInputType? keyboardTypenew;
  final int? maxLength;
  final List<TextInputFormatter>? formatters;
  final String? labelText;

  EditProfileCustomTextFieldHeight({
    Key? key,
    this.controller,
    this.inputFormatters,
    this.validator,
    this.onTap,
    this.padding,
    this.maxlines,
    this.prefixIcon,
    this.suffixStyle,
    this.suffixText,
    this.isSizedBoxAvailable = true,
    this.readonly = false,
    this.suffixIcon,
    this.hintText,
    this.onChanged,
    this.keyboardTypenew,
    this.maxLength,
    this.formatters,
    this.labelText,
  }) : super(key: key);

  @override
  _EditProfileCustomTextFieldHeightState createState() =>
      _EditProfileCustomTextFieldHeightState();
}

class _EditProfileCustomTextFieldHeightState
    extends State<EditProfileCustomTextFieldHeight> {
  late TextEditingController _heightcontroller;

  @override
  void initState() {
    super.initState();
    _heightcontroller = widget.controller ?? TextEditingController();
    AuthController.i.isfeetSelected =
        AuthController.i.user?.heightMeasurementCategoryName == "Feet";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            widget.labelText ?? "",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextFormField(
          controller: _heightcontroller,
          inputFormatters: [
            CustomHeightFormatter(),
            ...?widget.inputFormatters,
          ],
          validator: widget.validator,
          onTap: widget.onTap,
          keyboardType: widget.keyboardTypenew,
          maxLength: widget.maxLength,
          maxLines: widget.maxlines ?? 1,
          readOnly: widget.readonly,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.15),
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.005, horizontal: Get.height * 0.005),
              child: GestureDetector(
                onTap: _toggleUnit,
                child: Container(
                  width: Get.width * 0.25,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            AuthController.i.isfeetSelected = true;
                            AuthController.i.toggleHeightUnit();
                          });
                        },
                        child: Container(
                          width: Get.width * 0.1,
                          height: Get.height * 0.04,
                          decoration: BoxDecoration(
                            color: AuthController.i.isfeetSelected
                                ? Colors.white
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              'FEET',
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            AuthController.i.isfeetSelected = false;
                            AuthController.i.toggleHeightUnit();
                          });
                        },
                        child: Container(
                          width: Get.width * 0.1,
                          height: Get.height * 0.04,
                          decoration: BoxDecoration(
                            color: !AuthController.i.isfeetSelected
                                ? Colors.white
                                : Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              'CM',
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
          style: const TextStyle(color: Colors.black),
        ),
        widget.isSizedBoxAvailable == true
            ? const SizedBox(height: 10)
            : const SizedBox.shrink(),
      ],
    );
  }

  void _toggleUnit() {
    setState(() {
      AuthController.i.isfeetSelected = !AuthController.i.isfeetSelected;
      AuthController.i.toggleHeightUnit();
    });
  }
}

class CustomHeightFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final double? value = double.tryParse(newValue.text);
    if (value == null || value > 301) {
      return oldValue;
    }

    final RegExp regExp = RegExp(r'^\d+\.?\d{0,2}');
    final String newText = regExp.stringMatch(newValue.text) ?? '';
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
