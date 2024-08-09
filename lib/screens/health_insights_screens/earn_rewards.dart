import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/health_insights/reward_container.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/repositories/health_insights_repo/water_detail_repo/health_insights_rewards_repo.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:shimmer/shimmer.dart';

class EarnRewardsScreen extends StatefulWidget {
  const EarnRewardsScreen({super.key});

  @override
  State<EarnRewardsScreen> createState() => _EarnRewardsScreenState();
}

class _EarnRewardsScreenState extends State<EarnRewardsScreen> {
  bool isLoadingSleepLevel = true;
  bool isLoadingStepsLevel = true;
  bool isLoadingWorkoutLevel = true;
  bool isLoadingWaterLevel = true;

  List<dynamic> sleepLevel = [];
  List<dynamic> stepsLevel = [];
  List<dynamic> workoutLevel = [];
  List<dynamic> waterLevel = [];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<void> loadData() async {
    await fetchSleepRewardsLevel();
    await fetchStepsRewardsLevel();
    await fetchWorkoutRewardsLevel();
    await fetchWaterIntakeRewardsLevel();
    HealthInsightsRewardRepo().getIntakeWaterGlassActivity();
    HealthInsightsRewardRepo().getUserWorkoutActivityRewardsLevel();
    HealthInsightsRewardRepo().getUserSleepsActivityRewardsLevel();
    HealthInsightsRewardRepo().getUserStepsActivityRewardsLevel();
  }

  Future<void> fetchSleepRewardsLevel() async {
    setState(() => isLoadingSleepLevel = true);
    sleepLevel = await HealthInsightsRewardRepo().getSleepRewardsLevel();
    setState(() => isLoadingSleepLevel = false);
  }

  Future<void> fetchStepsRewardsLevel() async {
    setState(() => isLoadingStepsLevel = true);
    stepsLevel = await HealthInsightsRewardRepo().getStepsRewardsLevel();
    setState(() => isLoadingStepsLevel = false);
  }

  Future<void> fetchWorkoutRewardsLevel() async {
    setState(() => isLoadingWorkoutLevel = true);
    workoutLevel = await HealthInsightsRewardRepo().getWorkoutRewardsLevel();
    setState(() => isLoadingWorkoutLevel = false);
  }

  Future<void> fetchWaterIntakeRewardsLevel() async {
    setState(() => isLoadingWaterLevel = true);
    waterLevel = await HealthInsightsRewardRepo().getwaterIntakeRewardsLevel();
    setState(() => isLoadingWaterLevel = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Image.asset(
            AppImages.backArrow,
            scale: 10,
            color: ColorManager.kblackColor,
          ),
        ),
        title: Text(
          "rewards".tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: ColorManager.kblackColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.07),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              buildSectionTitle("Sleeping".tr, "Rewards".tr),
              isLoadingSleepLevel
                  ? buildShimmerGrid()
                  : buildRewardsGrid(
                      itemCount: sleepLevel.length,
                      image: AppImages.sleepBadge,
                      rewards: sleepLevel,
                      imageScale: 6.5),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              buildSectionTitle("Steps".tr, "Rewards".tr),
              isLoadingStepsLevel
                  ? buildShimmerGrid()
                  : buildRewardsGrid(
                      itemCount: stepsLevel.length,
                      image: AppImages.stepsbadge,
                      rewards: stepsLevel,
                      imageScale: 4.5),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              buildSectionTitle("WOrkout".tr, "Rewards".tr),
              isLoadingWorkoutLevel
                  ? buildShimmerGrid()
                  : buildRewardsGrid(
                      itemCount: workoutLevel.length,
                      image: AppImages.sleepBadge,
                      rewards: workoutLevel,
                      imageScale: 6.5),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              buildSectionTitle("waterIntake".tr, "Rewards".tr),
              isLoadingWaterLevel
                  ? buildShimmerGrid()
                  : buildRewardsGrid(
                      itemCount: waterLevel.length,
                      image: AppImages.badgeBase2,
                      rewards: waterLevel,
                      imageScale: 8),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title, String subtitle) {
    return Column(
      children: [
        Center(
          child: Text(
            title,
            style: GoogleFonts.poppins(
              color: ColorManager.kblackColor,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Center(
          child: Text(
            subtitle,
            style: GoogleFonts.poppins(
              color: ColorManager.kblackColor,
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
        const Divider(
          color: ColorManager.kblackColor,
          thickness: 1,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
      ],
    );
  }

  Widget buildShimmerGrid() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: MediaQuery.of(context).size.width * 0.02,
          mainAxisSpacing: MediaQuery.of(context).size.height * 0.01,
          childAspectRatio: 0.96,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.white,
          );
        },
      ),
    );
  }

  Widget buildRewardsGrid({
    required int itemCount,
    required String image,
    required List<dynamic> rewards,
    double imageScale = 1.0,
  }) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: MediaQuery.of(context).size.width * 0.02,
        mainAxisSpacing: MediaQuery.of(context).size.height * 0.01,
        childAspectRatio: 0.96,
      ),
      itemBuilder: (BuildContext context, int index) {
        return RewardContainer(
          image: image,
          imageScale: imageScale,
          text: rewards[index].rewardsLevelName ?? "",
          text2: rewards[index].points.toString(),
          isLocked: index != 0,
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: ColorManager.kblackColor,
            fontWeight: FontWeight.w700,
          ),
        );
      },
    );
  }
}
