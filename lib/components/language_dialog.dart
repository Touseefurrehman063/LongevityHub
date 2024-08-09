import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/models/language_model.dart';
import '../../data/controller/language_controller.dart';

Future<String?> languageSelector(
    BuildContext context, List<LanguageModel> languageList) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) =>
        StatefulBuilder(builder: (context, newState) {
      LanguageController.i.updateSelected(LanguageController.i.selected);
      return AlertDialog(
        backgroundColor: ColorManager.kWhiteColor,
        title: Text(
          'selectLanguage'.tr,
          style: const TextStyle(color: ColorManager.kPrimaryColor),
        ),
        content: SingleChildScrollView(
            child: SizedBox(
          width: Get.width,
          child: GetBuilder<LanguageController>(builder: (cont) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: languageList.length,
                itemBuilder: (context, index) {
                  final lang = languageList[index];
                  log(lang.toJson().toString());
                  return RadioListTile<LanguageModel>(
                    fillColor:
                        MaterialStateProperty.all(ColorManager.kPrimaryColor),
                    activeColor: Colors.white,
                    value: lang,
                    groupValue: cont.selected,
                    onChanged: (LanguageModel? lang) {
                      if (lang != null) {
                        newState(
                          () {
                            cont.updateSelectedIndex(index);
                            cont.updateSelected(lang);
                          },
                        );
                      }
                    },
                    title: Text(
                      lang.name!,
                      style: const TextStyle(color: ColorManager.kPrimaryColor),
                    ),
                  );
                });
          }),
        )),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.kWhiteColor),
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: Text(
                      'cancel'.tr,
                      style: const TextStyle(color: ColorManager.kPrimaryColor),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GetBuilder<LanguageController>(builder: (cont) {
                  return Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.kPrimaryColor),
                        onPressed: () {
                          Navigator.pop(context, 'ok'.tr);
                          cont.updateLocale(cont.selected!.locale!);
                          LocalDb().setLanguage(cont.selected);
                        },
                        child: Text(
                          'ok'.tr,
                          style:
                              const TextStyle(color: ColorManager.kWhiteColor),
                        )),
                  );
                })
              ],
            ),
          )
        ],
      );
    }),
  );
}
