// ignore_for_file: non_constant_identifier_names

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_activity_container/custom_disease_container.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/data/controller/intro_steps_controller/intro_steps_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/models/diseases_model/disease_model.dart';
import 'package:longevity_hub/screens/steps_screen/welcome_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class SelectDisease extends StatefulWidget {
  const SelectDisease({super.key});

  @override
  State<SelectDisease> createState() => _SelectDiseaseState();
}

class _SelectDiseaseState extends State<SelectDisease> {
  @override
  void initState() {
    StepsController.i.selectedDiseaseIds.clear();
    StepsController.i.searchcont.clear();
    StepsController.i.isDiseaseSelected = false;
    StepsController.i.diseasepagenumber = 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      StepsController.i.getDiseases();
    });

    StepsController.i.diseasepagenumber = 0;

    StepsController.i.scrollController.addListener(() {
      // var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;
      if (StepsController.i.scrollController.position.pixels ==
          StepsController.i.scrollController.position.maxScrollExtent) {
        var isCallToFetchData = StepsController.i.setStartToFetchNextData();
        if (isCallToFetchData == true) {
          StepsController.i.getDiseases();
          setState(() {});
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                AppImages.backArrow,
                scale: 10,
                color: ColorManager.kblackColor,
              ),
            ),
            title: Text(
              "step7of7".tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: ColorManager.kblackColor,
              ),
            ),
            centerTitle: true,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: Get.width * 0.02),
                child: InkWell(
                  onTap: () {
                    Get.offAll(() => const WelcomeLongevity());
                  },
                  child: Row(
                    children: [
                      Text(
                        "skip".tr,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: ColorManager.kblackColor,
                        ),
                      ),
                      Image.asset(
                        "assets/images/skiparrow.png",
                        scale: 10,
                        color: ColorManager.kblackColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.0, horizontal: Get.width * 0.07),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.background),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Align text to the top
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'selectDisease'.tr,
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.kblackColor,
                        ),
                      ),
                      Text(
                        'youcanchangelater'.tr,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: ColorManager.kblackColor,
                        ),
                      ),

                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      SearchTextField(),
                      //
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Expanded(
                    child: GetBuilder<StepsController>(
                        builder: (cont) => cont.isLoading
                            ? Center(
                                child: BlurryModalProgressHUD(
                                  color: Colors.transparent,
                                  inAsyncCall: cont.isLoading,
                                  blurEffectIntensity: 4,
                                  progressIndicator: const SpinKitSpinningLines(
                                    color: ColorManager.kPrimaryColor,
                                    size: 60,
                                  ),
                                  child: Container(),
                                ),
                              )
                            : NotificationListener<ScrollNotification>(
                                onNotification:
                                    (ScrollNotification scrollInfo) {
                                  if (scrollInfo is ScrollEndNotification &&
                                      scrollInfo.metrics.extentAfter == 0) {
                                    cont.isLoadingmoreData;
                                    return true;
                                  }
                                  return false;
                                },
                                child: ListView.builder(
                                  controller:
                                      StepsController.i.scrollController,
                                  itemCount: cont.diseaseList.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Diseases disease = cont.diseaseList[index];
                                    cont.isDiseaseSelected =
                                        cont.isSelectedDiseaseMap[disease.id] ??
                                            false;
                                    return InkWell(
                                      onTap: () async {
                                        StepsController.i
                                            .toggleDiseaseSelection(
                                                disease.id!);
                                        if (StepsController.i.selectedDiseaseIds
                                            .contains(cont.diseaseList[index].id
                                                .toString())) {
                                          StepsController.i.selectedDiseaseIds
                                              .remove(cont.diseaseList[index].id
                                                  .toString());
                                        } else {
                                          StepsController.i.selectedDiseaseIds
                                              .add(cont.diseaseList[index].id
                                                  .toString());
                                        }
                                        StepsController.i.selectedActivityIds =
                                            StepsController
                                                .i.selectedActivityIds
                                                .toSet()
                                                .toList();
                                        setState(() {});
                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: Get.height * 0.12,
                                            child: CustomDiseaseContainer(
                                              centerText: disease.name!,
                                              // trailingImage: AppImages.cardio2,
                                              bkColor: const Color.fromARGB(
                                                  255, 238, 255, 213),
                                              onTap: () {
                                                StepsController.i
                                                    .toggleDiseaseSelection(
                                                        disease.id!);
                                                if (StepsController
                                                    .i.selectedDiseaseIds
                                                    .contains(disease.id
                                                        .toString())) {
                                                  StepsController
                                                      .i.selectedDiseaseIds
                                                      .remove(disease.id
                                                          .toString());
                                                } else {
                                                  StepsController
                                                      .i.selectedDiseaseIds
                                                      .add(disease.id
                                                          .toString());
                                                }
                                                StepsController
                                                        .i.selectedDiseaseIds =
                                                    StepsController
                                                        .i.selectedDiseaseIds
                                                        .toSet()
                                                        .toList();
                                                setState(
                                                    () {}); // Ensure the state is updated after selection
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.02,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  CustomButton(
                    buttonheight: Get.height * 0.07,
                    backgroundColor: ColorManager.kPrimaryColor,
                    buttonwidth: Get.width * 0.85,
                    onPress: () async {
                      StepsController.i.updateIntroProfile();
                    },
                    mywidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "next".tr,
                          style: GoogleFonts.poppins(
                            color: ColorManager.kblackColor,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.01,
                        ),
                        Image.asset(
                          AppImages.nextArrow,
                          scale: 8,
                        ),
                      ],
                    ),
                    radius: 10,
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                ],
              ),
            ),
          )),
    );
  }

  TextFormField SearchTextField() {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w900,
          color: ColorManager.kGreyColor,
        ),
        hintText: 'search'.tr,
        filled: true,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorManager.kblackColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: ColorManager.kblackColor,
          ),
        ),
        fillColor: Colors.transparent,
        prefixIcon: const Icon(
          Icons.search,
          color: ColorManager.kGreyColor,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.kblackColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
        ),
      ),
      controller: StepsController.i.searchcont,
      onChanged: (val) {
        setState(() {
          StepsController.i.getDiseases();
          StepsController.i.searchcont.text = val;
        });
      },
    );
  }
}
