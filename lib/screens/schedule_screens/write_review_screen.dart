import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/components/custom_review_text_field/custom_review_text_field.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class WriteReviewsScreen extends StatefulWidget {
  const WriteReviewsScreen({Key? key}) : super(key: key);

  @override
  State<WriteReviewsScreen> createState() => _WriteReviewsScreenState();
}

class _WriteReviewsScreenState extends State<WriteReviewsScreen> {
  double _value = 1.5;
  late final double _maxRating;
  final FocusNode _focusNode1 = FocusNode();
  TextEditingController reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _maxRating = 5.0; // Set the maximum rating value in initState
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              AppImages.backArrow,
              scale: 10,
              color: ColorManager.kblackColor,
            ),
          ),
          title: Text(
            "Write a Review",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: ColorManager.kblackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                _value += details.primaryDelta! /
                    (MediaQuery.of(context).size.width / _maxRating);
                if (_value < 0) {
                  _value = 0;
                } else if (_value > _maxRating) {
                  _value = _maxRating;
                }
              });
            },
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  left: (Get.width * 0.07) +
                      ((Get.width * 0.75 - Get.width * 0.05) *
                          _value /
                          _maxRating),
                  top: Get.height * 0.02,
                  child: Text(
                    _value.toStringAsFixed(1),
                    style: GoogleFonts.poppins(
                      color: ColorManager.kblackColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.05,
                      vertical: Get.height * 0.05),
                  child: Column(
                    children: [
                      RatingProgressIndicator2(
                        value: _value,
                        maxRating: _maxRating,
                      ),
                      SizedBox(height: Get.height * 0.07),
                      CustomReviewField(
                        controller: reviewController,
                        hintText: "Review (Optional)",
                        focusNode: _focusNode1,
                        maxLines: 12,
                      ),
                      SizedBox(height: Get.height * 0.07),
                      Center(
                        child: CustomButton(
                          buttonheight: Get.height * 0.07,
                          backgroundColor: ColorManager.kPrimaryColor,
                          buttonwidth: Get.width * 0.75,
                          onPress: () {
                            // Navigate to another screen or perform action
                            Get.back();
                          },
                          mywidget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Send",
                                style: GoogleFonts.poppins(
                                  color: ColorManager.kblackColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          radius: 10,
                        ),
                      ),
                      SizedBox(height: Get.height * 0.05),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RatingProgressIndicator2 extends StatelessWidget {
  const RatingProgressIndicator2({
    Key? key,
    required this.value,
    required this.maxRating,
  }) : super(key: key);

  final double value;
  final double maxRating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Stack(
            children: [
              Text(
                ' ${value.toStringAsFixed(1)}',
                style: GoogleFonts.poppins(
                  color: ColorManager.kblackColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              LinearProgressIndicator(
                value: value / maxRating, // Normalize value to range [0, 1]
                minHeight: 25,
                backgroundColor: Colors.black,
                borderRadius: BorderRadius.circular(16),
                valueColor: AlwaysStoppedAnimation(
                  Color.lerp(
                    ColorManager.kPrimaryColor,
                    ColorManager.kPrimaryColor,
                    value / maxRating,
                  ),
                ), // Interpolate color based on value
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Get.width * 0.04,
                  top: Get.height * 0.005,
                ),
                child: Text(
                  'Rating',
                  style: GoogleFonts.poppins(
                    color: ColorManager.kblackColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
