// ignore_for_file: unused_local_variable, non_constant_identifier_names, unused_element

import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/Login/authTextField.dart';
import 'package:longevity_hub/components/Login/signin_or_login_Text.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/data/controller/auth_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/repositories/auth_repo/auth_repo.dart';
import 'package:longevity_hub/repositories/login_repository/login_repo.dart';
import 'package:longevity_hub/screens/auth_screens/login.dart';
import 'package:longevity_hub/services/auth_services.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final api = LoginRepository();

  @override
  void dispose() {
    AuthController.i.name.clear();
    AuthController.i.phone.clear();
    AuthController.i.email.clear();
    AuthController.i.pass.clear();
    AuthController.i.confirmpass.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<AuthController>(builder: (cont) {
          return Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.symmetric(
                  // vertical: Get.height * 0.00,
                  horizontal: Get.width * 0.07),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.background),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.13,
                  ),
                  Text(
                    'signup'.tr,
                    style: GoogleFonts.raleway(
                      textStyle: GoogleFonts.poppins(
                          fontSize: 24,
                          color: ColorManager.kPrimaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'Longevity Hub'.tr,
                    style: GoogleFonts.raleway(
                      textStyle: GoogleFonts.poppins(
                        fontSize: 17,
                        color: const Color(0xff3DB443),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.06,
                  ),
                  Center(
                    child: AuthTextField(
                      controller: AuthController.i.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enteruserName'.tr;
                        }

                        RegExp regex = RegExp(r'^[a-zA-Z ]+$');
                        if (!regex.hasMatch(value)) {
                          return 'shouldOnlycontainAlphabets'.tr;
                        }
                        return null;
                      },
                      hintText: 'name'.tr,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Center(
                    child: AuthTextField(
                      keyboardType: TextInputType.phone,
                      controller: AuthController.i.phone,
                      showCountryCodePicker: true,
                      formatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                        PhoneNumberFormatter(),
                      ],
                      onCountryCodeChanged: (code) {
                        log("Country code changed to: $code");
                        setState(() {
                          AuthController.i.countryCode = code;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enterPhone'.tr;
                        }

                        RegExp regex = RegExp(r'^[0-9- ]+$');
                        if (!regex.hasMatch(value)) {
                          return 'shouldonlyContainDigits'.tr;
                        }
                        return null;
                      },
                      hintText: 'phone'.tr,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Center(
                    child: AuthTextField(
                      controller: AuthController.i.email,
                      validator: (String? email) {
                        if (email == null || email.isEmpty) {
                          return 'enterEmail'.tr;
                        }

                        RegExp emailRegex = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9]+\.[a-zA-Z]');
                        // RegExp emailRegex = RegExp(
                        //     r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)\.com$');
                        if (!emailRegex.hasMatch(email)) {
                          return 'invalidEmailFormat'.tr;
                        }
                        return null;
                      },
                      hintText: 'email'.tr,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Center(
                    child: AuthTextField(
                      controller: AuthController.i.pass,
                      validator: (String? password) {
                        if (password == null || password.isEmpty) {
                          return 'enterPass'.tr;
                        }

                        if (password.length < 6) {
                          return 'passMustbe6characterlong'.tr;
                        }

                        if (!password.contains(RegExp(r'[A-Z]'))) {
                          return 'mustContainUppercaseletter'.tr;
                        }

                        if (!password.contains(RegExp(r'[0-9]'))) {
                          return 'mustcontainOneNumber'.tr;
                        }

                        if (!password
                            .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                          return 'mustcontainSpecialChar'.tr;
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
                                  color: ColorManager.kPrimaryDarkGreenColor,
                                )
                              : const Icon(CupertinoIcons.eye,
                                  color: ColorManager.kPrimaryDarkGreenColor)),
                      hintText: 'password'.tr,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Center(
                    child: AuthTextField(
                      controller: AuthController.i.confirmpass,
                      validator: (String? password) {
                        if (password == null || password.isEmpty) {
                          return 'enterconfirmPass'.tr;
                        }

                        if (password.length < 6) {
                          return 'passMustbe6characterlong'.tr;
                        }

                        if (!password.contains(RegExp(r'[A-Z]'))) {
                          return 'mustContainUppercaseletter'.tr;
                        }

                        if (!password.contains(RegExp(r'[0-9]'))) {
                          return 'mustcontainOneNumber'.tr;
                        }

                        if (!password
                            .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                          return 'mustcontainSpecialChar'.tr;
                        }
                        return null; // Return null if password meets all requirements
                      },
                      obscureText: AuthController.i.obsecure1,
                      suffixIcon: InkWell(
                          onTap: () {
                            AuthController.i.updateobsecurepassword1(
                                !AuthController.i.obsecure1);
                          },
                          child: AuthController.i.obsecure1
                              ? const Icon(
                                  CupertinoIcons.eye_slash,
                                  color: ColorManager.kPrimaryDarkGreenColor,
                                )
                              : const Icon(CupertinoIcons.eye,
                                  color: ColorManager.kPrimaryDarkGreenColor)),
                      hintText: 'confirmPass'.tr,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  Center(
                    child: CustomButton(
                      buttonheight: Get.height * 0.07,
                      backgroundColor: ColorManager.kPrimaryColor,
                      buttonwidth: Get.width * 0.85,
                      onPress: () async {
                        if (_formKey.currentState!.validate()) {
                          // await AuthController.i.registerUser(
                          //     AuthController.i.email.text.trim(),
                          //     "123123");
                          AuthController.i.accountType = "1";

                          await AuthRepository().signupApi();
                        }
                      },
                      mywidget: AuthController.i.isLoading == true
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "signup".tr,
                              style: GoogleFonts.poppins(
                                  color: ColorManager.kblackColor,
                                  fontSize: 20),
                            ),
                      radius: 10,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: Get.width * 0.2,
                        child: const Divider(
                          color: ColorManager.kblackColor,
                          thickness: 1.5,
                        ),
                      ),
                      Text("orRegisterWith".tr,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color: ColorManager.kblackColor,
                              fontSize: 12)),
                      SizedBox(
                        width: Get.width * 0.2,
                        child: const Divider(
                          color: ColorManager.kblackColor,
                          thickness: 1.5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //     height: Get.height * 0.06,
                      //     child: Image.asset(AppImages.mac)),
                      // SizedBox(
                      //   width: Get.width * 0.04,
                      // ),
                      // InkWell(
                      //   onTap: () async {
                      //     await AuthService().facebookLogin();
                      //   },
                      //   child: SizedBox(
                      //       height: Get.height * 0.06,
                      //       child: Image.asset(AppImages.facebook)),
                      // ),
                      // SizedBox(
                      //   width: Get.width * 0.04,
                      // ),
                      InkWell(
                        onTap: () async {
                          await AuthService().googleLogin();
                        },
                        child: SizedBox(
                            height: Get.height * 0.06,
                            child: Image.asset(AppImages.google)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  SignupOrLoginText(
                    pre: 'alreadyhaveanAccount'.tr,
                    suffix: 'login'.tr,
                    onTap: () {
                      Get.to(() => const LoginScreen());
                    },
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    String formattedText = ' ';
    int count = 0;
    for (int i = 0; i < newValue.text.length; i++) {
      if (i == 2) {
        formattedText += ' ';
      }
      formattedText += newValue.text[i];
      count++;
    }
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
