import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/longevity_store_screens/product_detail.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String discPrice;
  final String rating;
  final String subtitle;
  final String price;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.rating,
    required this.price,
    required this.subtitle,
    required this.discPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailScreen(
              imageUrl: imageUrl,
              rating: rating,
              title: title,
              subtitle: subtitle,
              price: price,
              discPrice: discPrice,
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.0),
          border: Border.all(
            color: const Color.fromARGB(255, 213, 212, 212),
            width: 1.0,
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: Get.height * .02),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorManager.kgreencart,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    height: Get.height * 0.13,
                    width: Get.width * 0.4,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: Get.height * 0.012,
                              left: Get.width * 0.02,
                              right: Get.width * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: ColorManager.kWhiteColor,
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                height: Get.height * 0.02,
                                width: Get.width * 0.1,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 12.0,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.01,
                                    ),
                                    Text(
                                      rating,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset(
                                AppImages.favouritecartIcon,
                                scale: 8,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: Get.width * 0.04, top: Get.height * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: ColorManager.kblackColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Text(
                        subtitle,
                        style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: ColorManager.kGreyColor,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Row(
                        children: [
                          Text(
                            price,
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: ColorManager.kblackColor,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: discPrice,
                                  style: GoogleFonts.poppins(
                                    fontSize: 8,
                                    color: ColorManager.kGreyColor,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.09,
                          ),
                          Image.asset(
                            AppImages.addtocart,
                            scale: 18,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: Get.height * 0.048,
              left: Get.width * 0.06,
              child: Image.asset(
                imageUrl,
                scale: 3.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
