// ignore_for_file: non_constant_identifier_names

import 'dart:math';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/community_fields/catogary_custom_container.dart';
import 'package:longevity_hub/components/custom_search_textfield/custom_search_textfield.dart';
import 'package:longevity_hub/data/controller/community_controller/community_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/community_screens/community_screen.dart';
import 'package:longevity_hub/screens/dashboard_screens/menu_drawer.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class MyCommunityCenter extends StatefulWidget {
  const MyCommunityCenter({super.key});

  @override
  State<MyCommunityCenter> createState() => _MyCommunityCenterState();
}

class _MyCommunityCenterState extends State<MyCommunityCenter> {
  final List<String> headings = [
    "🚀  Explore",
    "☝  My Community",
  ];

  int selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  int getCrossAxisCount() {
    int maxLength = 0;
    for (var heading in headings) {
      maxLength = max(maxLength, heading.length);
    }

    return min(maxLength > 10 ? 2 : 3, 4);
  }

  void _scrollToSection(int index) {
    setState(() {
      selectedIndex = index;
    });

    if (_scrollController.hasClients) {
      double offset = 0.0;
      for (int i = 0; i < index; i++) {
        offset += 200;
      }
      _scrollController.animateTo(offset,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  @override
  void initState() {
    super.initState();

    CommunityController.i.isSelectedCategories[0] = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      CommunityController.i.searchcont!.clear();
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: ColorManager.kBackColor,
        appBar: AppBar(
          backgroundColor: ColorManager.kBackColor,
          leading: InkWell(
            onTap: () {
              Get.to(() => const DrawerScreen());
            },
            child: Image.asset(
              AppImages.backArrow,
              scale: 10,
              color: ColorManager.kblackColor,
            ),
          ),
          title: Row(
            children: [
              SizedBox(
                width: Get.width * 0.06,
              ),
              Text(
                "community".tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: ColorManager.kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: Get.width * 0.02,
              ),
              Text(
                "center".tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: ColorManager.kblackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          centerTitle: true,
          actions: selectedIndex == 0
              ? [] // No actions shown if Explore is selected
              : <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: Get.width * 0.05),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => const CommunityScreen());
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            AppImages.addcommunity,
                            scale: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "connectwithcommunity".tr,
                    style: GoogleFonts.poppins(
                        color: ColorManager.kGreyColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
              child: Row(
                children: [
                  SizedBox(
                      width: Get.width * 0.75,
                      height: Get.height * 0.045,
                      child: SearchTextField(
                        controller: CommunityController.i.searchcont,
                      )),
                  SizedBox(
                    width: Get.width * 0.04,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      AppImages.filterImage,
                      scale: 9,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.016),
              child: GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: headings.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: getCrossAxisCount(),
                  childAspectRatio: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => _scrollToSection(index),
                    child: HighlightDefinition(index),
                  );
                },
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            // List of legs outside SingleChildScrollView
            Padding(
              padding: EdgeInsets.only(left: Get.width * 0.02),
              child: SizedBox(
                  height: Get.height * 0.06,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      width: Get.width * 0.03,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return CustomCategoryContainer(
                        text: "Legs",
                        isSelected:
                            CommunityController.i.isSelectedCategories[index],
                        onTap: () {
                          setState(() {
                            for (int i = 0;
                                i <
                                    CommunityController
                                        .i.isSelectedCategories.length;
                                i++) {
                              CommunityController.i.isSelectedCategories[i] =
                                  false;
                            }

                            CommunityController.i.isSelectedCategories[index] =
                                true;
                          });
                        },
                      );
                    },
                  )),
            ),
            // SingleChildScrollView wrapping CommunityStack and ExploreEvents
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.02),
                      child: SizedBox(
                          height: Get.height * 0.4,
                          child: ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                              width: Get.width * 0.03,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                              return CommunityStack(
                                  buttonText: selectedIndex == 0
                                      ? "joingroup".tr
                                      : "chat".tr);
                            },
                          )),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.02),
                      child: selectedIndex == 0
                          ? const ExploreEvents()
                          : const SizedBox.shrink(),
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

  Widget HighlightDefinition(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
        decoration: BoxDecoration(
          color: selectedIndex == index
              ? ColorManager.kPrimaryColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                headings[index],
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: selectedIndex == index ? Colors.white : Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w800),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExploreEvents extends StatelessWidget {
  const ExploreEvents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 1,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.1),
            spreadRadius: 0.4,
            blurRadius: 0.4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            Text(
              'upcomingevents'.tr,
              style: GoogleFonts.poppins(
                  color: ColorManager.kPrimaryColor,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4, // This is the defined item count for your ListView
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dealing with Anxiety',
                                style: GoogleFonts.mulish(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'with Darrell Steward',
                                style: GoogleFonts.mulish(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: ColorManager.kSonicSilverColor),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    'Today- 08:00 PM',
                                    style: GoogleFonts.mulish(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: ColorManager.kSonicSilverColor),
                                  ),
                                  const SizedBox(width: 16),
                                  const Icon(Icons.play_circle)
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          Image.asset(
                            AppImages.upcomingEventPerson,
                            height: 100,
                            width: 80,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      if (index != 3)
                        const DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 1.2,
                          dashLength: 4.0,
                          dashColor: Colors.black,
                          dashGapLength: 4.0,
                          dashRadius: 0.0,
                        ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CommunityStack extends StatelessWidget {
  final String buttonText;
  const CommunityStack({
    super.key,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: Get.height * 0.4,
          width: Get.width * 0.48,
        ),
        Positioned(
          top: 60,
          left: 0,
          right: 0,
          bottom: 2,
          child: Container(
            height: Get.height * 0.35,
            width: Get.width * 0.48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.1),
                  spreadRadius: 0.4,
                  blurRadius: 0.4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    thickness: Get.height * 0.002,
                    color: ColorManager.kblackColor.withOpacity(0.025),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    "My Family",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "5 ${"members".tr}",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.zero),
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text(
                          buttonText,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: ColorManager.kPrimaryColor,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          AppImages.nextArrow,
                          color: ColorManager.kPrimaryColor,
                          scale: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: Get.height * 0.015,
          left: Get.width * 0.05,
          child: Image.asset(
            AppImages.myCommunity,
            scale: 6,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
