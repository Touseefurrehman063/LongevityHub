class PackageSubscriptionPlan {
  final String packageSubscriptionPlanId;
  final String name;
  final String description;
  final List<Feature> features;
  final List<ChargeDetail> chargeDetails;

  PackageSubscriptionPlan({
    required this.packageSubscriptionPlanId,
    required this.name,
    required this.description,
    required this.features,
    required this.chargeDetails,
  });

  factory PackageSubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return PackageSubscriptionPlan(
      packageSubscriptionPlanId: json['PackageSubscriptionPlanId'],
      name: json['Name'],
      description: json['Description'],
      features:
          (json['Features'] as List).map((e) => Feature.fromJson(e)).toList(),
      chargeDetails: (json['ChargeDetails'] as List)
          .map((e) => ChargeDetail.fromJson(e))
          .toList(),
    );
  }
}

class Feature {
  final String featuresId;
  final String name;

  Feature({required this.featuresId, required this.name});

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      featuresId: json['FeaturesId'],
      name: json['Name'],
    );
  }
}

class ChargeDetail {
  final String? packagePriceDetailsId;
  final String? chargeTypeId;
  final String? chargeTypeName;
  final dynamic chargeIntervalId;
  final dynamic chargeIntervalName;
  final dynamic intervalDuration;
  final double charges;

  ChargeDetail({
    this.packagePriceDetailsId,
    this.chargeTypeId,
    this.chargeTypeName,
    this.chargeIntervalId,
    this.chargeIntervalName,
    this.intervalDuration,
    required this.charges,
  });

  factory ChargeDetail.fromJson(Map<String, dynamic> json) {
    return ChargeDetail(
      packagePriceDetailsId: json['PackagePriceDetailsId'],
      chargeTypeId: json['ChargeTypeId'],
      chargeTypeName: json['ChargeTypeName'],
      chargeIntervalId: json['ChargeIntervalId'],
      chargeIntervalName: json['ChargeIntervalName'],
      intervalDuration: json['IntervalDuration'],
      charges: json['Charges'].toDouble(),
    );
  }
}
