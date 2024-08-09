// ignore_for_file: unused_field, depend_on_referenced_packages, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/auth_screens/login.dart';
import 'package:longevity_hub/screens/dashboard_screens/menu_drawer.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:dots_indicator/dots_indicator.dart';

class IntroductionScreens extends StatefulWidget {
  const IntroductionScreens({Key? key}) : super(key: key);
  @override
  _IntroductionScreensState createState() => _IntroductionScreensState();
}

class _IntroductionScreensState extends State<IntroductionScreens> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  final int _totalPages = 5;
  // bool showTransformation = false;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    saveFirstTime();
  }

  saveFirstTime() async {
    await LocalDb().saveIsFirstTime(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                _buildIntroductionScreen(
                  imagePath: "assets/images/1.png",
                  showBackButton: false,
                  showSkipButton: false,
                ),
                _buildIntroductionScreen(
                  imagePath: "assets/images/2.png",
                  showBackButton: false,
                  showSkipButton: false,
                ),
                _buildIntroductionScreen(
                  imagePath: "assets/images/3.png",
                  showBackButton: false,
                  showSkipButton: false,
                ),
                _buildIntroductionScreen(
                  imagePath: "assets/images/4.png",
                  showBackButton: false,
                  showSkipButton: false,
                ),
                _buildIntroductionScreen(
                  imagePath: "assets/images/5.png",
                  showBackButton: false,
                  showSkipButton: false,
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.09),
                child: Column(
                  children: [
                    _currentPage == 0
                        ? Row(
                            children: [
                              Text(
                                'WelcomeTo'.tr,
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: ColorManager.kWhiteColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Longevity'.tr,
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff99E92C),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Hub'.tr,
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  color: const Color(0xff99E92C),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        : _currentPage == 1
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'WhereverYouAre'.tr,
                                        style: GoogleFonts.poppins(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: ColorManager.kWhiteColor,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        'Health'.tr,
                                        style: GoogleFonts.poppins(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xff99E92C),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        'Is'.tr,
                                        style: GoogleFonts.poppins(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: ColorManager.kWhiteColor,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'NumberOne'.tr,
                                    style: GoogleFonts.poppins(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: ColorManager.kWhiteColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                            : _currentPage == 2
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: Get.height * 0.006),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Workout'.tr,
                                          style: GoogleFonts.poppins(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff99E92C),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          'Categories'.tr,
                                          style: GoogleFonts.poppins(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: ColorManager.kWhiteColor,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  )
                                : _currentPage == 3
                                    ? Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'BeginYour'.tr,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.end,
                                              ),
                                              Text(
                                                'Health'.tr,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      const Color(0xff99E92C),
                                                ),
                                                textAlign: TextAlign.end,
                                              ),
                                              // GestureDetector(
                                              //   onTap: () {
                                              //     setState(() {
                                              //       showTransformation =
                                              //           !showTransformation;
                                              //     });
                                              //   },
                                              //   child: const Icon(
                                              //       Icons.more_vert),
                                              // ),
                                            ],
                                          ),
                                          // if (showTransformation)
                                          Text(
                                            'Transformation'.tr,
                                            style: GoogleFonts.poppins(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: ColorManager.kWhiteColor,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      )
                                    : Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: Get.height * 0.02),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'NewEra'.tr,
                                              style: GoogleFonts.poppins(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xff99E92C),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              'of'.tr,
                                              style: GoogleFonts.poppins(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: ColorManager.kWhiteColor,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              'Wellbeing'.tr,
                                              style: GoogleFonts.poppins(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xff99E92C),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    _currentPage == 0
                        ? Text(
                            'WelcomeScreen1text'.tr,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: ColorManager.kWhiteColor,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : _currentPage == 1
                            ? Text(
                                'WelcomeScreen2text'.tr,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorManager.kWhiteColor,
                                ),
                                textAlign: TextAlign.center,
                              )
                            : _currentPage == 2
                                ? Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 28.0),
                                    child: Text(
                                      'WelcomeScreen3text'.tr,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: ColorManager.kWhiteColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : _currentPage == 3
                                    ? Text(
                                        'WelcomeScreen4text'.tr,
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: ColorManager.kWhiteColor,
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                                    : Text(
                                        'WelcomeScreen5text'.tr,
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: ColorManager.kWhiteColor,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    DotsIndicator(
                      dotsCount: 5,
                      position: _currentPage.toDouble(),
                      decorator: const DotsDecorator(
                        activeColor: Colors.white,
                        spacing: EdgeInsets.all(10.0),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    CustomButton(
                      buttonheight: Get.height * 0.07,
                      backgroundColor: ColorManager.kPrimaryColor,
                      buttonwidth: Get.width * 0.8,
                      onPress: () async {
                        bool isLogin =
                            await LocalDb().getLoginStatus() ?? false;
                        if (isLogin == true) {
                          Get.offAll(() => const DrawerScreen());
                        } else {
                          Get.offAll(() => const LoginScreen());
                        }
                      },
                      radius: 10,
                      mywidget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "GetStarted".tr,
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          const Icon(Icons.arrow_forward_ios_sharp, size: 20)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       'Already have an account?',
                    //       style: GoogleFonts.poppins(
                    //         fontSize: 12,
                    //         fontWeight: FontWeight.w400,
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //     InkWell(
                    //       onTap: () {
                    //         Get.offAll(() => const LoginScreen());
                    //       },
                    //       child: Text(
                    //         ' Sign In',
                    //         style: GoogleFonts.poppins(
                    //           fontSize: 12,
                    //           fontWeight: FontWeight.bold,
                    //           color: ColorManager.kPrimaryGreenColor,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroductionScreen({
    required String imagePath,
    required bool showBackButton,
    required bool showSkipButton,
  }) {
    return Stack(
      children: [
        _buildBackgroundImage(imagePath),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: Get.height * 0.02),
              child: Row(
                children: [
                  if (showBackButton)
                    GestureDetector(
                      onTap: () {
                        if (_currentPage > 0) {
                          _pageController.animateToPage(
                            _currentPage - 1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Image.asset(
                        AppImages.backArrow,
                        color: ColorManager.kWhiteColor,
                        scale: 12,
                      ),
                    ),
                  const Spacer(),
                  if (showSkipButton)
                    InkWell(
                      onTap: () async {
                        bool isLogin =
                            await LocalDb().getLoginStatus() ?? false;
                        if (isLogin == true) {
                          Get.offAll(() => const DrawerScreen());
                        } else {
                          Get.offAll(() => const LoginScreen());
                        }
                      },
                      child: SizedBox(
                        width: Get.width * 0.16,
                        child: Row(
                          children: [
                            Text(
                              'skip'.tr,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: ColorManager.kPrimaryGreenColor,
                              ),
                            ),
                            Image.asset(
                              AppImages.skipArrow,
                              color: ColorManager.kPrimaryGreenColor,
                              scale: 12,
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
      ],
    );
  }

  Widget _buildBackgroundImage(String imagePath) {
    return SizedBox(
      width: double.infinity,
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
