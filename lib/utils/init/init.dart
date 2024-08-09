import 'package:get/get.dart';
import 'package:longevity_hub/data/controller/auth_controller.dart';
import 'package:longevity_hub/data/controller/ble_controller/ble_conroller.dart';
import 'package:longevity_hub/data/controller/community_controller/community_controller.dart';
import 'package:longevity_hub/data/controller/gym_membership_controller/gym_membership_controller.dart';
import 'package:longevity_hub/data/controller/health_insights_controller/health_insights_controller.dart';
import 'package:longevity_hub/data/controller/language_controller.dart';
import 'package:longevity_hub/data/controller/longevity_store_controller/longevity_store_cont.dart';
import 'package:longevity_hub/data/controller/notification_controller.dart';
import 'package:longevity_hub/data/controller/nutrition_controller/nutrition_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<LanguageController>(LanguageController());
    Get.put<NotificationController>(NotificationController());
    Get.put<NutritionController>(NutritionController());
    Get.put<CommunityController>(CommunityController());
    Get.put<LongevityStoreController>(LongevityStoreController());
    Get.put<HealthInsightsController>(HealthInsightsController());
    Get.put<GymMembershipController>(GymMembershipController());
    Get.put<BleController>(BleController());
  }
}
