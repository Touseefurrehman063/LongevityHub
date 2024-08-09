// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:longevity_hub/screens/Introduction_screens/introduction_screen.dart';
import 'package:longevity_hub/screens/auth_screens/login.dart';
import '../../data/localDB/local_db.dart';
import '../dashboard_screens/menu_drawer.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:new_version_plus/new_version_plus.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    NewVersionPlus newVersion = NewVersionPlus();
    advancedStatusCheck(newVersion);
    initialize();
    super.initState();
  }

  void initialize() async {
    await Future.delayed(const Duration(seconds: 4));
    FlutterNativeSplash.remove();
  }

  advancedStatusCheck(NewVersionPlus newVersion) async {
    try {
      final status = await newVersion.getVersionStatus();
      if (status != null) {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        debugPrint(status.releaseNotes);
        debugPrint(status.appStoreLink);
        debugPrint(status.localVersion);
        debugPrint(status.storeVersion);
        debugPrint(status.canUpdate.toString());
        if (status.canUpdate) {
          newVersion.showUpdateDialog(
            context: context,
            versionStatus: status,
            dialogTitle: 'Update Required',
            dialogText:
                "${packageInfo.appName} requires a new Update ${status.storeVersion}",
            launchModeVersion: LaunchModeVersion.external,
            allowDismissal: false,
          );
        } else {
          bool? isFirstStatus;
          await LocalDb()
              .getIsFirstTime()
              ?.then((value) => isFirstStatus = value);
          bool? loginStatus;
          await LocalDb()
              .getLoginStatus()
              ?.then((value) => loginStatus = value);
          // if (isFirstStatus != null && isFirstStatus == false) {
          //   if (loginStatus == true) {
          //     Get.offAll(() => const DrawerScreen());
          //   } else {
          //     Get.offAll(() => const LoginScreen());
          //   }
          // } else {
          //   Get.offAll(() => const IntroductionScreens());
          // }
          if (isFirstStatus == true || isFirstStatus == null) {
            Get.offAll(() => const IntroductionScreens());
          } else if (isFirstStatus == false &&
              (loginStatus == false || loginStatus == null)) {
            Get.offAll(() => const LoginScreen());
          } else if (isFirstStatus == false && loginStatus == true) {
            Get.offAll(() => const DrawerScreen());
          }
        }
      } else {
        bool? isFirstStatus;
        await LocalDb()
            .getIsFirstTime()
            ?.then((value) => isFirstStatus = value);
        bool? loginStatus;
        await LocalDb().getLoginStatus()?.then((value) => loginStatus = value);
        if (isFirstStatus == true || isFirstStatus == null) {
          Get.offAll(() => const IntroductionScreens());
        } else if (isFirstStatus == false && loginStatus == false) {
          Get.offAll(() => const LoginScreen());
        } else if (isFirstStatus == false && loginStatus == true) {
          Get.offAll(() => const DrawerScreen());
        }
      }
    } catch (e) {
      log(e.toString());
      bool? isFirstStatus;
      await LocalDb().getIsFirstTime()?.then((value) => isFirstStatus = value);
      bool? loginStatus;
      await LocalDb().getLoginStatus()?.then((value) => loginStatus = value);
      if (isFirstStatus == true || isFirstStatus == null) {
        Get.offAll(() => const IntroductionScreens());
      } else if (isFirstStatus == false && loginStatus == false) {
        Get.offAll(() => const LoginScreen());
      } else if (isFirstStatus == false && loginStatus == true) {
        Get.offAll(() => const DrawerScreen());
      }
    } finally {
      bool? isFirstStatus = await LocalDb().getIsFirstTime();
      bool? loginStatus = await LocalDb().getLoginStatus();

      if (isFirstStatus == true || isFirstStatus == null) {
        Get.offAll(() => const IntroductionScreens());
      } else if (isFirstStatus == false &&
          (loginStatus == false || loginStatus == null)) {
        Get.offAll(() => const LoginScreen());
      } else if (isFirstStatus == false && loginStatus == true) {
        Get.offAll(() => const DrawerScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
