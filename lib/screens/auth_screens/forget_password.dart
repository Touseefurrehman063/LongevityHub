import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/Login/authTextField.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/data/controller/auth_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/repositories/auth_repo/auth_repo.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:email_otp/email_otp.dart';

// ignore: must_be_immutable
class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});

  final _formKey = GlobalKey<FormState>();
  FocusNode emailfouseNode = FocusNode();
  EmailOTP myauth = EmailOTP();

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
                  Text(
                    'ForgotPassword'.tr,
                    style: GoogleFonts.poppins(
                        fontSize: 25,
                        color: ColorManager.kPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: Get.height * 0.005,
                  ),
                  SizedBox(
                    width: Get.width * 0.7,
                    child: Text(
                      'ForgetPasswordScreenText'.tr,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: ColorManager.kblackColor,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  AuthTextField(
                    focusNode: emailfouseNode,
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return 'pleaseenteremail'.tr;
                      }
                      return null;
                    },
                    controller: AuthController.i.forgetemailController,
                    hintText: 'emailaddress'.tr,
                  ),
                  SizedBox(
                    height: Get.height * 0.09,
                  ),
                  Center(
                    child: GetBuilder<AuthController>(
                      builder: (controller) {
                        return CustomButton(
                          buttonheight: Get.height * 0.06,
                          backgroundColor: Colors.orange,
                          buttonwidth: Get.width * 0.7,
                          onPress: () async {
                            if (_formKey.currentState!.validate()) {
                              await AuthRepository().forgetemailverification();
                            }
                          },
                          radius: 10,
                          mywidget: controller.isforgetLoading
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
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Center(
                    child: CustomButton(
                      borderColor: Colors.black,
                      buttonheight: Get.height * 0.06,
                      backgroundColor: Colors.transparent,
                      buttonwidth: Get.width * 0.7,
                      onPress: () {
                        AuthController.i.forgetemailController.clear();
                        Get.back();
                      },
                      radius: 10,
                      mywidget: Text(
                        "cancel".tr,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.12,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
