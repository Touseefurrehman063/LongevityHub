// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:longevity_hub/components/custom_appbar.dart';
import 'package:longevity_hub/data/controller/health_a_z_controller/health_az_controller.dart';
import 'package:longevity_hub/screens/health_az/detail_well.dart';
import 'package:shimmer/shimmer.dart';

class LiveWellDetail extends StatefulWidget {
  final String? headingname;
  final String? url;

  const LiveWellDetail({
    Key? key,
    required this.headingname,
    required this.url,
  }) : super(key: key);

  @override
  _LiveWellDetailState createState() => _LiveWellDetailState();
}

class _LiveWellDetailState extends State<LiveWellDetail> {
  final ScrollController _scrollController = ScrollController();
  int selectedIndex = 0;
  List<dynamic> healthDetails = [];
  Uint8List? imageData;
  bool _isLoading = true;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    await HealthController.i.fetchLiveWellDetails(widget.url!);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    HealthController.i.disc == "";

    super.dispose();
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
                    // if (imageData != null)
                    //   Image.memory(
                    //     imageData!,
                    //     fit: BoxFit.contain,
                    //   )
                    // else
                    //   const SizedBox.shrink(),
                    SizedBox(height: Get.height * 0.02),
                    Text(
                      HealthController.i.disc ?? "",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.start,
                    ),

                    SizedBox(height: Get.height * 0.02),
                    GetBuilder<HealthController>(builder: (cont) {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cont.mainEntityPageDetailList.length,
                        itemBuilder: (context, index) {
                          var liveWellDetail =
                              cont.mainEntityPageDetailList[index];
                          if (liveWellDetail.mainEntityOfPage.isEmpty) {
                            return const SizedBox.shrink();
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: liveWellDetail.mainEntityOfPage
                                .map<Widget>((entity) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (entity.url != null &&
                                          entity.url!.isNotEmpty) {
                                        Get.to(() => WellDetail(
                                              headingname:
                                                  entity.headline ?? "",
                                              url: entity.url ?? "",
                                            ));
                                      } else {
                                        log('URL is empty, cannot navigate.');
                                      }
                                    },
                                    child: Text(
                                      entity.headline ?? "",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: entity.url != null &&
                                                entity.url!.isNotEmpty
                                            ? const Color.fromARGB(
                                                255, 8, 98, 172)
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                        decoration: entity.url != null &&
                                                entity.url!.isNotEmpty
                                            ? TextDecoration.underline
                                            : TextDecoration.none,
                                        decorationThickness: 2.0,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),

                                  SizedBox(height: Get.height * 0.01),

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
                                  // if (entity.url != null)
                                  //   FutureBuilder<Uint8List?>(
                                  //     future: fetchImageData(entity.url!),
                                  //     builder: (context, snapshot) {
                                  //       if (snapshot.connectionState ==
                                  //           ConnectionState.done) {
                                  //         if (snapshot.hasData) {
                                  //           return Image.memory(
                                  //             snapshot.data!,
                                  //             fit: BoxFit.contain,
                                  //           );
                                  //         } else {
                                  //           return const SizedBox.shrink();
                                  //         }
                                  //       } else {
                                  //         // Shimmer for image in FutureBuilder
                                  //         return Shimmer.fromColors(
                                  //           baseColor: Colors.grey.shade300,
                                  //           highlightColor:
                                  //               Colors.grey.shade100,
                                  //           child: Container(
                                  //             height: 100,
                                  //             color: Colors.white,
                                  //           ),
                                  //         );
                                  //       }
                                  //     },
                                  //   ),
                                ],
                              );
                            }).toList(),
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
    );
  }
}
