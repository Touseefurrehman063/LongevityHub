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

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    AuthController.i.newpasscontroller.clear();
    AuthController.i.forgetemailController.clear();
    AuthController.i.confirmnewpasscontroller.clear();
    super.dispose();
  }

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
                    height: Get.height * 0.12,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/images/a.png",
                      height: Get.height * 0.14,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.14,
                  ),
                  Center(
                    child: Text(
                      'createnewpass'.tr,
                      style: GoogleFonts.poppins(
                          fontSize: 25,
                          color: ColorManager.kPrimaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
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
                      controller: AuthController.i.newpasscontroller,
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
                      controller: AuthController.i.confirmnewpasscontroller,
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
                          AuthRepository().resetForgetPassword().then((value) {
                            _stopLoading();
                            // Handle success
                          }).catchError((error) {
                            _stopLoading();
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("passresetFailed".tr)));
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
                    height: Get.height * 0.06,
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
