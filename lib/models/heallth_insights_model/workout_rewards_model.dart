class WorkoutLevelsModel {
  int? status;
  String? errorMessage;
  List<WorkoutRewardData>? data;

  WorkoutLevelsModel({this.status, this.errorMessage, this.data});

  WorkoutLevelsModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    errorMessage = json['ErrorMessage'];
    if (json['Data'] != null) {
      data = <WorkoutRewardData>[];
      json['Data'].forEach((v) {
        data!.add(WorkoutRewardData.fromJson(v));
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

class WorkoutRewardData {
  String? id;
  dynamic userId;
  int? points;
  String? rewardsLevelName;
  String? rewardsLevelId;
  dynamic achievePoints;
  dynamic totalPoints;

  WorkoutRewardData(
      {this.id,
      this.userId,
      this.points,
      this.rewardsLevelName,
      this.rewardsLevelId,
      this.achievePoints,
      this.totalPoints});

  WorkoutRewardData.fromJson(Map<String, dynamic> json) {
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
