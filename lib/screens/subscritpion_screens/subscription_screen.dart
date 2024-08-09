import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_subscribe_container/custom_subscribe_container.dart';
import 'package:longevity_hub/data/controller/subscription_controller/subscription_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/repositories/subscription_repo/subscription_repo.dart';
import 'package:longevity_hub/screens/dashboard_screens/menu_drawer.dart';
import 'package:longevity_hub/screens/subscritpion_screens/subscription_plan_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart'; // Import BlurryModalProgressHUD

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  late Future<void> getDataFuture;

  @override
  void initState() {
    getDataFuture = SubscriptionRepo.getPackageSubscriptionPlan();
    fetch();
    SubscriptionController.i.fetchPackageExpiryDate();

    super.initState();
  }

  fetch() async {
    await SubscriptionRepo.getPackageExpiryDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.to(() => const DrawerScreen());
          },
          child: Image.asset(
            AppImages.backArrow,
            scale: 10,
            color: ColorManager.kblackColor,
          ),
        ),
        title: Text(
          "subscription".tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: ColorManager.kblackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: Get.width * 0.04),
            child: InkWell(
              onTap: () {
                Get.to(() => const SubscriptionPlanScreen());
              },
              child: Row(
                children: [
                  Image.asset(
                    AppImages.subsicon,
                    scale: 9,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getDataFuture,
        builder: (context, snapshot) {
          return BlurryModalProgressHUD(
            inAsyncCall: snapshot.connectionState == ConnectionState.waiting,
            blurEffectIntensity: 4,
            progressIndicator: const SpinKitSpinningLines(
              color: Color(0xFFFDA11A),
              size: 60,
            ),
            child: _buildContent(snapshot),
          );
        },
      ),
    );
  }

  Widget _buildContent(AsyncSnapshot snapshot) {
    return Stack(
      children: [
        // Background Image
        Positioned.fill(
          child: Image.asset(
            AppImages.background,
            fit: BoxFit.cover,
          ),
        ),
        GetBuilder<SubscriptionController>(builder: (cont) {
          String formattedExpiryDate = cont.expiryDate != null
              ? DateFormat('MMMM d, yyyy').format(cont.expiryDate!)
              : 'validforlifetime'.tr;

          String subscriptionDuration = _getSubscriptionDuration(cont);

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 1,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          CustomSubscribeContainer(
                            centerText: '${"until".tr} $formattedExpiryDate',
                            centerText2: subscriptionDuration,
                            bkColor: const Color.fromARGB(255, 238, 255, 213),
                            buttontext: cont.packageName ?? "basic".tr,
                          ),
                          SizedBox(height: Get.height * 0.02),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: Get.height * 0.03),
              ],
            ),
          );
        }),
      ],
    );
  }

  String _getSubscriptionDuration(SubscriptionController cont) {
    if (cont.remainingYears > 0) {
      return '${cont.remainingYears} ${"yearsubscription".tr}';
    } else if (cont.remainingMonths > 0) {
      return '${cont.remainingMonths} ${"monthsubsricption".tr} ';
    } else {
      return '${cont.remainingDays} ${"daysubscription".tr}';
    }
  }
}
