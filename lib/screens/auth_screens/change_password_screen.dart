import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/Login/authTextField.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/data/controller/auth_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/repositories/auth_repo/auth_repo.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  // @override
  // void dispose() {
  //   AuthController.i.oldpasscontroller.dispose();
  //   AuthController.i.newpasscontroller.dispose();
  //   AuthController.i.confirmnewpasscontroller.dispose();
  //   super.dispose();
  // }

  void _startLoading() {
    setState(() {
      isLoading = true;
    });
  }

  void _stopLoading() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    AuthController.i.oldpasscontroller.clear();
    AuthController.i.changeNewpasscontroller.clear();
    AuthController.i.changeConfirmnewpasscontroller.clear();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                    height: Get.height * 0.10,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/images/a.png",
                      height: Get.height * 0.14,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.10,
                  ),
                  Center(
                    child: Text(
                      'changePass'.tr,
                      style: GoogleFonts.poppins(
                          fontSize: 25,
                          color: ColorManager.kPrimaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  GetBuilder<AuthController>(builder: (cont) {
                    return AuthTextField(
                      validator: (String? password) {
                        if (password == null || password.isEmpty) {
                          return 'enteroldPass'.tr;
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
                      obscureText: AuthController.i.oldObsecure,
                      suffixIcon: InkWell(
                          onTap: () {
                            AuthController.i.updateOldobsecurepassword(
                                !AuthController.i.oldObsecure);
                          },
                          child: AuthController.i.oldObsecure
                              ? const Icon(
                                  CupertinoIcons.eye_slash,
                                  color: ColorManager.kPrimaryDarkGreenColor,
                                )
                              : const Icon(CupertinoIcons.eye,
                                  color: ColorManager.kPrimaryDarkGreenColor)),
                      controller: AuthController.i.oldpasscontroller,
                      hintText: 'enteroldPass'.tr,
                    );
                  }),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Center(
                    child: Text(
                      'kindlyenteruniquePass'.tr,
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: ColorManager.kblackColor,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  GetBuilder<AuthController>(builder: (cont) {
                    return AuthTextField(
                      validator: (String? password) {
                        if (password == null || password.isEmpty) {
                          return 'EnterPassword'.tr;
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
                      controller: AuthController.i.changeNewpasscontroller,
                      hintText: 'newPass'.tr,
                    );
                  }),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  GetBuilder<AuthController>(builder: (cont) {
                    return AuthTextField(
                      validator: (String? password) {
                        if (password == null || password.isEmpty) {
                          return 'EnterPassword'.tr;
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
                      controller:
                          AuthController.i.changeConfirmnewpasscontroller,
                      hintText: 'confirmnewPass'.tr,
                    );
                  }),
                  SizedBox(
                    height: Get.height * 0.19,
                  ),
                  Center(
                    child: CustomButton(
                      buttonheight: Get.height * 0.06,
                      backgroundColor: Colors.orange,
                      buttonwidth: Get.width * 0.8,
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          _startLoading();
                          AuthRepository().changePassword().then((value) {
                            _stopLoading();
                            // Handle success
                          }).catchError((error) {
                            _stopLoading();
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("passresetfailed".tr)));
                          });
                        }
                      },
                      radius: 10,
                      mywidget: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.black,
                            )
                          : Text(
                              "submit".tr,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
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
                    height: Get.height * 0.01,
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
