import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/faqs_dialog.dart';
import 'package:longevity_hub/components/language_dialog.dart';
import 'package:longevity_hub/components/privecy_dialogue.dart';
import 'package:longevity_hub/components/terms_condition_dialogue.dart';
import 'package:longevity_hub/data/controller/auth_controller.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/repositories/auth_repo/auth_repo.dart';
import 'package:longevity_hub/repositories/subscription_repo/subscription_repo.dart';
import 'package:longevity_hub/screens/auth_screens/change_password_screen.dart';
import 'package:longevity_hub/screens/exercise_screens/exercise_screen.dart';
import 'package:longevity_hub/screens/health_az/health_az.dart';
import 'package:longevity_hub/screens/health_az/wellness.dart';
import 'package:longevity_hub/screens/health_insights_screens/health_insights.dart';
import 'package:longevity_hub/screens/profile_screen/profile_screens.dart';
import 'package:longevity_hub/screens/subscritpion_screens/subscription_screen.dart';
import 'package:longevity_hub/services/auth_services.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:longevity_hub/utils/constants.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
    func();
    getname();
  }

//  final String url;

  String? name;
  getname() async {
    name = await LocalDb().getUsername() ?? "";
    setState(() {});
  }

  func() async {
    await AuthRepository().profiledetail();
  }

  bool isBiometric = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.kWhiteColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.background),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: Get.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  GetBuilder<AuthController>(builder: (cont) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: const Color(0xFFFEF4F7),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: cont.user?.picturePath == null
                                ? Image.asset(
                                    AppImages.avatar,
                                    scale: 6,
                                  )
                                : Image.network(
                                    baseURL + cont.user?.picturePath!,
                                    height: Get.height * 0.14,
                                    width: Get.width * 0.2,
                                    fit: BoxFit.cover,
                                  )),
                      ),
                    );
                  }),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: GetBuilder<AuthController>(builder: (cont) {
                          return Text(
                            cont.user?.firstName ?? "user".tr,
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: ColorManager.kPrimaryColor,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        }),
                      ),
                      SizedBox(
                        width: Get.width * 0.15,
                      ),
                      InkWell(
                        onTap: () async {
                          Get.to(() => const Userprofile());
                        },
                        child: Image.asset(
                          "assets/images/editprofile.png",
                          height: Get.height * 0.03,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: Get.height * 0.002,
                    color: ColorManager.kblackColor,
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  ListTile(
                    visualDensity:
                        const VisualDensity(horizontal: -2, vertical: -4),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    dense: true,
                    leading: Image.asset(
                      AppImages.healthInsight,
                      height: Get.height * 0.036,
                      width: Get.width * 0.08,
                    ),
                    minLeadingWidth: 0,
                    onTap: () async {
                      await SubscriptionRepo.getPackageExpiryDate();
                      await SubscriptionRepo.verifyModuleForUser("4", () {
                        Get.to(() => const HealthInsightsScreen());
                      });
                      // Get.to(() => const WellnessScreen());

                      // var isLoggedIn = await LocalDb().getLoginStatus();
                      // if (isLoggedIn == true) {
                      //   // Get.to(() => const Userprofile());
                      // } else {
                      //   Get.to(() => const LoginScreen());
                      // }
                      // Get.to(() => const Userprofile());
                    },
                    title: Text(
                      'healthInsights'.tr,
                      style: GoogleFonts.poppins(
                        textStyle: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.kblackColor,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: Get.height * 0.002,
                    color: ColorManager.kblackColor.withOpacity(0.2),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  ListTile(
                    visualDensity:
                        const VisualDensity(horizontal: -2, vertical: -4),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    dense: true,
                    leading: Image.asset(
                      AppImages.healthIcon,
                      height: Get.height * 0.036,
                      width: Get.width * 0.08,
                    ),
                    minLeadingWidth: 0,
                    onTap: () async {
                      // var isLoggedIn = await LocalDb().getLoginStatus();
                      // if (isLoggedIn == true) {
                      //   Get.to(() => const HealthAZScreen());
                      // } else {
                      //   Get.to(() => const LoginScreen());
                      // }
                      await SubscriptionRepo.getPackageExpiryDate();
                      await SubscriptionRepo.verifyModuleForUser("1", () {
                        Get.to(() => const HealthAZScreen());
                      });
                    },
                    title: Text(
                      'healthatoz'.tr,
                      style: GoogleFonts.poppins(
                        textStyle: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.kblackColor,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: Get.height * 0.002,
                    color: ColorManager.kblackColor.withOpacity(0.2),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  ListTile(
                    visualDensity:
                        const VisualDensity(horizontal: -2, vertical: -4),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    dense: true,
                    leading: Image.asset(
                      AppImages.wellness,
                      height: Get.height * 0.036,
                      width: Get.width * 0.08,
                    ),
                    minLeadingWidth: 0,
                    onTap: () async {
                      // Get.to(() => const WellnessScreen());
                      // var isLoggedIn = await LocalDb().getLoginStatus();
                      // if (isLoggedIn == true) {
                      //   Get.to(() => const WellnessScreen());
                      // } else {
                      //   Get.to(() => const LoginScreen());
                      // }
                      await SubscriptionRepo.getPackageExpiryDate();
                      await SubscriptionRepo.verifyModuleForUser("1", () {
                        Get.to(() => const WellnessScreen());
                      });
                    },
                    title: Text(
                      'wellness'.tr,
                      style: GoogleFonts.poppins(
                        textStyle: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.kblackColor,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: Get.height * 0.002,
                    color: ColorManager.kblackColor.withOpacity(0.2),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  ListTile(
                    onTap: () async {
                      Get.to(() => const SubscriptionScreen());
                    },
                    visualDensity:
                        const VisualDensity(horizontal: -2, vertical: -4),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    dense: true,
                    leading: Image.asset(
                      AppImages.subscription,
                      height: Get.height * 0.036,
                      width: Get.width * 0.08,
                    ),
                    minLeadingWidth: 0,
                    title: Text(
                      'subscription'.tr,
                      style: GoogleFonts.poppins(
                        textStyle: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.kblackColor,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: Get.height * 0.002,
                    color: ColorManager.kblackColor.withOpacity(0.2),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  // ListTile(
                  //   visualDensity:
                  //       const VisualDensity(horizontal: -2, vertical: -4),
                  //   contentPadding:
                  //       const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  //   dense: true,
                  //   leading: Image.asset(
                  //     AppImages.biometric,
                  //     height: Get.height * 0.036,
                  //     width: Get.width * 0.08,
                  //   ),
                  //   minLeadingWidth: 0,
                  //   trailing: Switch(
                  //       trackOutlineColor: MaterialStateProperty.resolveWith(
                  //         (final Set<MaterialState> states) {
                  //           if (states.contains(MaterialState.selected)) {
                  //             return ColorManager.kblackColor;
                  //           }
                  //           return ColorManager.kblackColor;
                  //         },
                  //       ),
                  //       thumbColor: MaterialStateProperty.resolveWith<Color>(
                  //           (Set<MaterialState> states) {
                  //         if (states.contains(MaterialState.disabled)) {
                  //           return Colors.black.withOpacity(.48);
                  //         }
                  //         return Colors.black;
                  //       }),
                  //       activeTrackColor:
                  //           const Color.fromARGB(255, 15, 11, 11).withOpacity(0),
                  //       inactiveTrackColor:
                  //           ColorManager.kblackColor.withOpacity(0),
                  //       value: ProfileController.i.fingerprint,
                  //       onChanged: (val) async {}),
                  //   title: Text(
                  //     'biometric'.tr,
                  //     style: GoogleFonts.poppins(
                  //       textStyle: GoogleFonts.poppins(
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.w400,
                  //         color: ColorManager.kblackColor,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Divider(
                  //   thickness: Get.height * 0.002,
                  //   color: ColorManager.kblackColor.withOpacity(0.2),
                  // ),
                  // SizedBox(
                  //   height: Get.height * 0.01,
                  // ),
                  ListTile(
                    visualDensity:
                        const VisualDensity(horizontal: -2, vertical: -4),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    dense: true,
                    leading: Image.asset(
                      AppImages.languages,
                      height: Get.height * 0.036,
                      width: Get.width * 0.08,
                    ),
                    minLeadingWidth: 0,
                    title: Text(
                      'languages'.tr,
                      style: GoogleFonts.poppins(
                        textStyle: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.kblackColor,
                        ),
                      ),
                    ),
                    onTap: () async {
                      await languageSelector(context, AppConstants.languages);
                    },
                  ),
                  Divider(
                    thickness: Get.height * 0.002,
                    color: ColorManager.kblackColor.withOpacity(0.2),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(() => const ExerciseScreen());
                    },
                    visualDensity:
                        const VisualDensity(horizontal: -2, vertical: -4),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    dense: true,
                    leading: Image.asset(
                      AppImages.myorder,
                      height: Get.height * 0.036,
                      width: Get.width * 0.08,
                    ),
                    minLeadingWidth: 0,
                    title: Text(
                      'myorders'.tr,
                      style: GoogleFonts.poppins(
                        textStyle: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.kblackColor,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: Get.height * 0.002,
                    color: ColorManager.kblackColor.withOpacity(0.2),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),

                  ListTile(
                    onTap: () {
                      Get.to(() => const ChangePasswordScreen());
                    },
                    visualDensity:
                        const VisualDensity(horizontal: -2, vertical: -4),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    dense: true,
                    leading: Image.asset(
                      AppImages.changePassword,
                      height: Get.height * 0.036,
                      width: Get.width * 0.08,
                    ),
                    minLeadingWidth: 0,
                    title: Text(
                      'changePass'.tr,
                      style: GoogleFonts.poppins(
                        textStyle: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.kblackColor,
                        ),
                      ),
                    ),
                  ),

                  // Divider(
                  //   thickness: Get.height * 0.002,
                  //   color: ColorManager.kblackColor.withOpacity(0.2),
                  // ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Divider(
                    thickness: Get.height * 0.002,
                    color: ColorManager.kblackColor,
                  ),
                  ListTile(
                    minLeadingWidth: 0,
                    visualDensity:
                        const VisualDensity(horizontal: -2, vertical: -4),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    dense: true,
                    title: Text(
                      'privecypolicy'.tr,
                      style: GoogleFonts.poppins(
                        textStyle: GoogleFonts.sora(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.kblackColor,
                        ),
                      ),
                    ),
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const PrivacyPolicyDialog();
                        },
                      );
                    },
                  ),
                  ListTile(
                    minLeadingWidth: 0,
                    visualDensity:
                        const VisualDensity(horizontal: -2, vertical: -4),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    dense: true,
                    title: Text(
                      'terms&condition'.tr,
                      style: GoogleFonts.poppins(
                        textStyle: GoogleFonts.sora(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.kblackColor,
                        ),
                      ),
                    ),
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const TermsConditionDialog();
                        },
                      );
                    },
                  ),
                  ListTile(
                    minLeadingWidth: 0,
                    visualDensity:
                        const VisualDensity(horizontal: -2, vertical: -4),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    dense: true,
                    title: Text(
                      'faqs'.tr,
                      style: GoogleFonts.poppins(
                        textStyle: GoogleFonts.sora(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.kblackColor,
                        ),
                      ),
                    ),
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const FAQsDialog();
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  ListTile(
                    onTap: () async {
                      deletionPopUp(context);
                    },
                    visualDensity:
                        const VisualDensity(horizontal: -2, vertical: -4),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    dense: true,
                    leading: Image.asset(
                      AppImages.bin,
                      height: Get.height * 0.036,
                      width: Get.width * 0.08,
                    ),
                    minLeadingWidth: 0,
                    title: Text(
                      'deletaccount'.tr,
                      style: GoogleFonts.poppins(
                        textStyle: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.kblackColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  ListTile(
                    visualDensity:
                        const VisualDensity(horizontal: -2, vertical: -4),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    dense: true,
                    onTap: () async {
                      LocalDb().saveLoginStatus(false);
                      AuthController.i.updateIsLoading(false);
                      // Get.offAll(() => const LoginScreen());
                      if (AuthController.i.accountType == "3") {
                        await AuthService().signOutGoogle();
                        await AuthRepository().logout();
                      }
                      await AuthRepository().logout();
                    },
                    leading: Image.asset(
                      AppImages.logout,
                      height: Get.height * 0.036,
                      width: Get.width * 0.08,
                    ),
                    minLeadingWidth: 0,
                    title: Text(
                      'logout'.tr,
                      style: GoogleFonts.poppins(
                        textStyle: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.kblackColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> deletionPopUp(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Center(
            child: Text(
              'confirmaccountdeletion'.tr,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: ColorManager.kblackColor,
              ),
            ),
          ),
          content: Text(
            'areyousuredeleteaccount'.tr,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: ColorManager.kblackColor,
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Cancel'.tr,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: ColorManager.kblackColor,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (AuthController.i.accountType == "3") {
                      await AuthRepository().deleteUserAccount();
                      await AuthService().deleteAccount();
                    }
                    await AuthRepository().deleteUserAccount();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'confirm'.tr,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            )
          ],
        );
      },
    );
  }
}
