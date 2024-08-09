// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:async';
import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/models/heallth_insights_model/sleep_rewards_model.dart';
import 'package:longevity_hub/models/heallth_insights_model/steps_reward_model.dart';
import 'package:longevity_hub/models/heallth_insights_model/user_sleep_model.dart';
import 'package:longevity_hub/models/heallth_insights_model/user_steps_level_model.dart';
import 'package:longevity_hub/models/heallth_insights_model/user_water_level_model.dart';
import 'package:longevity_hub/models/heallth_insights_model/user_workout_model.dart';
import 'package:longevity_hub/models/heallth_insights_model/water_category_model.dart';
import 'package:longevity_hub/models/heallth_insights_model/water_detail_model.dart';
import 'package:longevity_hub/models/heallth_insights_model/water_intake_model.dart';
import 'package:longevity_hub/models/heallth_insights_model/water_rewards_model.dart';
import 'package:longevity_hub/models/heallth_insights_model/workout_rewards_model.dart';
import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;

class HealthInsightsController extends GetxController implements GetxService {
  final bool isLocked = false;
  final TextEditingController goalController = TextEditingController(text: '1');
  String selecetedrate = "";
  String selectedContainer = "Daily";
  String _selectedWaterActivityId = '';
  GetIntakeWaterModel? intakeWaterModel;
  int counter = 0;
  String get selectedWaterActivityId => _selectedWaterActivityId;
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  TextEditingController waterQuantityCont = TextEditingController();
  int steps = 0;
  String status = 'Stopped';
  double distance = 0.0;
  int calories = 0;
  int heartRate = 0;
  int goal = 0;

  bool isLoading = true;
  List<Data> waterActivities = [];
  Timer? updateTimer;
  Timer? resetTimer;

  @override
  void onInit() {
    super.onInit();
    initPlatformState();

    updateTimer = Timer.periodic(const Duration(seconds: 2), (Timer t) {
      LocalDb().saveDailyDataToLocal();
    });

    tz.initializeTimeZones();
    scheduleMidnightReset();
  }

  @override
  void onClose() {
    updateTimer?.cancel();
    resetTimer?.cancel();
    super.onClose();
  }

  void scheduleMidnightReset() {
    DateTime now = DateTime.now();
    DateTime nextMidnight = DateTime(now.year, now.month, now.day + 1);
    Duration timeUntilMidnight = nextMidnight.difference(now);

    resetTimer = Timer(timeUntilMidnight, () {
      saveDailyStepCount();
      steps = 0;
      update();
      scheduleMidnightReset();
    });
  }

  Future<void> fetchGoal() async {
    goal = (await LocalDb().getMoveGoal())!;
    update();
  }

  void saveDailyStepCount() {
    DateTime now = DateTime.now();
    String dayOfWeek = _getDayOfWeek(now.weekday);

    dailyStepCounts[dayOfWeek] = steps; // Assuming steps is updated elsewhere
    LocalDb.saveDailyStepCount(dayOfWeek, steps);
  }

  Map<String, int> dailyStepCounts = {
    'Monday': 0,
    'Tuesday': 0,
    'Wednesday': 0,
    'Thursday': 0,
    'Friday': 0,
    'Saturday': 0,
    'Sunday': 0,
  };
  int achievedGoals = 0;

  Future<void> fetchDailyStepCounts() async {
    bool? isFirstTime = await LocalDb().getIsFirstTime();

    if (isFirstTime == null || isFirstTime) {
      dailyStepCounts.updateAll((key, value) => 0);

      // Save that it is no longer the first time
      await LocalDb().saveIsFirstTime(false);
    } else {
      for (var day in dailyStepCounts.keys) {
        int steps = await LocalDb.fetchDailyStepCount(day);
        dailyStepCounts[day] = steps;
      }
    }

    update();
  }

  void checkGoal() {
    if (calories >= goal) {
      achievedGoals++;
      update();
    }
  }

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  void setSelectedWaterActivityId(String waterActivityId) {
    _selectedWaterActivityId = waterActivityId;
    update();
  }

  void setIntakeWaterModel(GetIntakeWaterModel model) {
    intakeWaterModel = model;
    update();
  }

  void updateIsLoading(bool value) {
    isLoading = value;
    update();
  }

  List<CategoryData> categoryData = [];
  void getWaterCatogery(List<CategoryData>? category) {
    categoryData = category ?? [];
    update();
  }

  void setWaterActivities(List<Data>? activities) {
    waterActivities = activities ?? [];
    update();
  }

