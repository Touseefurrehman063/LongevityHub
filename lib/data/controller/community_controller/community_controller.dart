import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityController extends GetxController implements GetxService {
  bool isApproveMemberLoading = true;
  TextEditingController selectcommuntiycont = TextEditingController();
  TextEditingController approvemembercont = TextEditingController();
  TextEditingController? searchcont = TextEditingController();
  void updateApproveMemberToggle() {
    isApproveMemberLoading = !isApproveMemberLoading;
    update();
  }

  // bool isSelectedCatogary = false;
  List<bool> isSelectedCategories = List.generate(10, (index) => false);
  static CommunityController get i => Get.put(CommunityController());
}
