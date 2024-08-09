// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class FAQsDialog extends StatefulWidget {
  const FAQsDialog({super.key});

  @override
  _FAQsDialogState createState() => _FAQsDialogState();
}

class _FAQsDialogState extends State<FAQsDialog> {
  bool _isLoading = true;
  final String privacyPolicyUrl = 'https://longevityhub.ae/faqs/';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(child: Text("faq's".tr)),
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              AppImages.cross,
              scale: 8,
            ),
          )
        ],
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri(privacyPolicyUrl),
              ),
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  javaScriptEnabled: true,
                ),
              ),
              onLoadStart: (controller, url) {
                setState(() {
                  _isLoading = true;
                });
              },
              onLoadStop: (controller, url) async {
                setState(() {
                  _isLoading = false;
                });
              },
              onLoadError: (controller, url, code, message) {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: ColorManager.kPrimaryColor,
                  ))
                : Container(),
          ],
        ),
      ),
    );
  }
}
