import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController implements GetxService {
  static ProfileController get i => Get.put(ProfileController());

  final zoomDrawerController = ZoomDrawerController();

  bool fingerprint = false;
  updatefingerprint(val) {
    fingerprint = val;
    update();
  }

  int selectedPage = 2;
  updateselectedPage(val) {
    selectedPage = val;
    update();
  }
}
