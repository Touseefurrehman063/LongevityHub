import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/Dashboard/community_dashboard.dart';
import 'package:longevity_hub/components/Dashboard/dashboard_nutrition_rectangle.dart';
import 'package:longevity_hub/components/Dashboard/dashboard_rectangle.dart';
import 'package:longevity_hub/components/Dashboard/dashboard_square.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/repositories/subscription_repo/subscription_repo.dart';
import 'package:longevity_hub/screens/exercise_screens/exercise_screen.dart';
import 'package:longevity_hub/screens/gym_membership_screens/select_gym_screen.dart';
import 'package:longevity_hub/screens/health_az/wellness.dart';
import 'package:longevity_hub/screens/health_insights_screens/health_insights.dart';
import 'package:longevity_hub/screens/notification_screens/notification_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String uid = "";
  int _currentIndex = 0;
  getUid() async {
    uid = await LocalDb().getUserid() ?? "";
  }

  @override
  void initState() {
    super.initState();
    getUid();
  }

  @override
  Widget build(BuildContext context) {
    log(uid);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: Get.width * 0.2,
        leading: InkWell(
          onTap: () {
            if (ZoomDrawer.of(context)!.isOpen()) {
              ZoomDrawer.of(context)!.close();
            } else {
              ZoomDrawer.of(context)!.open();
            }
          },
          child: Container(
            alignment: Alignment.center, // use aligment
            color: ColorManager.kWhiteColor,
            child: Image.asset(
              AppImages.drawer,
              scale: 12,
              fit: BoxFit.contain,
              color: ColorManager.kblackColor,
            ),
          ),
        ),
        toolbarHeight: Get.height * 0.1,
        centerTitle: true,
        title: Image.asset(
          AppImages.dashboardlogo,
          height: Get.height * 0.07,
          width: Get.width * 0.45,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                  onTap: () {
                    Get.to(() => const NotificationScreen());
                  },
                  child: SvgPicture.asset(
                    "assets/images/Bell.svg",
                    height: Get.height * 0.035,
                    // color: ColorManager.kblackColor,
                  )),
              SizedBox(
                width: Get.width * 0.05,
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: Get.height * 0.25,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                viewportFraction: 0.9,
                enableInfiniteScroll: true,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: [
                Image.asset(
                  AppImages.main,
                  // height: Get.height * 0.9,
                ),
                Image.asset(AppImages.main1),
                Image.asset(
                  AppImages.main,
                  // height: Get.height * 0.9,
                ),
                Image.asset(AppImages.main1),
              ].map((image) {
                return Stack(
                  children: [
                    image,
                    Positioned(
                      right: Get.width * 0.08,
                      top: Get.height * 0.08,
                      child: Column(
                        children: [
                          Text(
                            'fityoungmandoing'.tr,
                            style: GoogleFonts.poppins(
                              color: ColorManager.kWhiteColor,
                              fontWeight: FontWeight.bold,
                              height: 1,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.009,
                          ),
                          CustomButton(
                            buttonheight: Get.height * 0.036,
                            backgroundColor: ColorManager.kYellowGolden,
                            buttonwidth: Get.width * 0.25,
                            onPress: () {},
                            radius: 5,
                            mywidget: Text(
                              "startexercise".tr,
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: ColorManager.kWhiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            SizedBox(
              height: Get.height * 0.005,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 2.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? ColorManager.kGreyColor
                        : const Color.fromARGB(255, 227, 226, 226),
                  ),
                );
              }),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: Text(
                "whatareyoulookingfor".tr,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.kblackColor),
              ),
            ),
            SizedBox(
              height: Get.height * 0.015,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Get.width * 0.438,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                await SubscriptionRepo.getPackageExpiryDate();
                                await SubscriptionRepo.verifyModuleForUser("1",
                                    () {
                                  Get.to(() => const WellnessScreen());
                                });
                              },
                              child: DashboardRectangle(
                                headingText: "wellness".tr,
                                subheadingText: "improvelife".tr,
                                containerColor: ColorManager.kLightGreen,
                                headingColor: ColorManager.kPrimaryGreenColor,
                                containerimage: AppImages.wellness2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.016,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                await SubscriptionRepo.getPackageExpiryDate();
                                await SubscriptionRepo.verifyModuleForUser("2",
                                    () {
                                  Get.to(() => const SelectGymScreen());
                                });
                                // Get.to(() => const ());
                              },
                              child: DashboardRectangle(
                                headingText: "gym".tr,
                                subheadingText: "choosegym".tr,
                                containerColor: ColorManager.korangeContainer,
                                headingColor: ColorManager.kPrimaryColor,
                                containerimage: AppImages.gym2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // 1 Square
                  InkWell(
                    onTap: () async {
                      // await SubscriptionRepo.getPackageExpiryDate();
                      // await SubscriptionRepo.verifyModuleForUser("3", () {
                      //   Get.to(() => const ShopOnlineScreen());
                      // });
                      Get.to(() => const ExerciseScreen());
                    },
                    child: DashboardSquare(
                      containerColor: ColorManager.kLightBlueContainer,
                      headingText: "shopOnline".tr,
                      subheadingText: "gymandmore".tr,
                      image: AppImages.shopOnline,
                      headingTextColor: ColorManager.kShopBlue,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.015,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await SubscriptionRepo.getPackageExpiryDate();
                      await SubscriptionRepo.verifyModuleForUser("4", () {
                        Get.to(() => const HealthInsightsScreen());
                      });
                      // Get.to(() => const HealthInsightsScreen());
                    },
                    child: DashboardSquare(
                      containerColor: ColorManager.kPinkHealth,
                      headingText: "healthInsights".tr,
                      subheadingText: "trackheart".tr,
                      image: AppImages.health,
                      headingTextColor: ColorManager.kHealthRed,
                    ),
                  ),
                  GestureDetector(
                      onTap: () async {
                        // await SubscriptionRepo.getPackageExpiryDate();
                        // await SubscriptionRepo.verifyModuleForUser("5", () {
                        //   Get.to(() => const CommunityScreen());
                        // });
                        Get.to(() => const ExerciseScreen());
                        // Get.to(() => const CommunityScreen());
                      },
                      child: const CommunityDashboard()),
                ],
              ),
            ),
            // SizedBox(
            //   height: Get.height * 0.015,
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: Get.width * 0.05),
            //   child: SizedBox(
            //       height: Get.height * 0.2,
            //       child: ListView.separated(
            //         separatorBuilder: (context, index) => SizedBox(
            //           width: Get.width * 0.03,
            //         ),
            //         scrollDirection: Axis.horizontal,
            //         itemCount: 10,
            //         itemBuilder: (BuildContext context, int index) {
            //           return DashboardBeautiyCard(
            //               containerColor: ColorManager.kBeautyPink,
            //               headingText: "Beauty",
            //               subheadingText: "Looking good, feel good",
            //               image: AppImages.beauty);
            //         },
            //       )),
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //       horizontal: Get.width * 0.05, vertical: Get.height * 0.015),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         "Category",
            //         style: GoogleFonts.poppins(
            //           fontSize: 15,
            //           fontWeight: FontWeight.w700,
            //           color: ColorManager.kblackColor,
            //         ),
            //       ),
            //       Text(
            //         "See all",
            //         style: GoogleFonts.poppins(
            //           fontSize: 11,
            //           color: ColorManager.kblackColor,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: Get.width * 0.05),
            //   child: SizedBox(
            //       height: Get.height * 0.14,
            //       child: ListView.separated(
            //         separatorBuilder: (context, index) => SizedBox(
            //           width: Get.width * 0.03,
            //         ),
            //         scrollDirection: Axis.horizontal,
            //         itemCount: 10,
            //         itemBuilder: (BuildContext context, int index) {
            //           return DashboardCircularCategories(
            //               text: "Yoga", image: AppImages.yoga);
            //         },
            //       )),
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //       horizontal: Get.width * 0.05, vertical: Get.height * 0.015),
            //   child: Text(
            //     "Just for you",
            //     style: GoogleFonts.poppins(
            //       fontSize: 15,
            //       fontWeight: FontWeight.w700,
            //       color: ColorManager.kblackColor,
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: Get.width * 0.05),
            //   child: SizedBox(
            //       height: Get.height * 0.3,
            //       child: ListView.separated(
            //         separatorBuilder: (context, index) => SizedBox(
            //           width: Get.width * 0.03,
            //         ),
            //         scrollDirection: Axis.horizontal,
            //         itemCount: 10,
            //         itemBuilder: (BuildContext context, int index) {
            //           return DashboardGymVideo(
            //             text: "Be Free",
            //             time: "20 min",
            //             image: AppImages.beFree1,
            //           );
            //         },
            //       )),
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //       horizontal: Get.width * 0.05, vertical: Get.height * 0.015),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         "Meal Plans",
            //         style: GoogleFonts.poppins(
            //           fontSize: 15,
            //           fontWeight: FontWeight.w700,
            //           color: ColorManager.kblackColor,
            //         ),
            //       ),
            //       Text(
            //         "See all",
            //         style: GoogleFonts.poppins(
            //           fontSize: 11,
            //           color: ColorManager.kblackColor,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            //   child: Container(
            //     width: double.infinity,
            //     decoration:
            //         BoxDecoration(borderRadius: BorderRadius.circular(20)),
            //     child: Image.asset(
            //       AppImages.mealPlan,
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //       horizontal: Get.width * 0.05, vertical: Get.height * 0.015),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         "Greek salad with lettuce, green onion, ",
            //         style: GoogleFonts.poppins(
            //           fontSize: 12,
            //           fontWeight: FontWeight.w600,
            //           color: ColorManager.kblackColor,
            //         ),
            //         maxLines: 1,
            //         overflow: TextOverflow.ellipsis,
            //       ),
            //       Text(
            //         "150 kcal",
            //         style: GoogleFonts.poppins(
            //           fontSize: 11,
            //           color: ColorManager.kblackColor,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: Get.height * 0.015,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    // await SubscriptionRepo.getPackageExpiryDate();
                    // await SubscriptionRepo.verifyModuleForUser("6", () {
                    //   Get.to(() => const NutritionScreen());
                    // });
                    Get.to(() => const ExerciseScreen());
                  },
                  child: DashboardNutritionRectangle(
                    headingText: "nutrition".tr,
                    subheadingText: "balancediet".tr,
                    containerColor: ColorManager.kYellowContainer,
                    headingColor: ColorManager.kyellowgold,
                    containerimage: AppImages.nutritionpic,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.015,
            ),
            // const DashboardSupport(),
            SizedBox(
              height: Get.height * 0.01,
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: ColorManager.kWhiteColor,
      //   onPressed: () {
      //     // Navigator.of(context).push(CustomPageRoute(
      //     //     child: const ChatScreen(), direction: AxisDirection.up));
      //     Get.to(() => const ChatScreen());
      //   },
      //   child: Image.asset(AppImages.chatbot),
      // ),
    );
  }
}
