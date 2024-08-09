class GetIntakeWaterModel {
  int? status;
  String? errorMessage;
  int? intakeGlassCount;
  int? waterCompletionLevel;

  GetIntakeWaterModel(
      {this.status,
      this.errorMessage,
      this.intakeGlassCount,
      this.waterCompletionLevel});

  GetIntakeWaterModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    errorMessage = json['ErrorMessage'];
    intakeGlassCount = json['IntakeGlassCount'];

    var waterLevel = json['WaterCompletionLevel'];
    if (waterLevel is int) {
      waterCompletionLevel = waterLevel;
    } else if (waterLevel is double) {
      waterCompletionLevel = waterLevel.toInt();
    } else {
      waterCompletionLevel = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['ErrorMessage'] = errorMessage;
    data['IntakeGlassCount'] = intakeGlassCount;
    data['WaterCompletionLevel'] = waterCompletionLevel;
    return data;
  }
}
