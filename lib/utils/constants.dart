import 'dart:ui';
import 'package:get/get.dart';
import 'package:longevity_hub/models/language_model.dart';

// String baseURL = 'https://patient.helpful.ihealthcure.com';
String baseURL = 'https://api.longevity.ihealthcure.com';
// String baseURL = 'http://192.168.88.254:328';
String contactNumber = '';
String appName = 'Longevity Hub';
String username = '';
String sandboxUrl = "https://int.api.service.nhs.uk";

class AppConstants {
  String apikey = 'fMx1my7tZHFcANgAttSx9ycwjGa0hDKa';
  static String updateimage = '$baseURL/api/doctor/UpdateImage';
  static String login = '$baseURL/api/Longivity/login';
  static String signup = '$baseURL/api/Longivity/SignUp';
  static String notification = '$baseURL/api/account/GetUserNotifications';
  static String getgenders = '$baseURL/api/Longivity/GetGenders';
  static String getheight = '$baseURL/api/Longivity/GetHeightMeasurements';
  static String getweight = '$baseURL/api/Longivity/GetWeightMeasurements';
  static String getphysicalactivitylevel =
      '$baseURL/api/Longivity/GetPhysicalActivityLevel';
  static String getphysicalactivities =
      '$baseURL/api/Longivity/GetPhysicalActivities';
  static String getdiseases = '$baseURL/api/Longivity/GetDisease';
  static String introupdateprofile =
      '$baseURL/api/Longivity/IntroductionUpdateProfile';
  static String getprofiledetail = '$baseURL/api/Longivity/GetProfileDetail';
  static String updateprofile = '$baseURL/api/Longivity/UpdateProfile';
  static String consentagreement =
      '$baseURL/api/Longivity/UpdateConsentAgrementStatus';
  static String forgetemailverify =
      '$baseURL/api/Longivity/ForgetEmailVerification';
  static String otpverification = '$baseURL/api/Longivity/OTPVerification';
  static String resetforgetpassword =
      '$baseURL/api/Longivity/ResetForgetPassword';
  static String changePassword = '$baseURL/api/Longivity/ChangePassword';

  static String updatePackageSubscriptionPlan =
      '$baseURL/api/Longivity/UpdatePackageSubscriptionPlan';
  static String getPackageSubscriptionPlan =
      '$baseURL/api/Longivity/GetPackageSubscriptionPlan';
  static String verifyModuleForUser =
      '$baseURL/api/Longivity/GetMobileAppModuleForUser';
  static String getWaterActivity =
      '$baseURL/api/Longivity/GetHealthInsightWaterActivity';
  static String getIntakeWaterGlassCount =
      '$baseURL/api/Longivity/GetIntakeWaterGlassCount';
  static String getWaterActivityCategories =
      '$baseURL/api/Longivity/GetWaterActivityCategories';
  static String updateHealthInsightWaterActivity =
      '$baseURL/api/Longivity/UpdateHealthInsightWaterActivity';
  static String saveWaterActivity = '$baseURL/api/Longivity/SaveWaterActivity';

  static String getGyms = '$baseURL/api/Longivity/GetGyms';
  static String getsleeplevel = '$baseURL/api/Longivity/GetSleepRewardsLevel';
  static String getWaterActivityRewardsLevel =
      '$baseURL/api/Longivity/GetWaterActivityRewardsLevel';
  static String getWorkoutRewardsLevel =
      '$baseURL/api/Longivity/GetWorkoutRewardsLevel';
  static String getGymTrainers = '$baseURL/api/Longivity/GetGymTrainers';
  static String getStepsRewardsLevel =
      '$baseURL/api/Longivity/GetStepsRewardsLevel';
  static String getUserWaterActivityRewardsLevel =
      '$baseURL/api/Longivity/GetUserWaterActivityRewardsLevel';
  static String getUserStepsActivityRewardsLevel =
      '$baseURL/api/Longivity/GetUserStepsActivityRewardsLevel';
  static String getUserSleepActivityRewardsLevel =
      '$baseURL/api/Longivity/GetUserSleepActivityRewardsLevel';
  static String getUserWorkoutActivityRewardsLevel =
      '$baseURL/api/Longivity/GetUserWorkoutActivityRewardsLevel';

  static String updateUserWaterActivityRewardsLevel =
      '$baseURL/api/Longivity/updateUserWaterActivityRewardsLevel';
  static String saveFootStepActivity =
      '$baseURL/api/Longivity/SaveFootStepActivity';
  static String updateFootStepActivityRewardsLevel =
      '$baseURL/api/Longivity/UpdateFootStepActivityRewardsLevel';

  // static String gymExerciseCategory =
  //     '$baseURL/api/Longivity/GymExerciseCategory';
  static String getUserPackagePlanExpireDate =
      '$baseURL/api/Longivity/GetUserPackagePlanExpireDate';
  static String getGymExerciseVideoCategory =
      '$baseURL/api/Longivity/GetGymExerciseVideoCategory';
  static String getGymTrainerVideo =
      '$baseURL/api/Longivity/GetGymTrainerVideo';
  static String addGymTrainerReview =
      '$baseURL/api/Longivity/AddGymTrainerReview';
  static String getGymTrainerReview =
      '$baseURL/api/Longivity/GetGymTrainerReview';
  static String verifyEmailAddress =
      '$baseURL/api/Longivity/VerifyEmailAddress';
  static String verifyEmailAddressWithCellNumber =
      '$baseURL/api/Longivity/VerifyEmailAddressWithCellNumber';
  static String deleteUserAccount = '$baseURL/api/Longivity/DeleteUserAccount';
  static String logoff = '$baseURL/api/Longivity/Logoff';

  static String getcondition = '$sandboxUrl/nhs-website-content/conditions';

  static String getLiveWellCategories =
      '$sandboxUrl/nhs-website-content/live-well/';
  static List<LanguageModel> languages = [
    LanguageModel(name: 'English', id: 1, locale: const Locale('en', 'US')),
    LanguageModel(name: 'عربي'.tr, id: 2, locale: const Locale('ar', 'SA')),
    // LanguageModel(name: 'اردو'.tr, id: 3, locale: const Locale('ur', 'PK')),
  ];
}
