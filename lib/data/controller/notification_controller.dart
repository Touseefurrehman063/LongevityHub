// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:longevity_hub/models/notification_model.dart';

class NotificationController extends GetxController implements GetxService {
  static NotificationController get i => Get.put(NotificationController());

  List<NotificationModel> notificationlist = [];
  updatenotificationlist(List<NotificationModel> data) {
    notificationlist.clear();
    notificationlist = data;
    update();
  }

  int today = 1;
  int yesterday = 1;
  int previous = 1;

  updatedays() {
    today = 1;
    yesterday = 1;
    previous = 1;
    update();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  updateIsloading(bool value) {
    updatedays();
    update();
    _isLoading = value;
    update();
  }

  int startIndexToFetchData = 0;
  int TotalRecordsData = 0;

  SetStartToFetchNextData() {
    if ((startIndexToFetchData + 10) < TotalRecordsData) {
      startIndexToFetchData = startIndexToFetchData + 10;
      return true;
    } else {
      Fluttertoast.showToast(
          msg: "All records are fetched".tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          fontSize: 14.0);
      return false;
    }
  }
}