  Future<void> initPlatformState() async {
    try {
      // Fetch the stored value of isFirstTime
      bool? isFirstTime = await LocalDb().getIsFirstTime();

      // Fetch the user ID from the local database
      String? userId = await LocalDb().getUserid();

      // If userId is null, generate a new one and save it in SharedPreferences
      if (userId == null) {
        userId = 'new_user_id';
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('UserId', userId);

        // Since it's a new user, also save the step count as 0
        await prefs.setInt('step_count_$userId', 0);
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      int currentStepCount = 0;

      // Check if this is the first time the user is using the app
      if (isFirstTime == true) {
        // Start with 0 steps
        currentStepCount = 0;
        await prefs.setInt('step_count_$userId', 0);
        // Update isFirstTime to false since the app has been initialized
        await LocalDb().saveIsFirstTime(false);
      } else {
        // Continue with the previous step count
        currentStepCount = prefs.getInt('step_count_$userId') ?? 0;
      }

      print('Current step count for user $userId: $currentStepCount');

      // Set up the step and pedestrian status streams
      _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
      _stepCountStream = Pedometer.stepCountStream;

      _stepCountStream.listen((event) {
        onStepCount(event, userId);
      }).onError(onStepCountError);

      _pedestrianStatusStream
          .listen(onPedestrianStatusChanged)
          .onError(onPedestrianStatusError);
    } catch (e) {
      print('Error initializing streams: $e');
    }

    // Check if the date has changed and reset data accordingly
    _checkAndResetDataIfNewDay();
  }

  DateTime? lastUpdatedDate;
  void _checkAndResetDataIfNewDay() {
    DateTime now = DateTime.now();
    if (lastUpdatedDate == null || now.day != lastUpdatedDate!.day) {
      steps = 0;
      calories = 0;
      distance = 0.0;
      heartRate = 0;
      achievedGoals = 0;
      status = "Inactive";
      lastUpdatedDate = now;
      update();
    }
  }

  void onStepCount(StepCount event, String? userId) {
    steps = event.steps;
    _checkAndResetDataIfNewDay();
    distance = double.parse((steps * 0.0008).toStringAsFixed(2));
    calories = (steps * 0.04).toInt();
    heartRate = (steps * 0.1).toInt();

    print('New step count: ${event.steps} at ${event.timeStamp}');
    update();
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    status = event.status;

    print('New pedestrian status: ${event.status} at ${event.timeStamp}');
    update();
  }

  void onStepCountError(dynamic error) {
    print('Step Count Error: $error');
    update();
  }

  void onPedestrianStatusError(dynamic error) {
    print('Pedestrian Status Error: $error');
    update();
  }

  int totalSteps = 0;
  int avgSteps = 0;
  double totalDistance = 0.0;
  double walkingPercentage = 0.0;
  double runningPercentage = 0.0;
  double totalPercentage = 0.0;
  String formattedTotalPercentage = "0.0";
  String formattedtotalDistance = "0.0";
  String formattedWalkingPercentage = "0.0";
  String formattedRunningPercentage = "0.0";

  Future<void> fetchWeeklyData() async {
    DateTime now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    DateTime endOfMonth = DateTime(now.year, now.month + 1, 0);

    DateTime startOfWeek = startOfMonth;

    while (startOfWeek.isBefore(endOfMonth) ||
        startOfWeek.isAtSameMomentAs(endOfMonth)) {
      await fetchWeeklyDataForDay(startOfWeek);
      startOfWeek = startOfWeek.add(const Duration(days: 7));
    }

    update();
  }

  Future<void> fetchWeeklyDataForDay(DateTime day) async {
    DateTime startOfWeek = day.subtract(Duration(days: day.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    int weekNumber = ((startOfWeek.day - 1) ~/ 7) + 1;
    String weekKey = 'Week $weekNumber';

    int totalStepsForWeek = 0;
    int totalDistanceForWeek = 0;

    while (startOfWeek.isBefore(endOfWeek) ||
        startOfWeek.isAtSameMomentAs(endOfWeek)) {
      String dayOfWeek = DateFormat('EEEE').format(startOfWeek);
      int steps = await LocalDb.fetchDailyStepCount(dayOfWeek);
      totalStepsForWeek += steps;
      totalDistanceForWeek += (steps * 0.0008).toInt();

      double percentage = (steps / 100000) * 100;
      weeklyStepPercentages[weekKey]![dayOfWeek] = percentage;

      startOfWeek = startOfWeek.add(const Duration(days: 1));
    }

    totalSteps = totalStepsForWeek;
    avgSteps = totalStepsForWeek ~/ 7;
    totalDistance = totalDistanceForWeek.toDouble();
    walkingPercentage = min((totalStepsForWeek / 10000) * 100, 100);
    runningPercentage = min((totalStepsForWeek / 70000) * 100, 100);
    totalPercentage = min((totalStepsForWeek / 10000) * 100, 100);

    formattedWalkingPercentage = walkingPercentage.toStringAsFixed(1);
    formattedRunningPercentage = runningPercentage.toStringAsFixed(1);
    formattedTotalPercentage = totalPercentage.toStringAsFixed(1);
    formattedtotalDistance = totalDistance.toStringAsFixed(1);

    update();
  }

  Map<String, Map<String, double>> weeklyStepPercentages = {
    'Week 1': {
      'Monday': 0.0,
      'Tuesday': 0.0,
      'Wednesday': 0.0,
      'Thursday': 0.0,
      'Friday': 0.0,
      'Saturday': 0.0,
      'Sunday': 0.0
    },
    'Week 2': {
      'Monday': 0.0,
      'Tuesday': 0.0,
      'Wednesday': 0.0,
      'Thursday': 0.0,
      'Friday': 0.0,
      'Saturday': 0.0,
      'Sunday': 0.0
    },
    'Week 3': {
      'Monday': 0.0,
      'Tuesday': 0.0,
      'Wednesday': 0.0,
      'Thursday': 0.0,
      'Friday': 0.0,
      'Saturday': 0.0,
      'Sunday': 0.0
    },
    'Week 4': {
      'Monday': 0.0,
      'Tuesday': 0.0,
      'Wednesday': 0.0,
      'Thursday': 0.0,
      'Friday': 0.0,
      'Saturday': 0.0,
      'Sunday': 0.0
    },
    'Week 5': {
      'Monday': 0.0,
      'Tuesday': 0.0,
      'Wednesday': 0.0,
      'Thursday': 0.0,
      'Friday': 0.0,
      'Saturday': 0.0,
      'Sunday': 0.0
    },
  };

  List<SleepRewardData> sleepLevel = [];
  void getsleepLevels(List<SleepRewardData>? sleeprewardlevel) {
    if (sleeprewardlevel != null) {
      sleepLevel = sleeprewardlevel;
    } else {
      sleepLevel = [];
    }
    update();
  }

  List<StepsRewardData> stepsLevel = [];
  void getstepsLevels(List<StepsRewardData>? stepsrewardlevel) {
    if (stepsrewardlevel != null) {
      stepsLevel = stepsrewardlevel;
    } else {
      stepsLevel = [];
    }
    update();
  }

  List<WorkoutRewardData> workoutLevel = [];
  void getWorkoutLevels(List<WorkoutRewardData>? workoutRewardLevel) {
    if (workoutRewardLevel != null) {
      workoutLevel = workoutRewardLevel;
    } else {
      workoutLevel = [];
    }
    update();
  }

  List<WaterRewardData> waterlevel = [];
  void getwaterLevels(List<WaterRewardData>? waterRewardLevel) {
    if (waterRewardLevel != null) {
      waterlevel = waterRewardLevel;
    } else {
      waterlevel = [];
    }
    update();
  }

  List<WaterUserData> waterlevelUser = [];
  void getuserWaterActivityLevel(List<WaterUserData>? waterUserLevel) {
    if (waterUserLevel != null) {
      waterlevelUser = waterUserLevel;
    } else {
      waterlevelUser = [];
    }
    update();
  }

  List<UserStepsData> stepslevelUser = [];
  void getuserStepsActivityLevel(List<UserStepsData>? stepsUserLevel) {
    if (stepsUserLevel != null) {
      stepslevelUser = stepsUserLevel;
    } else {
      stepslevelUser = [];
    }
    update();
  }

  List<UserSleepData> sleeplevelUser = [];
  void getuserSleepActivityLevel(List<UserSleepData>? sleepUserLevel) {
    if (sleepUserLevel != null) {
      sleeplevelUser = sleepUserLevel;
    } else {
      sleeplevelUser = [];
    }
    update();
  }

  List<UserWorkoutData> workoutlevelUser = [];
  void getuserworkoutActivityLevel(List<UserWorkoutData>? workoutUserLevel) {
    if (workoutUserLevel != null) {
      workoutlevelUser = workoutUserLevel;
    } else {
      workoutlevelUser = [];
    }
    update();
  }

  static HealthInsightsController get i => Get.put(HealthInsightsController());
}
