class GymVideoCatogeryModel {
  int? status;
  List<CatogaryData>? data;

  GymVideoCatogeryModel({this.status, this.data});

  GymVideoCatogeryModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <CatogaryData>[];
      json['Data'].forEach((v) {
        data!.add(CatogaryData.fromJson(v));
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

class CatogaryData {
  String? id;
  String? name;
  String? description;

  CatogaryData({this.id, this.name, this.description});

  CatogaryData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Description'] = description;
    return data;
  }
}
