class SleepLevelsModel {
  int? status;
  String? errorMessage;
  List<SleepRewardData>? data;

  SleepLevelsModel({this.status, this.errorMessage, this.data});

  SleepLevelsModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    errorMessage = json['ErrorMessage'];
    if (json['Data'] != null) {
      data = <SleepRewardData>[];
      json['Data'].forEach((v) {
        data!.add(SleepRewardData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['ErrorMessage'] = errorMessage;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SleepRewardData {
  String? id;
  dynamic userId;
  int? points;
  String? rewardsLevelName;
  String? rewardsLevelId;
  dynamic achievePoints;
  dynamic totalPoints;

  SleepRewardData(
      {this.id,
      this.userId,
      this.points,
      this.rewardsLevelName,
      this.rewardsLevelId,
      this.achievePoints,
      this.totalPoints});

  SleepRewardData.fromJson(Map<String, dynamic> json) {
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
