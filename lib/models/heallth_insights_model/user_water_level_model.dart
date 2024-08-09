class WaterUserModel {
  int? status;
  String? errorMessage;
  List<WaterUserData>? waterUserData;

  WaterUserModel({this.status, this.errorMessage, this.waterUserData});

  WaterUserModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    errorMessage = json['ErrorMessage'];
    if (json['Data'] != null) {
      waterUserData = <WaterUserData>[];
      json['Data'].forEach((v) {
        waterUserData!.add(WaterUserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['ErrorMessage'] = errorMessage;
    if (waterUserData != null) {
      data['Data'] = waterUserData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WaterUserData {
  String? id;
  dynamic userId;
  dynamic points;
  String? rewardsLevelName;
  String? rewardsLevelId;
  int? achievePoints;
  int? totalPoints;

  WaterUserData(
      {this.id,
      this.userId,
      this.points,
      this.rewardsLevelName,
      this.rewardsLevelId,
      this.achievePoints,
      this.totalPoints});

  WaterUserData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    userId = json['UserId'];
    points = json['Points'];
    rewardsLevelName = json['RewardsLevelName'];
    rewardsLevelId = json['RewardsLevelId'];
    achievePoints = json['AchievePoints'];
    totalPoints = json['TotalPoints'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['UserId'] = userId;
    data['Points'] = points;
    data['RewardsLevelName'] = rewardsLevelName;
    data['RewardsLevelId'] = rewardsLevelId;
    data['AchievePoints'] = achievePoints;
    data['TotalPoints'] = totalPoints;
    return data;
  }
}
