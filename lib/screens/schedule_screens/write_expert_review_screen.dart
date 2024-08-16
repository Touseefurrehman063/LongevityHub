import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class WriteExpertReviewScreen extends StatefulWidget {
  const WriteExpertReviewScreen({super.key});

  @override
  State<WriteExpertReviewScreen> createState() =>
      _WriteExpertReviewScreenState();
}

class _WriteExpertReviewScreenState extends State<WriteExpertReviewScreen> {
  double _value = 0.0;
  final FocusNode _focusNode1 = FocusNode();
  TextEditingController reviewController = TextEditingController();
  @override
  @override
  void initState() {
    super.initState();
    _value = 3;
    reviewController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        // ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.1),
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    AppImages.twoFacesReview,
                    scale: 4,
                  ),
                ),
                SizedBox(height: Get.height * 0.009),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    textAlign: TextAlign.center,
                    '${"yoursessionwith".tr} Dr. Shaikh Hamid\n${"iscompleted".tr}',
                    style: GoogleFonts.inter(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: Get.height * 0.03),
                Text(
                  "Richard Will",
                  style: GoogleFonts.inter(
                    color: ColorManager.kblackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: Get.height * 0.004),
                Text(
                  "High Intensity Training • ${"onlineConsultation".tr}",
                  style: GoogleFonts.manrope(
                    color: ColorManager.kRomanSilverColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: Get.height * 0.004),
                Text(
                  "10:00 am - 11:00 am",
                  style: GoogleFonts.manrope(
                    color: ColorManager.kRomanSilverColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: Get.height * 0.004),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Get.height * 0.008,
                        horizontal: Get.height * 0.008),
                    decoration: BoxDecoration(
                      color: ColorManager.kPrimaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'cOmpleted'.tr,
                      style: GoogleFonts.manrope(
                        color: ColorManager.kPrimaryColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.024),
                Container(
                  width: Get.width * 1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.1),
                        spreadRadius: 0.4,
                        blurRadius: 0.4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.height * 0.016,
                        vertical: Get.height * 0.024),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "welovetohere".tr,
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.016),
                        RatingStars(
                          // axis: Axis.horizontal,
                          value: _value,
                          onValueChanged: (v) {
                            setState(() {
                              _value = v;
                            });
                          },
                          valueLabelVisibility: false,
                          starCount: 5,
                          starSize: Get.width * 0.08,
                          maxValue: 5,
                          starSpacing: 5,
                          maxValueVisibility: true,
                          animationDuration: const Duration(milliseconds: 1000),
                          starOffColor: const Color(0xffe7e8ea),
                          starColor: const Color(0xFFFDA11A),
                          // angle: 0,
                        ),
                        SizedBox(height: Get.height * 0.02),
                        CustomReviewField(
                          controller: reviewController,
                          hintText: "writeyourfeedback".tr,
                          labelText: 'feedback'.tr,
                          focusNode: _focusNode1,
                          maxLines: 8,
                        ),
                        SizedBox(height: Get.height * 0.02),
                        CustomButton(
                            buttonheight: Get.height * 0.06,
                            backgroundColor: ColorManager.kPrimaryColor,
                            buttonwidth: Get.width * 1,
                            onPress: () {},
                            radius: 10,
                            mywidget: Text(
                              'submit'.tr,
                              style: GoogleFonts.manrope(
                                color: ColorManager.kWhiteColor,
                                fontSize: 14,
                              ),
                            )),
                        SizedBox(height: Get.height * 0.01),
                        CustomButton(
                            buttonheight: Get.height * 0.06,
                            backgroundColor: ColorManager.kWhiteColor,
                            buttonwidth: Get.width * 1,
                            onPress: () {},
                            radius: 10,
                            mywidget: Text(
                              'skip&godashboard'.tr,
                              style: GoogleFonts.manrope(
                                color: ColorManager.kPrimaryColor,
                                fontSize: 14,
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomReviewField extends StatelessWidget {
  final bool? obscureText;
  final List<TextInputFormatter>? formatters;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final String? hintText;
  final String? labelText;
  final bool? readOnly;
  final int? maxLines;
  final ValueChanged<String>? onChangedwidget;
  final void Function(String)? onsubmitted;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;

  const CustomReviewField({
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
    this.labelText,
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
          label: Text(
            labelText!,
            style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ColorManager.kblackColor),
          ),
          hintStyle: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: ColorManager.kGreyColor),
          disabledBorder: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: ColorManager.kblackColor,
          )),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.kRedColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: ColorManager.kblackColor)),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.kblackColor),
          ),
        ),

        textAlignVertical: TextAlignVertical.top,
      ),
    );
  }
}
