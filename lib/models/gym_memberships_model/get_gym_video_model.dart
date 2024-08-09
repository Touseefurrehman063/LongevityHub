class GetGymVideoModel {
  int? status;
  List<VideoData>? data;

  GetGymVideoModel({this.status, this.data});

  GetGymVideoModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <VideoData>[];
      json['Data'].forEach((v) {
        data!.add(VideoData.fromJson(v));
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

class VideoData {
  String? id;
  dynamic userId;
  dynamic gymId;
  String? title;
  String? description;
  String? categoryName;
  String? video;
  dynamic gymExerciseCategoryId;
  int? repsCount;
  int? caloriesConsumed;
  String? gymUserLevelId;
  String? gymUserLevelName;
  String? fireBaseAttachmentLink;

  VideoData(
      {this.id,
      this.userId,
      this.gymId,
      this.title,
      this.description,
      this.categoryName,
      this.video,
      this.gymExerciseCategoryId,
      this.repsCount,
      this.caloriesConsumed,
      this.gymUserLevelId,
      this.gymUserLevelName,
      this.fireBaseAttachmentLink});

  VideoData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    userId = json['UserId'];
    gymId = json['GymId'];
    title = json['Title'];
    description = json['Description'];
    categoryName = json['CategoryName'];
    video = json['Video'];
    gymExerciseCategoryId = json['GymExerciseCategoryId'];
    repsCount = json['RepsCount'];
    caloriesConsumed = json['CaloriesConsumed'];
    gymUserLevelId = json['GymUserLevelId'];
    gymUserLevelName = json['GymUserLevelName'];
    fireBaseAttachmentLink = json['FireBaseAttachmentLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['UserId'] = userId;
    data['GymId'] = gymId;
    data['Title'] = title;
    data['Description'] = description;
    data['CategoryName'] = categoryName;
    data['Video'] = video;
    data['GymExerciseCategoryId'] = gymExerciseCategoryId;
    data['RepsCount'] = repsCount;
    data['CaloriesConsumed'] = caloriesConsumed;
    data['GymUserLevelId'] = gymUserLevelId;
    data['GymUserLevelName'] = gymUserLevelName;
    data['FireBaseAttachmentLink'] = fireBaseAttachmentLink;
    return data;
  }
}
