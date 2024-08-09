import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:longevity_hub/data/controller/nutrition_controller/nutrition_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController? controller;
  const SearchTextField({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        hintStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: ColorManager.kGreyColor,
        ),
        hintText: "search".tr,
        filled: true,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorManager.kLightGrey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: ColorManager.kLightGrey,
          ),
        ),
        fillColor: ColorManager.kLightGrey,
        prefixIcon: const Icon(
          Icons.search,
          color: ColorManager.kGreyColor,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.kPrimaryLightColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
        ),
      ),
      style: const TextStyle(color: ColorManager.kblackColor),
      controller: controller,
      onChanged: (val) {
        NutritionController.i.searchText = val;
      },
    );
  }
}
