import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:longevity_hub/components/Login/authTextField.dart';
import 'package:longevity_hub/components/Login/signin_or_login_Text.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/data/controller/auth_controller.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/repositories/auth_repo/auth_repo.dart';
// import 'package:longevity_hub/repositories/login_repository/login_repo.dart';
import 'package:longevity_hub/screens/auth_screens/forget_password.dart';
import 'package:longevity_hub/screens/auth_screens/signup.dart';
// import 'package:longevity_hub/screens/dashboard_screens/menu_drawer.dart';
import 'package:longevity_hub/services/auth_services.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:longevity_hub/utils/constants.dart';
import 'package:longevity_hub/utils/utils.dart';
// import 'package:device_info_plus/device_info_plus.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // isLoading = false;
    getfingerprint();
    AuthController.i.obsecure = true;
    AuthController.i.email.clear();
    AuthController.i.pass.clear();
    // getauth();
    super.initState();
  }

  getfingerprint() async {
    isfingerprintEnable = await LocalDb.getfingerprint();
    setState(() {
      isfingerprintEnable;
    });
  }

  bool isfingerprintEnable = false;
  final LocalAuthentication auth = LocalAuthentication();
  FocusNode emailfouseNode = FocusNode();
  FocusNode passwordfouseNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GetBuilder<AuthController>(
          builder: (cont) => BlurryModalProgressHUD(
            color: Colors.transparent,
            inAsyncCall: cont.isLoading,
            blurEffectIntensity: 5,
            progressIndicator: const SpinKitSpinningLines(
              color: ColorManager.kPrimaryColor,
              size: 60,
            ),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.07),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.background),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Get.height * 0.1),
                        Center(
                          child: Image.asset(
                            AppImages.logo,
                            height: Get.height * 0.14,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.04),
                        Text(
                          'WelcomeBack'.tr,
                          style: GoogleFonts.raleway(
                            textStyle: GoogleFonts.poppins(
                              fontSize: 28,
                              color: ColorManager.kPrimaryColor,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Text(
                          appName,
                          style: GoogleFonts.raleway(
                            textStyle: GoogleFonts.poppins(
                              fontSize: 20,
                              color: ColorManager.kPrimaryDarkGreenColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.07),
                        Center(
                          child: AuthTextField(
                            focusNode: emailfouseNode,
                            onsubmitted: (value) {
                              Utils.fieldFocusChange(
                                  context, emailfouseNode, passwordfouseNode);
                            },
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'EnterEmail'.tr;
                              }
                              return null;
                            },
                            controller: AuthController.i.email,
                            hintText: 'Email'.tr,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.04),
                        GetBuilder<AuthController>(
                          builder: (cont) {
                            return Center(
                              child: AuthTextField(
                                focusNode: passwordfouseNode,
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return 'EnterPassword'.tr;
                                  }
                                  return null;
                                },
                                obscureText: AuthController.i.obsecure,
                                suffixIcon: InkWell(
                                  onTap: () {
                                    AuthController.i.updateobsecurepassword(
                                        !AuthController.i.obsecure);
                                  },
                                  child: AuthController.i.obsecure
                                      ? const Icon(
                                          CupertinoIcons.eye_slash,
                                          color: ColorManager
                                              .kPrimaryDarkGreenColor,
                                        )
                                      : const Icon(CupertinoIcons.eye,
                                          color: ColorManager
                                              .kPrimaryDarkGreenColor),
                                ),
                                controller: AuthController.i.pass,
                                // passwordController,
                                hintText: 'Password'.tr,
                                obscuringCharacter: '*',
                              ),
                            );
                          },
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(() => ForgetPassword());
                              },
                              child: Text(
                                'ForgotPassword?'.tr,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: ColorManager.kblackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.03),
                        Center(
                          child: CustomButton(
                            buttonheight: Get.height * 0.07,
                            backgroundColor: ColorManager.kPrimaryColor,
                            buttonwidth: Get.width * 0.85,
                            onPress: () async {
                              if (_formKey.currentState!.validate()) {
                                AuthController.i.accountType = '1';
                                AuthRepository().loginApi();
                              }
                            },
                            mywidget:

                                // AuthController.i.isLoading
                                //     ? const CircularProgressIndicator(
                                //         color: Colors.white,
                                //       )
                                //     :

                                Text(
                              "SignIn".tr,
                              style: GoogleFonts.poppins(
                                color: ColorManager.kblackColor,
                                fontSize: 20,
                              ),
                            ),
                            radius: 10,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: Get.width * 0.15,
                              child: const Divider(
                                color: ColorManager.kblackColor,
                                thickness: 1.5,
                              ),
                            ),
                            Text("SignInWith".tr,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: ColorManager.kblackColor,
                                  fontSize: 12,
                                )),
                            SizedBox(
                              width: Get.width * 0.15,
                              child: const Divider(
                                color: ColorManager.kblackColor,
                                thickness: 1.5,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // InkWell(
                            //   onTap: () async {
                            //     await AuthService().facebookLogin();
                            //   },
                            //   child: SizedBox(
                            //     height: Get.height * 0.06,
                            //     child: Image.asset(AppImages.facebook),
                            //   ),
                            // ),
                            // SizedBox(width: Get.width * 0.04),
                            InkWell(
                              onTap: () async {
                                AuthService().googleLogin();
                              },
                              child: SizedBox(
                                height: Get.height * 0.06,
                                child: Image.asset(AppImages.google),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.04),
                        SignupOrLoginText(
                          pre: 'DontHaveAnAccount?'.tr,
                          suffix: 'signup'.tr,
                          onTap: () {
                            Get.to(() => const SignupScreen());
                          },
                        ),
                        SizedBox(height: Get.height * 0.02),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
