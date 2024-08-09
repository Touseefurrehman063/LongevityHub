class PhysicalActivitiesLevelModel {
  int? status;
  List<PhysicalActivityLevels>? physicalActivityLevels;
  String? errorMessage;
  int? totalRecords;

  PhysicalActivitiesLevelModel(
      {this.status,
      this.physicalActivityLevels,
      this.errorMessage,
      this.totalRecords});

  PhysicalActivitiesLevelModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['PhysicalActivityLevels'] != null) {
      physicalActivityLevels = <PhysicalActivityLevels>[];
      json['PhysicalActivityLevels'].forEach((v) {
        physicalActivityLevels!.add(PhysicalActivityLevels.fromJson(v));
      });
    }
    errorMessage = json['ErrorMessage'];
    totalRecords = json['TotalRecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (physicalActivityLevels != null) {
      data['PhysicalActivityLevels'] =
          physicalActivityLevels!.map((v) => v.toJson()).toList();
    }
    data['ErrorMessage'] = errorMessage;
    data['TotalRecords'] = totalRecords;
    return data;
  }
}

class PhysicalActivityLevels {
  String? id;
  String? name;
  int? value;
  String? description;

  PhysicalActivityLevels({this.id, this.name, this.value, this.description});

  PhysicalActivityLevels.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    value = json['Value'];
    description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Value'] = value;
    data['Description'] = description;
    return data;
  }
}
