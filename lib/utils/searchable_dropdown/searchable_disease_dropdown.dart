import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:longevity_hub/data/controller/auth_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/models/diseases_model/disease_model.dart';

searchabledropdowndisease(
  BuildContext context,
  List<Diseases> list,
) async {
  AuthController.i.selectedDiseaseIds =
      AuthController.i.preselectedIds.map((id) => id.toLowerCase()).toSet();
  TextEditingController search = TextEditingController();
  String searchText = "";
  AuthController.i.selectedDiseases.addAll(list.where((disease) =>
      AuthController.i.selectedDiseaseIds.contains(disease.id!.toLowerCase())));
  AuthController.i.selectedDisease.addAll(AuthController.i.selectedDiseases);
  await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w900,
                        color: ColorManager.kPrimaryLightColor,
                      ),
                      hintText: 'search'.tr,
                      filled: true,
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: ColorManager.kPrimaryLightColor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: ColorManager.kPrimaryLightColor,
                        ),
                      ),
                      fillColor: ColorManager.kPrimaryLightColor,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: ColorManager.kPrimaryColor,
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorManager.kPrimaryLightColor,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                      ),
                    ),
                    controller: search,
                    onChanged: (val) {
                      setState(() {
                        searchText = val;
                      });
                    },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final disease = list[index];
                        final bool isSelected = AuthController.i.selectedDisease
                            .any((d) => d.id == disease.id);
                        final bool isMatched = searchText.isEmpty ||
                            disease.name!
                                .toLowerCase()
                                .contains(searchText.toLowerCase());
                        if (isMatched) {
                          return CheckboxListTile(
                            checkColor: ColorManager.kWhiteColor,
                            activeColor: ColorManager.kPrimaryColor,
                            title: Text(
                              disease.name ?? "",
                              style: const TextStyle(
                                  color: ColorManager.kblackColor),
                            ),
                            value: isSelected,
                            onChanged: (value) {
                              setState(() {
                                if (value ?? false) {
                                  AuthController.i.selectedDiseaseIds
                                      .add(disease.id!.toLowerCase());
                                  AuthController.i.selectedDisease.add(disease);
                                  AuthController.i.preselectedIds
                                      .add(disease.id!);
                                } else {
                                  AuthController.i.selectedDiseaseIds
                                      .remove(disease.id!.toLowerCase());
                                  AuthController.i.selectedDisease
                                      .removeWhere((d) => d.id == disease.id);
                                  AuthController.i.preselectedIds.removeWhere(
                                      (id) =>
                                          id.toLowerCase() ==
                                          disease.id!.toLowerCase());
                                }
                                log(AuthController.i.selectedDiseaseIds
                                    .toString());
                                log("${AuthController.i.selectedDiseases.map((d) => d.name).toList()}");
                              });
                            },
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Update selected diseases in the controller
                      AuthController.i.selectedDiseases.clear();
                      AuthController.i.selectedDiseases
                          .addAll(AuthController.i.selectedDisease);
                      AuthController.i.updateDiseaseId(
                          AuthController.i.preselectedIds.toString());
                      AuthController.i.update();
                      Navigator.pop(context);
                    },
                    child: const Text('Add Diseases'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
