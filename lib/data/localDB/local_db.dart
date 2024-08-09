import 'dart:convert';
import 'dart:developer';
import 'package:longevity_hub/data/controller/health_insights_controller/health_insights_controller.dart';
import 'package:longevity_hub/data/controller/intro_steps_controller/intro_steps_controller.dart';
import 'package:longevity_hub/data/controller/subscription_controller/subscription_controller.dart';
import 'package:longevity_hub/models/language_model.dart';
import 'package:longevity_hub/models/user_model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDb {
  setBaseURL(String? url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('baseurl', '$url');
  }

  Future<String?>? getBaseURL() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('baseurl');
    return result;
  }

  Future<void> saveAccessToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }

  Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<void> saveUserToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  saveUsername(String? username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Username', '$username');
  }

  Future<String?>? getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('Username');
    return result;
  }

  savePassword(String? password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Password', '$password');
  }

  Future<String?>? getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('Password');
    return result;
  }

  static savefingerprint(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('fingerprint', val);
  }

  static getfingerprint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool returnvalue = prefs.getBool('fingerprint') ?? false;
    return returnvalue;
  }

  Future<String?> getDeviceToken() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    return s.getString('deviceToken');
  }

  Future<void> saveDeviceToken(String? token) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    if (token != null) {
      s.setString('deviceToken', token);
      log('Device token saved: $token');
    }
  }

  saveIsFirstTime(bool? isFirstTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.setBool('IsFirstTime', isFirstTime!);
    log('IsFirstTime $result');
  }

  Future<bool?>? getIsFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? result = prefs.getBool('IsFirstTime');
    return result;
  }

  saveToken(String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.setString('token', '$token');
    log('token is  $result');
  }

  Future<String?>? getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('token');
    return result;
  }

  saveLoginStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.setBool('status', status);
    log('patientId $result');
  }

  Future<bool?>? getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? result = prefs.getBool('status');
    return result;
  }

  saveUserid(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.setString('UserId', id);
    log('UserId $result');
  }

  Future<String?>? getUserid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('UserId');
    return result;
  }

  setLanguage(LanguageModel? language) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    s.setString('language', jsonEncode(language));
  }

  Future<LanguageModel?> getLanguage() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String? data = s.getString("language");
    LanguageModel? lang;
    if (data != null) {
      lang = LanguageModel.fromJson(jsonDecode(data));
    } else {
      lang = null;
    }
    return lang;
  }

  Future<UserDataModel> getProfileData() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("profile") ?? '';
    UserDataModel user = UserDataModel.fromJson(jsonDecode(data));
    return user;
  }

  Future<void> saveGender(String genderId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedGender', genderId);
    log('Saved gender ID: $genderId');
  }

  Future<String?> getGender() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedGender');
  }

  Future<void> saveDateOfBirth(int day, String month, int year) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('dobDay', day);
    await prefs.setString('dobMonth', month);
    await prefs.setInt('dobYear', year);
    log('Saved date of birth: $year-$month-$day');
  }

  Future<Map<String, dynamic>> getDateOfBirth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? day = prefs.getInt('dobDay');
    String? month = prefs.getString('dobMonth');
    int? year = prefs.getInt('dobYear');
    if (day != null && month != null && year != null) {
      return {'year': year, 'month': month, 'day': day};
    }
    return {};
  }

  Future<void> saveHeightData(
      String heightValue, String heightMeasurementId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('heightValue', heightValue);
    await prefs.setString('heightMeasurementId', heightMeasurementId);
    log(heightValue);
    log(heightMeasurementId);
  }

  Future<Map<String, dynamic>> getHeightData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? heightValue = prefs.getString('heightValue');
    String? heightMeasurementId = prefs.getString('heightMeasurementId');

    return {
      'heightValue': heightValue,
      'heightMeasurementId': heightMeasurementId,
    };
  }

  Future<void> saveWeightData(
      String weightValue, String weightMeasurementId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('weightValue', weightValue);
    await prefs.setString('weightMeasurementId', weightMeasurementId);
    log(weightValue);
    log(weightMeasurementId);
  }

  Future<Map<String, dynamic>> getWeightData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? weightValue = prefs.getString('weightValue');
    String? weightMeasurementId = prefs.getString('weightMeasurementId');

    return {
      'weightValue': weightValue,
      'weightMeasurementId': weightMeasurementId,
    };
  }

  Future<void> saveSelectedDiseaseIds(List<String> selectedIds) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('selectedDiseaseIds',
          selectedIds.map((id) => id.toString()).toList());
      log(selectedIds.toString());
    } catch (e) {
      log('Error saving selected disease IDs: $e');
    }
  }

  Future<void> saveActivityLevel(String activitylevelid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('activityLevelId', activitylevelid);

    log(activitylevelid);
  }

  getActivityLevel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? activitylevelid = prefs.getString('activityLevelId');

    return activitylevelid;
  }

  Future<void> saveSelectedWeight(String weight) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedWeight', weight);
    StepsController.i.selectedWeight = weight;
  }

  Future<void> getSelectedWeight() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    StepsController.i.selectedWeight = prefs.getString('selectedWeight') ?? "";
  }

  Future<int?> getSelectedActivity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('selectedActivity');
  }

  Future<void> saveSelectedActivities(List<int> activityIds) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'selectedActivityIds', activityIds.map((id) => id.toString()).toList());
    log('Selected Activity IDs: $activityIds');
  }

  Future<List<int>> getSelectedActivities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? activityIdsString =
        prefs.getStringList('selectedActivityIds');
    if (activityIdsString != null && activityIdsString.isNotEmpty) {
      List<int> activityIds =
          activityIdsString.map((id) => int.parse(id)).toList();
      return activityIds;
    } else {
      return [];
    }
  }

  Future<void> saveSelectedDiseases(List<int> selectedDiseaseIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('selectedDiseaseIds',
        selectedDiseaseIds.map((id) => id.toString()).toList());
  }

  Future<List<int>> getSelectedDiseases() async {
    final prefs = await SharedPreferences.getInstance();
    final selectedIds = prefs.getStringList('selectedDiseaseIds') ?? [];
    return selectedIds.map((id) => int.parse(id)).toList();
  }

  void loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int storedCounter = prefs.getInt('waterCounter') ?? 0;

    HealthInsightsController.i.counter = storedCounter;
  }

  void onContainerTap(String waterActivityId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedWaterActivityId', waterActivityId);

    HealthInsightsController.i.setSelectedWaterActivityId(waterActivityId);
  }

  void saveDailyDataToLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String today = DateTime.now().toString().split(' ')[0];

    await prefs.setInt('$today-steps', HealthInsightsController.i.steps);
    await prefs.setInt('$today-calories', HealthInsightsController.i.calories);
    await prefs.setDouble(
        '$today-distance', HealthInsightsController.i.distance);
    await prefs.setInt(
        '$today-heartRate', HealthInsightsController.i.heartRate);
  }

  static const String _keyPrefix = 'daily_step_count_';

  static Future<void> saveDailyStepCount(String dayOfWeek, int steps) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('$_keyPrefix$dayOfWeek', steps);
  }

  static Future<int> fetchDailyStepCount(String dayOfWeek) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('$_keyPrefix$dayOfWeek') ?? 0;
  }

  Future<void> loadSelectedPackageId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SubscriptionController.i.selectedPackageId =
        prefs.getString('selectedPackageId');
  }

  Future<void> saveSelectedPackageId(String packageId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedPackageId', packageId);
    SubscriptionController.i.selectedPackageId = packageId;
  }

  Future<void> loadSelectedIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SubscriptionController.i.selectedIndex = prefs.getInt('selectedIndex') ?? 0;
  }

  Future<void> saveSelectedIndex(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedIndex', index);
    SubscriptionController.i.selectedIndex = index;
  }

  Future<void> saveSelectedGymId(String gymId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedGymId', gymId);
  }

  Future<String?> getSelectedGymId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedGymId');
  }

  Future<void> saveSelectedGymCategoryId(String catogeryId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('GymExerciseCategoryId', catogeryId);
  }

  Future<String?> getSelectedGymCategoryId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('GymExerciseCategoryId');
  }

  Future<void> saveSelectedVideoId(String videoId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('GymVideoId', videoId);
  }

  Future<String?> getSelectedVideoId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('GymVideoId');
  }

  Future<void> setMoveGoal(int goal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('move_goal', goal);
  }

  Future<int?> getMoveGoal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('move_goal');
  }

  Future<void> saveSelectedCategoryId(String? categoryId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (categoryId != null) {
      await prefs.setString('selected_category_id', categoryId);
    } else {
      await prefs.remove('selected_category_id');
    }
  }

  Future<String?> getSelectedCategoryId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('selected_category_id');
  }
}
