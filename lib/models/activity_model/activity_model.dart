class PhysicalActivitiesModel {
  int? status;
  List<PhysicalActivities>? physicalActivities;
  String? errorMessage;
  int? totalRecords;

  PhysicalActivitiesModel(
      {this.status,
      this.physicalActivities,
      this.errorMessage,
      this.totalRecords});

  PhysicalActivitiesModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['PhysicalActivities'] != null) {
      physicalActivities = <PhysicalActivities>[];
      json['PhysicalActivities'].forEach((v) {
        physicalActivities!.add(PhysicalActivities.fromJson(v));
      });
    }
    errorMessage = json['ErrorMessage'];
    totalRecords = json['TotalRecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (physicalActivities != null) {
      data['PhysicalActivities'] =
          physicalActivities!.map((v) => v.toJson()).toList();
    }
    data['ErrorMessage'] = errorMessage;
    data['TotalRecords'] = totalRecords;
    return data;
  }
}

class PhysicalActivities {
  String? id;
  String? name;
  int? value;
  String? description;
  String? imagePath;
  String? backgroundImageColor;

  PhysicalActivities(
      {this.id,
      this.name,
      this.value,
      this.description,
      this.imagePath,
      this.backgroundImageColor});

  PhysicalActivities.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    value = json['Value'];
    description = json['Description'];
    imagePath = json['ImagePath'];
    backgroundImageColor = json['BackgroundImageColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Value'] = value;
    data['Description'] = description;
    data['ImagePath'] = imagePath;
    data['BackgroundImageColor'] = backgroundImageColor;
    return data;
  }
}
