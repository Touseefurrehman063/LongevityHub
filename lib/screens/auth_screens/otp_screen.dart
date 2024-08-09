import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/data/controller/Forget_password_controller.dart';
import 'package:longevity_hub/data/controller/auth_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/repositories/auth_repo/auth_repo.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isOtpLoading = false;

  String? validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter OTP';
    }
    if (value.length != 4) {
      return 'OTP must be 4 characters long';
    }
    return null;
  }

  final forgotpasswordcontroller =
      Get.put<ForgotPasswordController>(ForgotPasswordController());

  @override
  void initState() {
    ForgotPasswordController.i.timer = 300.obs;
    ForgotPasswordController.i.startTimer(context);
    super.initState();
  }

  @override
  void dispose() {
    ForgotPasswordController.i.resetTimerAndUpdate();
    ForgotPasswordController.i.onClose();
    AuthController.i.obsecure = true;
    AuthController.i.obsecure1 = true;
    super.dispose();
  }

  void _startOtpVerification() {
    setState(() {
      isOtpLoading = true;
    });
  }

  void _completeOtpVerification() {
    setState(() {
      isOtpLoading = false;
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
                  vertical: Get.height * 0.01, horizontal: Get.width * 0.09),
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
                  SizedBox(height: Get.height * 0.10),
                  Center(
                    child: Image.asset(
                      "assets/images/a.png",
                      height: Get.height * 0.14,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.1),
                  Center(
                    child: Text(
                      'enterotp'.tr,
                      style: GoogleFonts.poppins(
                          fontSize: 25,
                          color: ColorManager.kPrimaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.03),
                  Center(
                    child: Text(
                      'thankyou'.tr,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: ColorManager.kblackColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: Get.width * 0.7,
                      child: Text(
                        'otpsendtoyouremail'.tr,
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: ColorManager.kblackColor,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      AuthController.i.forgetemailController.text,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: ColorManager.kblackColor,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  OtpTextField(
                    numberOfFields: 4,
                    textStyle: const TextStyle(color: ColorManager.kblackColor),
                    fieldWidth: Get.width * 0.13,
                    borderColor: ColorManager.kblackColor,
                    keyboardType: TextInputType.number,
                    margin: const EdgeInsets.all(9),
                    enabledBorderColor: const Color.fromARGB(255, 76, 73, 73),
                    focusedBorderColor: ColorManager.kPrimaryColor,
                    showFieldAsBox: true,
                    borderWidth: 1.0,
                    borderRadius: BorderRadius.circular(8.0),
                    onCodeChanged: (String code) {},
                    onSubmit: (String verificationCode) {
                      String? validationResult = validateOtp(verificationCode);
                      if (validationResult != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(validationResult)));
                        return;
                      }

                      // Validation passed, proceed with your logic
                      AuthController.i.updatecode(verificationCode);
                    },
                  ),
                  SizedBox(height: Get.height * 0.038),
                  GetBuilder<ForgotPasswordController>(builder: (controller) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${'expiresin'.tr} ${controller.timer ~/ 60}:${controller.timer % 60}s",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: ColorManager.kblackColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              AuthRepository().resendforgetemailverification();
                            },
                            child: Text(
                              "resend".tr,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: ColorManager.kPrimaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  SizedBox(height: Get.height * 0.13),
                  Center(
                    child: CustomButton(
                      buttonheight: Get.height * 0.06,
                      backgroundColor: Colors.orange,
                      buttonwidth: Get.width * 0.8,
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          _startOtpVerification();
                          AuthRepository().otpVerification().then((value) {
                            _completeOtpVerification();
                          }).catchError((error) {
                            _completeOtpVerification();
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("otpfailed".tr)));
                          });
                        }
                      },
                      radius: 10,
                      mywidget: isOtpLoading
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
                  SizedBox(height: Get.height * 0.06),
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
                  SizedBox(height: Get.height * 0.01),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
