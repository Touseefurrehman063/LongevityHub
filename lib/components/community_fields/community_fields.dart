// ignore: must_be_immutable
// ignore_for_file: must_be_immutable, duplicate_ignore, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/data/controller/auth_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';

// ignore: must_be_immutable
class CommunityCustomTextField extends StatelessWidget {
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
  final dynamic contentPadding;
  final bool? enabled;
  final Widget? suffixIcon;
  final String? hintText;
  final Function(String)? onchanged;
  TextInputType? keyboardTypenew;
  final int? maxLength;
  final List<TextInputFormatter>? formatters;
  String? labelText;
  CommunityCustomTextField({
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
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
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
              fillColor: ColorManager.kGreyColor.withOpacity(0.15),
              filled: false,
              counterText: "",
              errorStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.red, fontSize: 12),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              contentPadding: contentPadding,
              hintText: hintText,
              hintStyle: const TextStyle(
                  color: ColorManager.kblackColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black)),
              // errorBorder: OutlineInputBorder(
              //     borderRadius: BorderRadius.circular(10),
              //     borderSide: const BorderSide(color: Colors.red)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black))),
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

// ignore: must_be_immutable
class CommunityCustomTextFieldLeading extends StatelessWidget {
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
  CommunityCustomTextFieldLeading({
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
                  borderSide: const BorderSide(color: Colors.black)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.red)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black))),
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

class CommunityCustomTextFieldWeight extends StatefulWidget {
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

  CommunityCustomTextFieldWeight({
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
  _CommunityCustomTextFieldWeightState createState() =>
      _CommunityCustomTextFieldWeightState();
}

class _CommunityCustomTextFieldWeightState
    extends State<CommunityCustomTextFieldWeight> {
  late TextEditingController _controller;
  late bool _isKgSelected;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _isKgSelected = AuthController.i.user?.weightMeasurementCategoryName ==
        "Pound"; // Default selection based on user preference
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
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          onTap: widget.onTap,
          keyboardType: widget.keyboardTypenew,
          maxLength: widget.maxLength,
          maxLines: widget.maxlines ?? 1,
          readOnly: widget.readonly,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.withOpacity(0.15),
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
                    color: Colors.black.withOpacity(1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isKgSelected = true;
                          });
                        },
                        child: Container(
                          width: Get.width * 0.1,
                          height: Get.height * 0.04,
                          decoration: BoxDecoration(
                            color: _isKgSelected ? Colors.white : Colors.grey,
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
                            _isKgSelected = false;
                          });
                        },
                        child: Container(
                          width: Get.width * 0.1,
                          height: Get.height * 0.04,
                          decoration: BoxDecoration(
                            color: !_isKgSelected
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
              borderSide: const BorderSide(color: Colors.black),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black),
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
      _isKgSelected = !_isKgSelected;
    });
  }
}

class CommunityCustomTextFieldHeight extends StatefulWidget {
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

  CommunityCustomTextFieldHeight({
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
  _CommunityCustomTextFieldHeightState createState() =>
      _CommunityCustomTextFieldHeightState();
}

class _CommunityCustomTextFieldHeightState
    extends State<CommunityCustomTextFieldHeight> {
  late TextEditingController _heightcontroller;
  late bool _isfeetSelected;

  @override
  void initState() {
    super.initState();
    _heightcontroller = widget.controller ?? TextEditingController();
    _isfeetSelected =
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
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          onTap: widget.onTap,
          keyboardType: widget.keyboardTypenew,
          maxLength: widget.maxLength,
          maxLines: widget.maxlines ?? 1,
          readOnly: widget.readonly,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.withOpacity(0.15),
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
                    color: Colors.black.withOpacity(1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isfeetSelected = true;
                          });
                        },
                        child: Container(
                          width: Get.width * 0.1,
                          height: Get.height * 0.04,
                          decoration: BoxDecoration(
                            color: _isfeetSelected ? Colors.white : Colors.grey,
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
                            _isfeetSelected = false;
                          });
                        },
                        child: Container(
                          width: Get.width * 0.1,
                          height: Get.height * 0.04,
                          decoration: BoxDecoration(
                            color: !_isfeetSelected
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
              borderSide: const BorderSide(color: Colors.black),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black),
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
      _isfeetSelected = !_isfeetSelected;
    });
  }
}
