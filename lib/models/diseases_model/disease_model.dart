class DiseaseModel {
  int? status;
  List<Diseases>? diseases;
  String? errorMessage;
  int? totalRecords;

  DiseaseModel(
      {this.status, this.diseases, this.errorMessage, this.totalRecords});

  DiseaseModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Diseases'] != null) {
      diseases = <Diseases>[];
      json['Diseases'].forEach((v) {
        diseases!.add(Diseases.fromJson(v));
      });
    }
    errorMessage = json['ErrorMessage'];
    totalRecords = json['TotalRecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (diseases != null) {
      data['Diseases'] = diseases!.map((v) => v.toJson()).toList();
    }
    data['ErrorMessage'] = errorMessage;
    data['TotalRecords'] = totalRecords;
    return data;
  }
}

class Diseases {
  dynamic id;
  String? name;
  String? code;
  String? comments;

  Diseases({this.id, this.name, this.code, this.comments});

  Diseases.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    code = json['Code'];
    comments = json['Comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Code'] = code;
    data['Comments'] = comments;
    return data;
  }
}
