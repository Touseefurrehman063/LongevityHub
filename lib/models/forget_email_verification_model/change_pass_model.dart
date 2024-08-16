class ChangePasswordModel {
  int? status;
  String? error;

  ChangePasswordModel({this.status, this.error});

  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    error = json['Error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['Error'] = error;
    return data;
  }
}
