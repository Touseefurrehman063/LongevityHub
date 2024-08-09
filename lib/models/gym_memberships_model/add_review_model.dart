class AddReviewModel {
  int? status;
  String? errorMessage;

  AddReviewModel({this.status, this.errorMessage});

  AddReviewModel.fromJson(Map<String, dynamic> json) {
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
