import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/data/controller/auth_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/auth_screens/login.dart';
import 'package:longevity_hub/screens/dashboard_screens/menu_drawer.dart';
import 'package:longevity_hub/utils/AppImages.dart';

// ignore: must_be_immutable
class WelcomeSuccess extends StatefulWidget {
  const WelcomeSuccess({super.key});

  @override
  State<WelcomeSuccess> createState() => _WelcomeSuccessState();
}

class _WelcomeSuccessState extends State<WelcomeSuccess> {
  TextEditingController newpasscontroller = TextEditingController();
  TextEditingController confirmnewpasscontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    navigateToLogin();
  }

  void navigateToLogin() {
    Future.delayed(const Duration(seconds: 5), () {
      if (AuthController.i.accountType == '1') {
        AuthController.i.updateIsLoading(false);
        Get.offAll(() => const LoginScreen());
      } else {
        Get.offAll(() => const DrawerScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: Get.height * 0.00, horizontal: Get.width * 0.09),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.background),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.12,
                ),
                Center(
                  child: Image.asset(
                    "assets/images/a.png",
                    height: Get.height * 0.14,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.1,
                ),
                Center(
                    child: Image.asset(
                  AppImages.thumbsup,
                  height: Get.height * 0.12,
                )),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Center(
                  child: Text(
                    'thankyou'.tr,
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: ColorManager.kblackColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Center(
                  child: Text(
                    'youwillberedirectedin5'.tr,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: ColorManager.kblackColor,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'click'.tr,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.kblackColor,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Here'.tr,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.kPrimaryColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              if (AuthController.i.accountType == '1') {
                                AuthController.i.updateIsLoading(false);
                                Get.offAll(() => const LoginScreen());
                              } else {
                                Get.offAll(() => const DrawerScreen());
                              }
                            },
                        ),
                        TextSpan(
                          text: 'ifYounotredirect'.tr,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.kblackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.28,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'NeedHelp?VisitOur'.tr,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorManager.kblackColor,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'HelpCenter'.tr,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.kPrimaryColor,
                          ),
                        ),
                      ],
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
    );
  }
}
