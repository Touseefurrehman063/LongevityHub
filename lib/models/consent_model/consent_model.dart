class ConsentModel {
  int? status;
  String? errorMessage;

  ConsentModel({this.status, this.errorMessage});

  ConsentModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['ErrorMessage'] = errorMessage;
    return data;
  }
}
