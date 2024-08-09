// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/components/health_insights/custom_water_field.dart';
import 'package:longevity_hub/data/controller/health_insights_controller/health_insights_controller.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/models/heallth_insights_model/water_category_model.dart';
import 'package:longevity_hub/repositories/health_insights_repo/water_detail_repo/water_detail_repo.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class AddCategoryDialog extends StatefulWidget {
  const AddCategoryDialog({super.key});
  @override
  _AddCategoryDialogState createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedCategoryId;
  final TextEditingController quantityController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    HealthInsightsController.i.waterQuantityCont.clear();
    super.dispose();
  }

  @override
  void initState() {
    WaterRepository().getWaterActivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(
                    AppImages.cross,
                    scale: 7,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Text(
              "addcategory".tr,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            GetBuilder<HealthInsightsController>(builder: (cont) {
              return DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'selectcategory'.tr,
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintStyle: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                  errorStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: ColorManager.kRedColor, fontSize: 10),
                ),
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 12,
                ),
                items: cont.categoryData.map((CategoryData category) {
                  return DropdownMenuItem<String>(
                    value: category.id,
                    child: Text(category.name!),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedCategoryId = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'pleaseselectcategory'.tr;
                  }
                  return null;
                },
              );
            }),
            SizedBox(
              height: Get.height * 0.02,
            ),
            WaterTextField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'pleaseenterquantityofglass'.tr;
                }
                return null;
              },
              controller: HealthInsightsController.i.waterQuantityCont,
              hintText: 'quantityofGlass'.tr,
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            CustomButton(
              buttonheight: Get.height * 0.06,
              backgroundColor: ColorManager.kPrimaryColor,
              buttonwidth: Get.width * 0.85,
              onPress: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  setState(() {
                    _isLoading = true;
                  });

                  await LocalDb().saveSelectedCategoryId(selectedCategoryId);
                  await WaterRepository().saveWaterActivity();

                  setState(() {
                    _isLoading = false;
                  });

                  Get.back();
                  HealthInsightsController.i.update();
                }
              },
              mywidget: _isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      "save".tr,
                      style: GoogleFonts.poppins(
                          color: ColorManager.kblackColor, fontSize: 20),
                    ),
              radius: 10,
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
