class PackagePlanExpiryDate {
  int? status;
  List<ExpirydateData>? data;

  PackagePlanExpiryDate({this.status, this.data});

  PackagePlanExpiryDate.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <ExpirydateData>[];
      json['Data'].forEach((v) {
        data!.add(ExpirydateData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExpirydateData {
  dynamic userId;
  String? packageSubscriptionPlanId;
  String? dateTime;
  String? packageName;
  int? remainingYears;
  int? remainingMonths;
  int? remainingDays;

  ExpirydateData(
      {this.userId,
      this.packageSubscriptionPlanId,
      this.dateTime,
      this.packageName,
      this.remainingYears,
      this.remainingMonths,
      this.remainingDays});

  ExpirydateData.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    packageSubscriptionPlanId = json['PackageSubscriptionPlanId'];
    dateTime = json['DateTime'];
    packageName = json['PackageName'];
    remainingYears = json['RemainingYears'];
    remainingMonths = json['RemainingMonths'];
    remainingDays = json['RemainingDays'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = userId;
    data['PackageSubscriptionPlanId'] = packageSubscriptionPlanId;
    data['DateTime'] = dateTime;
    data['PackageName'] = packageName;
    data['RemainingYears'] = remainingYears;
    data['RemainingMonths'] = remainingMonths;
    data['RemainingDays'] = remainingDays;
    return data;
  }
}
