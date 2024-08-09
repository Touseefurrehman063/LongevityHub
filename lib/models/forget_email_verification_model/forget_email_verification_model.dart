class ForgetEmailVerificationResponse {
  int? status;
  String? errorMessage;

  ForgetEmailVerificationResponse({this.status, this.errorMessage});

  ForgetEmailVerificationResponse.fromJson(Map<String, dynamic> json) {
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
