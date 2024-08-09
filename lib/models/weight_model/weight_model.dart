class WeightModel {
  int? status;
  List<WeightMeasurements>? weightMeasurements;
  String? errorMessage;
  int? totalRecords;

  WeightModel(
      {this.status,
      this.weightMeasurements,
      this.errorMessage,
      this.totalRecords});

  WeightModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['WeightMeasurements'] != null) {
      weightMeasurements = <WeightMeasurements>[];
      json['WeightMeasurements'].forEach((v) {
        weightMeasurements!.add(WeightMeasurements.fromJson(v));
      });
    }
    errorMessage = json['ErrorMessage'];
    totalRecords = json['TotalRecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (weightMeasurements != null) {
      data['WeightMeasurements'] =
          weightMeasurements!.map((v) => v.toJson()).toList();
    }
    data['ErrorMessage'] = errorMessage;
    data['TotalRecords'] = totalRecords;
    return data;
  }
}

class WeightMeasurements {
  String? id;
  String? name;
  int? preferece;
  int? value;
  String? description;
  String? unitAbbrevation;
  String? prefix;

  WeightMeasurements(
      {this.id,
      this.name,
      this.preferece,
      this.value,
      this.description,
      this.unitAbbrevation,
      this.prefix});

  WeightMeasurements.fromJson(Map<String, dynamic> json) {
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
