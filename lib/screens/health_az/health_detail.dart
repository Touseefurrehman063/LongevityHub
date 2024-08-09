// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:longevity_hub/components/custom_appbar.dart';
import 'package:longevity_hub/repositories/health_a_z_repo/health_a_z_repo.dart';
import 'package:shimmer/shimmer.dart';

class HistoryDetail extends StatefulWidget {
  final String? headingname;
  final String? url;

  const HistoryDetail({
    Key? key,
    required this.headingname,
    required this.url,
  }) : super(key: key);

  @override
  _HistoryDetailState createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  final ScrollController _scrollController = ScrollController();
  int selectedIndex = 0;
  List<dynamic> healthDetails = [];
  Uint8List? imageData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getHealthDetails();
  }

  Future<void> getHealthDetails() async {
    try {
      var details = await HealthAtoZRepository()
          .getHealthDetails(url: widget.url.toString());
      setState(() {
        healthDetails = details;
        _isLoading = false; // Data loaded
      });
      fetchImage();
    } catch (e) {
      print('Error fetching health details: $e');
      setState(() {
        _isLoading = false; // Stop loading on error
      });
    }
  }

  Future<void> fetchImage() async {
    if (healthDetails.isNotEmpty &&
        selectedIndex < healthDetails.length &&
        healthDetails[selectedIndex].image != null &&
        healthDetails[selectedIndex].image!.isNotEmpty) {
      imageData =
          await fetchImageData(healthDetails[selectedIndex].image![0].url!);
      setState(() {});
    }
  }

  Future<Uint8List?> fetchImageData(String url) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer YOUR_ACCESS_TOKEN', // Include your token here
      },
    );
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      print('Failed to load image, status code: ${response.statusCode}');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerText: widget.headingname.toString(),
        leadingOnPressed: () {
          Get.back();
        },
      ),
      body: _isLoading
          ? Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                children: [
                  Container(
                    height: Get.height * 0.3,
                    color: Colors.white,
                  ),
                  SizedBox(height: Get.height * 0.02),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.white,
                              height: 20,
                              width: double.infinity,
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              color: Colors.white,
                              height: 100,
                              width: double.infinity,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                child: Column(
                  children: [
                    if (imageData != null)
                      Image.memory(
                        imageData!,
                        fit: BoxFit.contain,
                      )
                    else
                      const SizedBox.shrink(),
                    SizedBox(height: Get.height * 0.02),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: healthDetails.length,
                      itemBuilder: (context, index) {
                        var healthDetail = healthDetails[index];
                        if (healthDetail.mainEntityOfPage == null ||
                            healthDetail.mainEntityOfPage!.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: healthDetail.mainEntityOfPage!
                              .map<Widget>((entity) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    entity.headline ?? '',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  const SizedBox(height: 4.0),
                                  Html(
                                    data: entity.text ?? '',
                                    style: {
                                      "body": Style(
                                        fontSize: FontSize(12),
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    },
                                  ),
                                  if (entity.url != null)
                                    FutureBuilder<Uint8List?>(
                                      future: fetchImageData(entity.url!),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          if (snapshot.hasData) {
                                            return Image.memory(
                                              snapshot.data!,
                                              fit: BoxFit.contain,
                                            );
                                          } else {
                                            return const SizedBox.shrink();
                                          }
                                        } else {
                                          // Shimmer for image in FutureBuilder
                                          return Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                                Colors.grey.shade100,
                                            child: Container(
                                              height: 100,
                                              color: Colors.white,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
