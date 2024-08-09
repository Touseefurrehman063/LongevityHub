import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:longevity_hub/components/longevity_store_fields/custom__catogary_container.dart';
import 'package:longevity_hub/components/longevity_store_fields/custom_cart_container.dart';
import 'package:longevity_hub/data/controller/longevity_store_controller/longevity_store_cont.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/dashboard_screens/menu_drawer.dart';
import 'package:longevity_hub/screens/longevity_store_screens/add_to_cart_screen.dart';
import 'package:longevity_hub/screens/longevity_store_screens/favourite_items.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class ShopOnlineScreen extends StatefulWidget {
  const ShopOnlineScreen({Key? key}) : super(key: key);

  @override
  State<ShopOnlineScreen> createState() => _ShopOnlineScreenState();
}

class _ShopOnlineScreenState extends State<ShopOnlineScreen> {
  int _currentIndex = 0;
  TextEditingController searchcont = TextEditingController();
  bool showSearchField = false;

  @override
  void initState() {
    LongevityStoreController.i.isSelectedCategories[0] = true;
    searchcont.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
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
          title: Image.asset(
            AppImages.dashboardlogo,
            scale: 9,
          ),
          centerTitle: false,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: Get.width * 0.06),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        showSearchField = !showSearchField;
                      });
                    },
                    child: Image.asset(
                      AppImages.searchIcon,
                      scale: 18,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.025,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const FavouriteItemsScreen());
                    },
                    child: Image.asset(
                      AppImages.favIcon,
                      scale: 18,
                      // color: ColorManager.kblackColor,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.025,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const AddToCartScreen());
                    },
                    child: Image.asset(
                      AppImages.cartIcon,
                      scale: 18,
                      // color: ColorManager.kblackColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                AppImages.newBackground,
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showSearchField)
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                      child: searchTextField(),
                    ),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: Get.height * 0.2,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      viewportFraction: 0.85,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    items: [
                      Image.asset(AppImages.mainshop),
                      Image.asset(AppImages.mainshop),
                      Image.asset(AppImages.mainshop),
                      Image.asset(AppImages.mainshop),
                    ]..toList(),
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
                              ? ColorManager.kblackColor
                              : const Color.fromARGB(255, 227, 226, 226),
                        ),
                      );
                    }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.05),
                    child: SizedBox(
                        height: Get.height * 0.08,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(
                            width: Get.width * 0.03,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return CustomCategoryCont(
                              text: "Fitness Gloves",
                              isSelected: LongevityStoreController
                                  .i.isSelectedCategories[index],
                              onTap: () {
                                setState(() {
                                  for (int i = 0;
                                      i <
                                          LongevityStoreController
                                              .i.isSelectedCategories.length;
                                      i++) {
                                    LongevityStoreController
                                        .i.isSelectedCategories[i] = false;
                                  }

                                  LongevityStoreController
                                      .i.isSelectedCategories[index] = true;
                                });
                              },
                            );
                          },
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 17.0, left: 17),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 10,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: Get.width * 0.03,
                        mainAxisSpacing: Get.height * 0.015,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return ProductCard(
                          imageUrl: AppImages.items,
                          rating: "4.6",
                          title: "Gloves",
                          subtitle: "Weight Lifting",
                          price: "AED. 20",
                          discPrice: "AED. 50",
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField searchTextField() {
    return TextFormField(
      style: const TextStyle(color: ColorManager.kblackColor),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          color: ColorManager.kGreyColor,
        ),
        hintText: 'searchhere'.tr,
        filled: true,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorManager.kblackColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: ColorManager.kblackColor,
          ),
        ),
        fillColor: Colors.transparent,
        prefixIcon: const Icon(
          Icons.search,
          color: ColorManager.kGreyColor,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.kblackColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
        ),
      ),
      controller: searchcont,
      onChanged: (val) {
        // Handle search functionality here
      },
    );
  }
}
