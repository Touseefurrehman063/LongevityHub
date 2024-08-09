import 'dart:core';
import 'package:get/get.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/models/subscription_model/get_expirydate_model.dart';
import 'package:longevity_hub/models/subscription_model/get_subscription_plan_model.dart';
import 'package:longevity_hub/repositories/subscription_repo/subscription_repo.dart';

class SubscriptionController extends GetxController implements GetxService {
  bool isUpdatePackage = false;
  bool isLoading = true;
  List<PackageSubscriptionPlan> packages = [];
  String? selectedPackageId;
  int selectedIndex = 0;
  String? packageName;
  DateTime? expiryDate;
  int remainingYears = 0;
  int remainingMonths = 0;
  int remainingDays = 0;
  @override
  void onInit() {
    super.onInit();
    LocalDb().loadSelectedPackageId();
    LocalDb().loadSelectedIndex();
    fetchPackageExpiryDate();
  }

  // Future<void> fetchPackageExpiryDate() async {
  //   var expiryDateList = await SubscriptionRepo.getPackageExpiryDate();

  //   if (expiryDateList != null && expiryDateList.isNotEmpty) {
  //     var data = expiryDateList.first;

  //     packageName = data.packageName;
  //     expiryDate = DateTime.parse(data.dateTime);
  //     remainingYears = data.remainingYears;
  //     remainingMonths = data.remainingMonths;
  //     remainingDays = data.remainingDays;
  //     update();
  //   }
  // }
  Future<void> fetchPackageExpiryDate() async {
    var expiryDateList = await SubscriptionRepo.getPackageExpiryDate();

    if (expiryDateList != null && expiryDateList.isNotEmpty) {
      var data = expiryDateList.first;
      int index = packages.indexWhere((package) =>
          package.packageSubscriptionPlanId == data.packageSubscriptionPlanId ||
          package.name == data.packageName);

      if (index != -1) {
        selectedIndex = index;
      }

      packageName = data.packageName;
      expiryDate = DateTime.parse(data.dateTime);
      remainingYears = data.remainingYears;
      remainingMonths = data.remainingMonths;
      remainingDays = data.remainingDays;
      update();
    }
  }

  List<ExpirydateData> packagePlanDate = [];
  void getexpirydateData(List<ExpirydateData>? packagePlan) {
    if (packagePlan != null) {
      packagePlanDate = packagePlan;
    } else {
      packagePlanDate = [];
    }
    update();
  }

  static SubscriptionController get i => Get.put(SubscriptionController());

  void updateIsLoading(bool isLoading) {
    isUpdatePackage = isLoading;
    update();
  }

  void setSelectedIndex(int index) {
    LocalDb().saveSelectedIndex(index);
    update();
  }
}
