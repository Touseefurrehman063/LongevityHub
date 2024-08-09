class WaterResponse {
  int? status;
  String? errorMessage;
  List<Data>? data;

  WaterResponse({this.status, this.errorMessage, this.data});

  WaterResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    errorMessage = json['ErrorMessage'];
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  String? userId;
  String? name;
  dynamic description;
  int? numberOfGlass;
  int? intakeGlassCount;
  String? waterActivityId;
  dynamic waterActivityCategoryId;
  int? waterCompletionLevel;
  dynamic imagePath;

  Data({
    this.userId,
    this.name,
    this.description,
    this.numberOfGlass,
    this.intakeGlassCount,
    this.waterActivityId,
    this.waterActivityCategoryId,
    this.waterCompletionLevel,
    this.imagePath,
  });

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    name = json['Name'];
    description = json['Description'];
    numberOfGlass = json['NumberOfGlass'] is double
        ? (json['NumberOfGlass'] as double).toInt()
        : json['NumberOfGlass'];
    intakeGlassCount = json['IntakeGlassCount'] is double
        ? (json['IntakeGlassCount'] as double).toInt()
        : json['IntakeGlassCount'];
    waterActivityId = json['WaterActivityId'];
    waterActivityCategoryId = json['WaterActivityCategoryId'];
    waterCompletionLevel = json['WaterCompletionLevel'] is double
        ? (json['WaterCompletionLevel'] as double).toInt()
        : json['WaterCompletionLevel'];
    imagePath = json['ImagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = userId;
    data['Name'] = name;
    data['Description'] = description;
    data['NumberOfGlass'] = numberOfGlass;
    data['IntakeGlassCount'] = intakeGlassCount;
    data['WaterActivityId'] = waterActivityId;
    data['WaterActivityCategoryId'] = waterActivityCategoryId;
    data['WaterCompletionLevel'] = waterCompletionLevel;
    data['ImagePath'] = imagePath;
    return data;
  }
}
