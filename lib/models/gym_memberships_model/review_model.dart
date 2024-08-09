class ReviewModel {
  int? status;
  List<ReviewData>? data;

  ReviewModel({this.status, this.data});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <ReviewData>[];
      json['Data'].forEach((v) {
        data!.add(ReviewData.fromJson(v));
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

class ReviewData {
  dynamic id;
  dynamic trainerId;
  String? trainerName;
  double? rating;
  String? description;
  dynamic userId;
  String? userName;
  String? reviewDate;
  dynamic trainerPicturePath;
  dynamic userPicturePath;
  String? reviewTime;

  ReviewData(
      {this.id,
      this.trainerId,
      this.trainerName,
      this.rating,
      this.description,
      this.userId,
      this.userName,
      this.reviewDate,
      this.trainerPicturePath,
      this.userPicturePath,
      this.reviewTime});

  ReviewData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    trainerId = json['TrainerId'];
    trainerName = json['TrainerName'];
    rating = json['Rating'];
    description = json['Description'];
    userId = json['UserId'];
    userName = json['UserName'];
    reviewDate = json['ReviewDate'];
    trainerPicturePath = json['TrainerPicturePath'];
    userPicturePath = json['UserPicturePath'];
    reviewTime = json['ReviewTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['TrainerId'] = trainerId;
    data['TrainerName'] = trainerName;
    data['Rating'] = rating;
    data['Description'] = description;
    data['UserId'] = userId;
    data['UserName'] = userName;
    data['ReviewDate'] = reviewDate;
    data['TrainerPicturePath'] = trainerPicturePath;
    data['UserPicturePath'] = userPicturePath;
    data['ReviewTime'] = reviewTime;
    return data;
  }
}
