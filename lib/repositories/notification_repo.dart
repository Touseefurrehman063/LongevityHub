// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'package:longevity_hub/data/controller/notification_controller.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/models/notification_model.dart';
import 'package:longevity_hub/utils/constants.dart';
import 'package:http/http.dart' as http;

class NotificationsRepo {
  Getnotification(fromdate, todate, length, search) async {
    String? userId = await LocalDb().getUserid();
    String? accessToken = await LocalDb().getAccessToken();
    var body = {
      'UserId': userId,
      'BranchId': "",
      'FromDate': fromdate,
      'ToDate': todate,
      'length': length,
      'start': 0,
      'Search': search,
      'OrderDir': "desc",
      'OrderColumn': 0,
    };
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(Uri.parse(AppConstants.notification),
          headers: headers, body: jsonEncode(body));
      // print(body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        if (result['Status'] == 0) {
          // Fluttertoast.showToast(
          //     msg: 'Failed to get data'.tr,
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.BOTTOM,
          //     timeInSecForIosWeb: 1,
          //     backgroundColor: ColorManager.kRedColor,
          //     textColor: ColorManager.kWhiteColor,
          //     fontSize: 14.0);
        } else if (result['Status'] == 1) {
          Iterable lst = result['data'];
          List<NotificationModel> rep =
              lst.map((e) => NotificationModel.fromJson(e)).toList();

          NotificationController.i.updatenotificationlist(rep);
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('$e exception caught');
    }
  }
}
