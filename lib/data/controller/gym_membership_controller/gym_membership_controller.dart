import 'dart:core';
import 'package:get/get.dart';
import 'package:longevity_hub/models/gym_memberships_model/get_catogery_model.dart';
import 'package:longevity_hub/models/gym_memberships_model/get_gym_model.dart';
import 'package:longevity_hub/models/gym_memberships_model/get_gym_video_model.dart';
import 'package:longevity_hub/models/gym_memberships_model/get_trainer_model.dart';
import 'package:longevity_hub/models/gym_memberships_model/review_model.dart';

class GymMembershipController extends GetxController implements GetxService {
  bool isLoading = false;
  Duration videoDuration = Duration.zero;
  void updateIsLoading(bool value) {
    isLoading = value;
    update();
  }

  void setVideoDuration(Duration duration) {
    videoDuration = duration;
    update();
  }

  List<Data> gymData = [];
  void getGyms(List<Data>? gym) {
    if (gym != null) {
      gymData = gym;
    } else {
      gymData = [];
    }
    update();
  }

  List<TrainersData> trrainersData = [];
  void getTrainers(List<TrainersData>? trainer) {
    if (trainer != null) {
      trrainersData = trainer;
    } else {
      trrainersData = [];
    }
    update();
  }

  List<VideoData> videoData = [];
  void getGymVideo(List<VideoData>? video) {
    if (video != null) {
      videoData = video;
    } else {
      videoData = [];
    }
    update();
  }

  List<CatogaryData> catogaryData = [];
  void getCatogary(List<CatogaryData>? catogary) {
    if (catogary != null) {
      catogaryData = catogary;
    } else {
      catogaryData = [];
    }
    update();
  }

  List<ReviewData> reviewData = [];
  void getReview(List<ReviewData>? review) {
    if (review != null) {
      reviewData = review;
    } else {
      reviewData = [];
    }
    update();
  }

  static GymMembershipController get i => Get.put(GymMembershipController());
}
