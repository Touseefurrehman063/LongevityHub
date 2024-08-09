// ignore_for_file: unused_field, must_be_immutable, avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:longevity_hub/components/custom_appbar.dart';
import 'package:longevity_hub/data/controller/health_a_z_controller/health_az_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/models/health_model/health_model.dart';
import 'package:longevity_hub/repositories/health_a_z_repo/health_a_z_repo.dart';
import 'package:longevity_hub/screens/health_az/health_detail.dart';

class HealthAZScreen extends StatefulWidget {
  const HealthAZScreen({Key? key}) : super(key: key);

  @override
  State<HealthAZScreen> createState() => _HealthAZScreenState();
}

class _HealthAZScreenState extends State<HealthAZScreen> {
  final HealthAtoZRepository _repository = HealthAtoZRepository();
  final ScrollController _scrollController = ScrollController();
  List<String> categories = List.generate(
      26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));
  String currentCategory = 'a';
  Map<String, List<HealthAzModel>> categoryData = {};
  Map<String, List<HealthAzModel>> filteredCategoryData = {};
  Map<String, bool> loadingCategory = {};
  Timer? _debounce;
  bool _isFetching = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    for (int i = 0; i < 5; i++) {
      final category = categories[i].toLowerCase();
      loadingCategory[category] = true;
      await fetchAndSetData(category);
    }
  }

  Future<void> fetchAndSetData(String category) async {
    final lowerCategory = category.toLowerCase();
    if (!categoryData.containsKey(lowerCategory)) {
      setState(() {
        categoryData[lowerCategory] = [];
        filteredCategoryData[lowerCategory] = [];
      });
      try {
        await HealthController.i.fetchSignificantList(lowerCategory);
        final fetchedData = HealthController.i.significantList;
        setState(() {
          categoryData[lowerCategory] = fetchedData;
          filteredCategoryData[lowerCategory] = fetchedData;
          loadingCategory[lowerCategory] = false;
        });
      } catch (e) {
        print('Error fetching data for category $lowerCategory: $e');
        setState(() {
          loadingCategory[lowerCategory] = false;
        });
      }
    }
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 200 && !_isFetching) {
      final nextIndex = categories.indexOf(currentCategory.toUpperCase()) + 1;
      if (nextIndex < categories.length) {
        final nextCategory = categories[nextIndex];
        currentCategory = nextCategory.toLowerCase();
        if (!loadingCategory.containsKey(currentCategory)) {
          setState(() {
            loadingCategory[currentCategory] = true;
            _isFetching = true;
          });
          fetchAndSetData(currentCategory).then((_) {
            setState(() {
              _isFetching = false;
            });
          });
        }
      }
    }
  }

  void _filterData(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      final lowerCaseQuery = query.toLowerCase();

      setState(() {
        filteredCategoryData = categoryData.map((key, value) {
          final filteredDiseases = value
              .where((element) =>
                  element.name.toLowerCase().contains(lowerCaseQuery))
              .toList();
          return MapEntry(key, filteredDiseases);
        });

        filteredCategoryData.removeWhere((key, value) => value.isEmpty);

        if (filteredCategoryData.isEmpty) {
          currentCategory = '';
        }
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerText: "healthaz".tr,
        leadingOnPressed: () {
          Get.back();
        },
        backgroundcolor: const Color(0xfffaf8f1),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
              color: const Color(0xfffaf8f1),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: Get.height * 0.03),
                    HealthTextField(
                      hintText: "search".tr,
                      onchanged: (query) => _filterData(query),
                    ),
                    SizedBox(height: Get.height * 0.04),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final lowerCategory = category.toLowerCase();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              category,
                              style: GoogleFonts.raleway(
                                textStyle: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: ColorManager.kblackColor,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          loadingCategory[lowerCategory] == true
                              ? Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: 5, // Number of shimmer items
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Container(
                                          color: Colors.white,
                                          height: 20,
                                          width: double.infinity,
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: filteredCategoryData[lowerCategory]
                                          ?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    final healthModel =
                                        filteredCategoryData[lowerCategory]
                                            ?[index];
                                    return healthModel != null &&
                                            healthModel.name.isNotEmpty
                                        ? ListTile(
                                            title: InkWell(
                                              onTap: () {
                                                Get.to(() => HistoryDetail(
                                                      headingname:
                                                          healthModel.name,
                                                      url: healthModel.url,
                                                    ));
                                              },
                                              child: Text(
                                                healthModel.name,
                                                style: GoogleFonts.raleway(
                                                  textStyle:
                                                      GoogleFonts.poppins(
                                                          fontSize: 14,
                                                          color: ColorManager
                                                              .kblackColor,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                          )
                                        : const SizedBox.shrink();
                                  },
                                ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HealthTextField extends StatelessWidget {
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final int? maxlines;
  final Widget? prefixIcon;
  final TextStyle? suffixStyle;
  final String? suffixText;
  final bool? isSizedBoxAvailable;
  final bool readonly;
  final Widget? suffixIcon;
  final String? hintText;
  final Function(String)? onchanged;
  TextInputType? keyboardTypenew;
  final int? maxLength;
  final List<TextInputFormatter>? formatters;
  String? labelText;

  HealthTextField({
    Key? key,
    this.keyboardTypenew,
    this.hintText,
    this.suffixIcon,
    this.readonly = false,
    this.isSizedBoxAvailable = true,
    this.suffixText,
    this.suffixStyle,
    this.prefixIcon,
    this.maxlines,
    this.padding,
    this.onTap,
    this.validator,
    this.inputFormatters,
    this.onchanged,
    this.controller,
    this.maxLength,
    this.formatters,
    this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextFormField(
          controller: controller,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
          keyboardType: keyboardTypenew,
          onChanged: onchanged,
          validator: validator,
          onTap: onTap,
          maxLines: maxlines ?? 1,
          readOnly: readonly,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            prefixIcon: prefixIcon,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            suffixIcon: GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff99E92C),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(6.0),
                    bottomRight: Radius.circular(6.0),
                  ),
                ),
                child: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
