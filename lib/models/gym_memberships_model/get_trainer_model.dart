class GetTrainersModel {
  int? status;
  List<TrainersData>? data;

  GetTrainersModel({this.status, this.data});

  GetTrainersModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <TrainersData>[];
      json['Data'].forEach((v) {
        data!.add(TrainersData.fromJson(v));
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

class TrainersData {
  String? id;
  dynamic gymId;
  String? trainerName;
  String? gymName;
  dynamic description;
  int? age;
  int? experience;
  String? address;
  String? categoryId;
  String? categoryName;
  dynamic picturePath;
  String? cellNumber;
  dynamic trainerRating;

  TrainersData(
      {this.id,
      this.gymId,
      this.trainerName,
      this.gymName,
      this.description,
      this.age,
      this.experience,
      this.address,
      this.categoryId,
      this.categoryName,
      this.picturePath,
      this.cellNumber,
      this.trainerRating});

  TrainersData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    gymId = json['GymId'];
    trainerName = json['TrainerName'];
    gymName = json['GymName'];
    description = json['Description'];
    age = json['Age'];
    experience = json['Experience'];
    address = json['Address'];
    categoryId = json['CategoryId'];
    categoryName = json['CategoryName'];
    picturePath = json['PicturePath'];
    cellNumber = json['CellNumber'];
    trainerRating = json['TrainerRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['GymId'] = gymId;
    data['TrainerName'] = trainerName;
    data['GymName'] = gymName;
    data['Description'] = description;
    data['Age'] = age;
    data['Experience'] = experience;
    data['Address'] = address;
    data['CategoryId'] = categoryId;
    data['CategoryName'] = categoryName;
    data['PicturePath'] = picturePath;
    data['CellNumber'] = cellNumber;
    data['TrainerRating'] = trainerRating;
    return data;
  }
}
