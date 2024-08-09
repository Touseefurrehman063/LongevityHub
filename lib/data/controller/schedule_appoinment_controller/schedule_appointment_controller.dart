import 'package:get/get.dart';

class ScheduleAppoinmentController extends GetxController {
  // bool isSelected = false;
  RxList<int> selectedIndices = <int>[].obs;

  void toggleSelection(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
    } else {
      selectedIndices.value = [index];
    }
  }

  bool isIntresetSelected = false;
  static ScheduleAppoinmentController get i =>
      Get.put(ScheduleAppoinmentController());
}
