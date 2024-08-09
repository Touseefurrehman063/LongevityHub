class UserSleepModel {
  int? status;
  String? errorMessage;
  List<UserSleepData>? data;

  UserSleepModel({this.status, this.errorMessage, this.data});

  UserSleepModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    errorMessage = json['ErrorMessage'];
    if (json['Data'] != null) {
      data = <UserSleepData>[];
      json['Data'].forEach((v) {
        data!.add(UserSleepData.fromJson(v));
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

class UserSleepData {
  String? id;
  dynamic userId;
  dynamic points;
  String? rewardsLevelName;
  String? rewardsLevelId;
  int? achievePoints;
  int? totalPoints;

  UserSleepData(
      {this.id,
      this.userId,
      this.points,
      this.rewardsLevelName,
      this.rewardsLevelId,
      this.achievePoints,
      this.totalPoints});

  UserSleepData.fromJson(Map<String, dynamic> json) {
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
