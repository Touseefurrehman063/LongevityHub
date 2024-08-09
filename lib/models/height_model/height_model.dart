class HeightModel {
  int? status;
  List<HeightMeasurements>? heightMeasurements;
  String? errorMessage;
  int? totalRecords;

  HeightModel(
      {this.status,
      this.heightMeasurements,
      this.errorMessage,
      this.totalRecords});

  HeightModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['HeightMeasurements'] != null) {
      heightMeasurements = <HeightMeasurements>[];
      json['HeightMeasurements'].forEach((v) {
        heightMeasurements!.add(HeightMeasurements.fromJson(v));
      });
    }
    errorMessage = json['ErrorMessage'];
    totalRecords = json['TotalRecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (heightMeasurements != null) {
      data['HeightMeasurements'] =
          heightMeasurements!.map((v) => v.toJson()).toList();
    }
    data['ErrorMessage'] = errorMessage;
    data['TotalRecords'] = totalRecords;
    return data;
  }
}

class HeightMeasurements {
  String? id;
  String? name;
  int? preferece;
  int? value;
  String? description;
  String? unitAbbrevation;
  String? prefix;

  HeightMeasurements(
      {this.id,
      this.name,
      this.preferece,
      this.value,
      this.description,
      this.unitAbbrevation,
      this.prefix});

  HeightMeasurements.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    preferece = json['Preferece'];
    value = json['Value'];
    description = json['Description'];
    unitAbbrevation = json['UnitAbbrevation'];
    prefix = json['Prefix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Preferece'] = preferece;
    data['Value'] = value;
    data['Description'] = description;
    data['UnitAbbrevation'] = unitAbbrevation;
    data['Prefix'] = prefix;
    return data;
  }
}
