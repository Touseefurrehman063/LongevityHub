import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/Dashboard/dashboard_circular_categories.dart';
import 'package:longevity_hub/components/Dashboard/dashboard_gym_videos.dart';
import 'package:longevity_hub/components/custom_appbar.dart';
import 'package:longevity_hub/data/controller/auth_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/repositories/auth_repo/auth_repo.dart';
import 'package:longevity_hub/screens/dashboard_screens/menu_drawer.dart';
import 'package:longevity_hub/screens/profile_screen/edit_profile_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:longevity_hub/utils/constants.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Userprofile extends StatefulWidget {
  const Userprofile({super.key});

  @override
  State<Userprofile> createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    func();
  }

  func() async {
    setState(() {
      isLoading = true;
    });
    await AuthRepository().profiledetail();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerText: "profile".tr,
        leadingOnPressed: () {
          Get.to(() => const DrawerScreen());
        },
        trailingImage: InkWell(
          onTap: (() {
            Get.to(() => const EditProfileScreen());
          }),
          child: Image.asset(
            AppImages.edit,
            scale: 10,
            color: ColorManager.kblackColor,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.background),
            fit: BoxFit.fill,
          ),
        ),
        child: BlurryModalProgressHUD(
          color: Colors.transparent,
          inAsyncCall: isLoading,
          blurEffectIntensity: 4,
          progressIndicator: const SpinKitSpinningLines(
            color: ColorManager.kPrimaryColor,
            size: 60,
          ),
          child: GetBuilder<AuthController>(
            builder: (_) => SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height * 0.01),
                  Center(
                    child: Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return BlurredImageDialog(
                                imageUrl:
                                    AuthController.i.user?.picturePath == null
                                        ? AppImages.avatar
                                        : baseURL +
                                            AuthController.i.user!.picturePath!,
                                isNetworkImage:
                                    AuthController.i.user?.picturePath != null,
                              );
                            },
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: AuthController.i.user?.picturePath == null
                              ? Image.asset(
                                  AppImages.avatar,
                                  scale: 3,
                                )
                              : Image.network(
                                  baseURL + AuthController.i.user!.picturePath!,
                                  height: Get.height * 0.14,
                                  width: Get.width * 0.3,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Center(
                    child: Text(
                      // "Shaikh Nawaaf".tr,
                      AuthController.i.user?.firstName ?? "user".tr,
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.kblackColor,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "basicmember".tr,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: ColorManager.kblackColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  AuthController.i.user?.weight.toString() ??
                                      "",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.kblackColor,
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.01,
                                ),
                                Text(
                                  AuthController.i.user
                                          ?.weightMeasurementCategoryUnitAbbrevation ??
                                      "kg",
                                  style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: ColorManager.kblackColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "weight".tr,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: ColorManager.kblackColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          "|",
                          style: GoogleFonts.poppins(
                            fontSize: 25,
                            color: ColorManager.kGreyColor.withOpacity(0.6),
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  AuthController.i.user?.height.toString() ??
                                      "",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.kblackColor,
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.01,
                                ),
                                Text(
                                  AuthController.i.user
                                          ?.heightMeasurementCategoryUnitAbbrevation ??
                                      "cm",
                                  style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: ColorManager.kblackColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "height".tr,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: ColorManager.kblackColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          "|",
                          style: GoogleFonts.poppins(
                            fontSize: 25,
                            color: ColorManager.kGreyColor.withOpacity(0.6),
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  (AuthController.i.user?.age
                                              ?.split("y")
                                              .first ??
                                          "0")
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.kblackColor,
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.01,
                                ),
                                Text(
                                  "year".tr,
                                  style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: ColorManager.kblackColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "age".tr,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: ColorManager.kblackColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: Get.height * 0.01),
                      width: Get.width * 0.93,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorManager.kPrimaryColor,
                      ),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center, // Centering the row
                        children: [
                          // Divider

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "phone".tr,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.kWhiteColor,
                                    fontSize: 12),
                              ),
                              SizedBox(
                                width: Get.width * 0.3,
                                child: Text(
                                  AuthController.i.user?.cellNumber ?? "",
                                  textAlign: TextAlign.end,
                                  maxLines: 1,
                                  style: GoogleFonts.poppins(
                                      color: ColorManager.kWhiteColor,
                                      fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: Get.width * 0.02),
                          // Divider
                          Text(
                            "|".tr,
                            style: GoogleFonts.poppins(
                              fontSize: 30,
                              color: ColorManager.kWhiteColor,
                            ),
                          ),
                          SizedBox(width: Get.width * 0.02),
                          // Email Column
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "email".tr,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.kWhiteColor,
                                    fontSize: 12),
                              ),
                              SizedBox(
                                width: Get.width * 0.4,
                                child: Text(
                                  // "Shaikhnawaaf28@gmail.com",
                                  AuthController.i.user?.email ?? "",
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  style: GoogleFonts.poppins(
                                    color: ColorManager.kWhiteColor,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.05,
                        vertical: Get.height * 0.015),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "category".tr,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.kblackColor,
                          ),
                        ),
                        Text(
                          "seeall".tr,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: ColorManager.kblackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.05),
                    child: SizedBox(
                        height: Get.height * 0.14,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(
                            width: Get.width * 0.03,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return DashboardCircularCategories(
                                text: "Yoga", image: AppImages.yoga);
                          },
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.05,
                        vertical: Get.height * 0.015),
                    child: Text(
                      "justforyou".tr,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.kblackColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.05),
                    child: SizedBox(
                        height: Get.height * 0.3,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(
                            width: Get.width * 0.03,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return DashboardGymVideo(
                              text: "Be Free",
                              time: "20 min",
                              image: AppImages.beFree1,
                            );
                          },
                        )),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BlurredImageDialog extends StatelessWidget {
  final String imageUrl;
  final bool isNetworkImage;

  const BlurredImageDialog(
      {super.key, required this.imageUrl, required this.isNetworkImage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Stack(
        children: [
          // Blurred Background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.transparent,
            ),
          ),
          // Centered Circular Image
          Center(
            child: ClipOval(
              child: isNetworkImage
                  ? Image.network(
                      imageUrl,
                      height: Get.height * 0.43,
                      width: Get.width * 0.95,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      imageUrl,
                      height: Get.height * 0.43,
                      width: Get.width * 0.95,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
