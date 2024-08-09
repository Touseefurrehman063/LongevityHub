// import 'package:flutter/material.dart';

// class CommunityScreen extends StatefulWidget {
//   const CommunityScreen({super.key});

//   @override
//   State<CommunityScreen> createState() => _CommunityScreenState();
// }

// class _CommunityScreenState extends State<CommunityScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(body: Center(child: Text("Community")));
//   }
// }

// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/community_fields/community_fields.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/data/controller/auth_controller.dart';
import 'package:longevity_hub/data/controller/community_controller/community_controller.dart';
import 'package:longevity_hub/data/controller/intro_steps_controller/intro_steps_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/models/diseases_model/disease_model.dart';
import 'package:longevity_hub/screens/community_screens/my_community_center_screen.dart';
import 'package:longevity_hub/screens/dashboard_screens/menu_drawer.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:longevity_hub/utils/searchable_dropdown/searchable_disease_dropdown.dart';

class CommunityScreen extends StatefulWidget {
  final bool navigateToMenuScreen;
  const CommunityScreen({Key? key, this.navigateToMenuScreen = false})
      : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.kBackColor,
      appBar: AppBar(
        backgroundColor: ColorManager.kBackColor,
        leading: widget.navigateToMenuScreen
            ? const SizedBox.shrink()
            : InkWell(
                onTap: () {
                  Get.to(() => const DrawerScreen());
                },
                child: Image.asset(
                  AppImages.backArrow,
                  scale: 10,
                  color: ColorManager.kblackColor,
                ),
              ),
        title: Text(
          "createCommunity".tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: ColorManager.kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "connectwithcommunity".tr,
                    style: GoogleFonts.poppins(
                        color: ColorManager.kGreyColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              CommunityCustomTextField(
                suffixIcon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: ColorManager.kblackColor,
                ),
                onTap: () async {
                  List<String> preselectedIds =
                      AuthController.i.diseasesid!.split(", ");

                  StepsController.i.selectedDisease = null;
                  Diseases generic = await searchabledropdowndisease(
                      context, StepsController.i.diseaseList);
                  StepsController.i.getDiseases();
                  StepsController.i.selectedDisease = null;
                  StepsController.i.updatedisease(generic);

                  if (generic.id == null) {
                    StepsController.i.selectedDisease = generic;
                    StepsController.i.selectedDisease = (generic.id == null)
                        ? null
                        : StepsController.i.selectedDisease;
                  }
                  AuthController.i.diseasecont.text =
                      StepsController.i.selectedDisease?.id.toString() ?? '';
                },
                readonly: true,
                labelText: 'selectyourcommunity'.tr,
                hintText: "selectyourcommunity".tr,
                enabled: false,
                controller: CommunityController.i.selectcommuntiycont,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "communitypermission".tr,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: ColorManager.kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GetBuilder<CommunityController>(builder: (cont) {
                return CommunityCustomTextField(
                  suffixIcon: InkWell(
                    onTap: () async {
                      cont.updateApproveMemberToggle();
                    },
                    child: cont.isApproveMemberLoading
                        ? const Icon(
                            Icons.toggle_on_outlined,
                            color: ColorManager.kPrimaryColor,
                          )
                        : const Icon(
                            Icons.toggle_off_outlined,
                            color: ColorManager.kblackColor,
                          ),
                  ),
                  readonly: true,
                  hintText: "approvenewmember".tr,
                  enabled: false,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                );
              }),
              GetBuilder<CommunityController>(builder: (cont) {
                return CommunityCustomTextField(
                  suffixIcon: InkWell(
                    onTap: () async {
                      cont.updateApproveMemberToggle();
                    },
                    child: cont.isApproveMemberLoading
                        ? const Icon(
                            Icons.toggle_on_outlined,
                            color: ColorManager.kPrimaryColor,
                          )
                        : const Icon(
                            Icons.toggle_off_outlined,
                            color: ColorManager.kblackColor,
                          ),
                  ),
                  readonly: true,
                  hintText: "sendmessage&activity".tr,
                  enabled: false,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                );
              }),
              GetBuilder<CommunityController>(builder: (cont) {
                return CommunityCustomTextField(
                  suffixIcon: InkWell(
                    onTap: () async {
                      cont.updateApproveMemberToggle();
                    },
                    child: cont.isApproveMemberLoading
                        ? const Icon(
                            Icons.toggle_on_outlined,
                            color: ColorManager.kPrimaryColor,
                          )
                        : const Icon(
                            Icons.toggle_off_outlined,
                            color: ColorManager.kblackColor,
                          ),
                  ),
                  readonly: true,
                  hintText: "addothermembers".tr,
                  enabled: false,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                );
              }),
              Container(
                height: Get.height * 0.2,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: ColorManager.kblackColor, width: 1.0),
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "addmembers".tr,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: ColorManager.kPrimaryColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.08,
                      ),
                      child: CommunityCustomTextField(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: ColorManager.kblackColor,
                        ),
                        hintText: "searchid".tr,
                        controller: CommunityController.i.searchcont,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              CustomButton(
                buttonheight: Get.height * 0.07,
                backgroundColor: ColorManager.kPrimaryColor,
                buttonwidth: Get.width * 0.85,
                onPress: () async {
                  Get.to(() => const MyCommunityCenter());
                },
                mywidget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "createCommunity".tr,
                      style: GoogleFonts.poppins(
                          color: ColorManager.kblackColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                radius: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
