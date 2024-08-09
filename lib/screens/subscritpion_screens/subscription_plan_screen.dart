import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/components/custom_plan_container/custom_plan_container.dart';
import 'package:longevity_hub/components/custom_planner_container/custom_planner_container.dart';
import 'package:longevity_hub/data/controller/subscription_controller/subscription_controller.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/repositories/subscription_repo/subscription_repo.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';

class SubscriptionPlanScreen extends StatefulWidget {
  const SubscriptionPlanScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionPlanScreen> createState() => _SubscriptionPlanScreenState();
}

class _SubscriptionPlanScreenState extends State<SubscriptionPlanScreen> {
  late Future<void> _getDataFuture;

  @override
  void initState() {
    _getDataFuture = SubscriptionRepo.getPackageSubscriptionPlan();
    SubscriptionController.i.fetchPackageExpiryDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.subscribemars,
            fit: BoxFit.cover,
          ),
          FutureBuilder(
            future: _getDataFuture,
            builder: (context, snapshot) {
              return BlurryModalProgressHUD(
                inAsyncCall:
                    snapshot.connectionState == ConnectionState.waiting,
                blurEffectIntensity: 4,
                progressIndicator: const SpinKitSpinningLines(
                  color: Color(0xFFFDA11A),
                  size: 60,
                ),
                child: _buildContent(snapshot),
              );
            },
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.05,
            left: MediaQuery.of(context).size.width * 0.04,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: ColorManager.kblackColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
          // child: CircularProgressIndicator(
          //   color: Colors.orange,
          // ),
          );
    } else if (snapshot.hasError) {
      return Center(
        child: Text('${"errorfetchingdata".tr} ${snapshot.error}'),
      );
    } else {
      return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: Get.height * 0.1,
            left: Get.width * 0.04,
            top: Get.height * 0.4,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "subscriptionplan".tr,
                style: GoogleFonts.poppins(
                  color: ColorManager.kblackColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Center(
                child: Text(
                  "unlockyourfullpotiential".tr,
                  style: GoogleFonts.poppins(
                    color: ColorManager.kblackColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              GetBuilder<SubscriptionController>(
                builder: (controller) {
                  if (controller.packages.isEmpty) {
                    return Center(
                      child: Text(
                        "nosubscriptionplan".tr,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: ColorManager.kblackColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: controller
                          .packages[controller.selectedIndex].features.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            CustomPlanContainer(
                              centerText: controller
                                  .packages[controller.selectedIndex]
                                  .features[index]
                                  .name
                                  .toString(),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              GetBuilder<SubscriptionController>(
                builder: (controller) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          List.generate(controller.packages.length, (index) {
                        var chargeDetails =
                            controller.packages[index].chargeDetails;
                        var chargeDetailText =
                            chargeDetails.map((chargeDetail) {
                          var chargeType = chargeDetail.chargeTypeName ?? '';
                          return chargeType;
                        }).join(", ");
                        var chargeAmountText =
                            chargeDetails.map((chargeDetail) {
                          return "\$${chargeDetail.charges.toStringAsFixed(2)}";
                        }).join(", ");

                        return Padding(
                          padding: EdgeInsets.only(right: Get.width * 0.03),
                          child: CustomPllaner(
                            customtext: controller.packages[index].name,
                            customtext1: chargeDetailText.isNotEmpty
                                ? chargeDetailText
                                : '',
                            customtext2: chargeAmountText.isNotEmpty
                                ? chargeAmountText
                                : '\$0.00',
                            isSelected: controller.selectedIndex == index,
                            onSelect: (isSelected) {
                              setState(() {
                                if (isSelected) {
                                  controller.selectedIndex = index;
                                  LocalDb().saveSelectedPackageId(controller
                                      .packages[index]
                                      .packageSubscriptionPlanId);
                                  log(controller.packages[index]
                                      .packageSubscriptionPlanId);
                                } else {
                                  controller.selectedIndex = 0;
                                }
                              });
                            },
                          ),
                        );
                      }),
                    ),
                  );
                },
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              SubscriptionController.i.packages.isNotEmpty
                  ? GetBuilder<SubscriptionController>(
                      builder: (cont) {
                        return CustomButton(
                          buttonheight: Get.height * 0.07,
                          backgroundColor: cont.isUpdatePackage
                              ? Colors.grey
                              : ColorManager.kPrimaryColor,
                          buttonwidth: Get.width * 0.75,
                          onPress: () async {
                            setState(() {
                              cont.isUpdatePackage = true;
                            });
                            await SubscriptionRepo
                                .updatePackageSubscriptionPlan();

                            await cont.fetchPackageExpiryDate();
                            LocalDb().saveSelectedIndex(cont.selectedIndex);
                            LocalDb().saveSelectedPackageId(cont
                                .packages[cont.selectedIndex]
                                .packageSubscriptionPlanId);

                            setState(() {
                              cont.isUpdatePackage = false;
                            });
                          },
                          mywidget: cont.isUpdatePackage
                              ? const CircularProgressIndicator(
                                  color: Colors.orange,
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "subscribe".tr,
                                      style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                          radius: 10,
                        );
                      },
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      );
    }
  }
}
