import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:longevity_hub/data/controller/profile_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/dashboard_screens/dashboard.dart';
import 'package:longevity_hub/screens/dashboard_screens/menu_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      dragOffset: 40,
      controller: ProfileController.i.zoomDrawerController,
      showShadow: true,
      shadowLayer2Color: ColorManager.kWhiteColor,
      menuBackgroundColor: ColorManager.kWhiteColor,
      angle: 0,
      slideWidth: Get.width * 0.7,
      drawerShadowsBackgroundColor: ColorManager.kWhiteColor,
      menuScreen: const MenuScreen(),
      mainScreen: const DashBoard(),
    );
  }
}
