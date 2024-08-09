import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/Login/authTextField.dart';
import 'package:longevity_hub/data/controller/auth_controller.dart';
import 'package:longevity_hub/repositories/auth_repo/auth_repo.dart';
import 'package:longevity_hub/screens/auth_screens/signup.dart';

import '../../components/custom_button.dart';
import '../../helpers/color_manager.dart';

class SignupMissingFieldScreen extends StatefulWidget {
  const SignupMissingFieldScreen(
      {super.key,
      required this.isPhoneNumberMissing,
      required this.isEmailMissing});
  final bool isPhoneNumberMissing;
  final bool isEmailMissing;

  @override
  State<SignupMissingFieldScreen> createState() =>
      _SignupMissingFieldScreenState();
}

class _SignupMissingFieldScreenState extends State<SignupMissingFieldScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.isPhoneNumberMissing)
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
                      return 'Enter phone'.tr;
                    }

                    RegExp regex = RegExp(r'^[0-9- ]+$');
                    if (!regex.hasMatch(value)) {
                      return 'Phone number should only contain digits';
                    }
                    return null;
                  },
                  hintText: 'Phone'.tr,
                ),
              ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            if (widget.isEmailMissing)
              Center(
                child: AuthTextField(
                  controller: AuthController.i.email,
                  validator: (String? email) {
                    if (email == null || email.isEmpty) {
                      return 'Enter Email'.tr;
                    }

                    RegExp emailRegex =
                        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z]+\.[a-zA-Z]');
                    if (!emailRegex.hasMatch(email)) {
                      return 'Invalid Email Format'.tr;
                    }
                    return null;
                  },
                  hintText: 'Email'.tr,
                ),
              ),
            SizedBox(
              height: Get.height * 0.06,
            ),
            Center(
              child: CustomButton(
                buttonheight: Get.height * 0.07,
                backgroundColor: ColorManager.kPrimaryColor,
                buttonwidth: Get.width * 0.85,
                onPress: () async {
                  if (_formKey.currentState!.validate()) {
                    await AuthRepository().signupApi();
                  }
                },
                mywidget: AuthController.i.isLoading == true
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        "Sign Up",
                        style: GoogleFonts.poppins(
                            color: ColorManager.kblackColor, fontSize: 20),
                      ),
                radius: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
