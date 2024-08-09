import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_appbar.dart';
import 'package:longevity_hub/components/wellbeing/health_a_z_container.dart';
import 'package:longevity_hub/components/wellbeing/wellbeing_category_container.dart';
import 'package:longevity_hub/data/controller/health_a_z_controller/health_az_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/health_az/health_az.dart';
import 'package:longevity_hub/screens/health_az/live_well_detail.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:shimmer/shimmer.dart';

class WellnessScreen extends StatefulWidget {
  const WellnessScreen({super.key});

  @override
  State<WellnessScreen> createState() => _WellnessScreenState();
}

class _WellnessScreenState extends State<WellnessScreen> {
  @override
  void initState() {
    fetchLiveWell();
    super.initState();
  }

  fetchLiveWell() async {
    await HealthController.i.fetchLiveWellCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerText: "discoverwellness".tr,
        leadingOnPressed: () {
          Get.back();
        },
        backgroundcolor: const Color(0xfffaf8f1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: const Color(0xfffaf8f1),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.09),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    SizedBox(
                      width: Get.width * 0.5,
                      child: Image.asset('assets/images/wellnesspersons.png'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.04,
                          vertical: Get.height * 0.02),
                      child: Center(
                        child: Text(
                          "becomeyourbestself".tr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 9,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.04),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => const HealthAZScreen());
                      },
                      child: HealthAZContainer(
                        headingtextColor: ColorManager.kblackColor,
                        imagePath: AppImages.healthazperson,
                        heading: "healthaz".tr,
                        text: "becomeyourlifestyle".tr,
                        textSize: 8,
                        color: const Color(0xff99e92c),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.05),
                    child: Text(
                      "catagories".tr,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: ColorManager.kblackColor,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.005,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Get.width * 0.05, right: Get.width * 0.05),
                    child: const Divider(
                      color: ColorManager.kblackColor,
                      thickness: 1,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.005,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 17.0),
                    child: GetBuilder<HealthController>(builder: (cont) {
                      if (cont.mainEntityPageList.isEmpty) {
                        return _buildShimmer();
                      } else {
                        final flattenedList = cont.mainEntityPageList
                            .expand((mainEntity) =>
                                mainEntity.mainEntityOfPage ?? [])
                            .toList();

                        // Exclude the item at index 0
                        final filteredList = List.from(flattenedList);
                        if (filteredList.isNotEmpty) {
                          filteredList.removeAt(1);
                        }

                        return GridView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: filteredList.length, // Update item count
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: Get.width * 0.0008,
                            mainAxisSpacing: Get.height * 0.02,
                            childAspectRatio: 0.7,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return CategoryContainer(
                              image: AppImages.category,
                              heading: filteredList[index].headline!,
                              text1: filteredList[index].text!,
                              iconImage: AppImages.viewMoreIcon,
                              text2: "viewMore".tr,
                              ontap: () {
                                Get.to(() => LiveWellDetail(
                                    headingname: filteredList[index].headline!,
                                    url: filteredList[index].url.toString()));
                              },
                            );
                          },
                        );
                      }
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: 6,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: Get.width * 0.0008,
        mainAxisSpacing: Get.height * 0.02,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        );
      },
    );
  }
}
