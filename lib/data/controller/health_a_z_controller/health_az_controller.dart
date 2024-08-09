import 'dart:developer';
import 'package:get/get.dart';
import 'package:longevity_hub/models/health_model/health_detail_model.dart';
import 'package:longevity_hub/models/health_model/health_model.dart';
import 'package:longevity_hub/models/health_model/live_well_detail_model.dart';
import 'package:longevity_hub/models/health_model/live_well_model.dart';
import 'package:longevity_hub/repositories/health_a_z_repo/health_a_z_repo.dart';

class HealthController extends GetxController implements GetxService {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<HealthAzModel> significantList = [];
  updateIsLoading(bool value) {
    _isLoading = value;
    update();
  }

  List<HealthAzModel> _healthlist = [];
  List<HealthAzModel> get healthlist => _healthlist;
  void updatehealthlist(List<HealthAzModel> healthdata) {
    _healthlist = healthdata;
    // Log the health list for debugging
    log('Updated Health List: ${_healthlist.map((e) => e.toJson()).toList()}');
    update();
  }

  String currentCategory = "A";
  Future<void> fetchSignificantList(currentCategory) async {
    try {
      var list =
          await HealthAtoZRepository().getSignificantLinks(currentCategory);
      significantList = list;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load Diseases');
    }
  }

  HealthDetailModel? details;
  List<HealthDetailModel> healthDetails = [];
  updateMainEntityOfPage(List<HealthDetailModel> mep) {
    healthDetails = mep;
    update();
  }

  List<HealthDetailModel> hasPart = [];
  updatehasPart(List<HealthDetailModel> hp) {
    hasPart = hp;
    update();
  }

  List<LiveWellModel> mainEntityPageList = [];
  void updateMainEntityPageList(List<LiveWellModel> mep) {
    mainEntityPageList = mep;
    log('Updated Main Entity Page List: ${mainEntityPageList.map((e) => e.toJson()).toList()}');
    update();
  }

  Future<void> fetchLiveWellCategories() async {
    updateIsLoading(true);
    try {
      var list = await HealthAtoZRepository().getLiveWellCategories();
      updateMainEntityPageList(list);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load LiveWell Categories');
    } finally {
      updateIsLoading(false);
    }
  }

  List<LiveWellDetailModel> mainEntityPageDetailList = [];
  void updateMainEntityPageDetailList(List<LiveWellDetailModel> mep) {
    mainEntityPageDetailList = mep;
    log('Updated Main Entity Page List: ${mainEntityPageDetailList.map((e) => e.toJson()).toList()}');
    update();
  }

  Future<void> fetchLiveWellDetails(String url) async {
    // updateIsLoading(true);
    try {
      var list = await HealthAtoZRepository().getLiveWellDetail(url: url);

      updateMainEntityPageDetailList(list);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load LiveWell Details');
    } finally {
      // updateIsLoading(false);
    }
  }

  List<LiveWellDetailModel> mainList = [];
  void updateMainList(List<LiveWellDetailModel> mep) {
    mainList = mep;
    log('Updated Main Entity Page List: ${mainList.map((e) => e.toJson()).toList()}');
    update();
  }

  Future<void> fetchDetails(String url) async {
    // updateIsLoading(true);
    try {
      var list = await HealthAtoZRepository().getLiveWellDetail(url: url);

      updateMainList(list);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load LiveWell Details');
    } finally {
      // updateIsLoading(false);
    }
  }

  List<LiveWellDetailModel> maindiscList = [];
  void updateMainDiscList(List<LiveWellDetailModel> mep) {
    maindiscList = mep;
    log('Updated Main Entity Page List: ${maindiscList.map((e) => e.toJson()).toList()}');
    update();
  }

  Future<void> fetchDiscDetails(String url) async {
    // updateIsLoading(true);
    try {
      var list = await HealthAtoZRepository().getLiveWellDetail(url: url);

      updateMainDiscList(list);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load LiveWell Details');
    } finally {
      // updateIsLoading(false);
    }
  }

  List<LiveWellDetailModel> listDiscVideo = [];
  void updateMainVideoList(List<LiveWellDetailModel> mep) {
    listDiscVideo = mep;
    log('Updated Main Entity Page List: ${listDiscVideo.map((e) => e.toJson()).toList()}');
    update();
  }

  Future<void> fetchDiscVideosDetails(String url) async {
    // updateIsLoading(true);
    try {
      var list = await HealthAtoZRepository().getLiveWellDetail(url: url);

      updateMainVideoList(list);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load LiveWell Details');
    } finally {
      // updateIsLoading(false);
    }
  }

  String? disc;
  updatedisc(String? discription) {
    disc = discription;
    update();
  }

  // CausesModel? causes;
  // List<CausesModel> causesDetailList = [];
  // updateCausesDetailList(List<CausesModel> cdl) {
  //   causesDetailList = cdl;
  //   update();
  // }
  static HealthController get i => Get.put(HealthController());
}
