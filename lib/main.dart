import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:longevity_hub/data/controller/language_controller.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/helpers/theme_manager.dart';
import 'package:longevity_hub/models/language_model.dart';
import 'package:longevity_hub/repositories/notification_services_repo/notification_services_repo.dart';
import 'package:longevity_hub/screens/splash_screen/splash_screen.dart';
import 'package:longevity_hub/services/permision_checker.dart';
import 'package:longevity_hub/utils/constants.dart';
import 'package:longevity_hub/utils/init/init.dart';
import 'package:longevity_hub/utils/languages.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    await NotificationsServicesRepo().initLocalNotifications();
    await NotificationsServicesRepo().initNotifications();
    await NotificationsServicesRepo().firebaseInit();
  } catch (e) {
    log('Initialization error: $e');
  }
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    permissionChecker();
    getLocale();
    super.initState();
  }

  getLocale() async {
    LanguageModel? lang = await LocalDb().getLanguage();

    if (lang == null) {
      lang = LanguageModel(
          id: 1,
          name: 'English',
          image: null,
          locale: const Locale('en', 'US'));
      Get.updateLocale(lang.locale!);
      LanguageController.i.selected = AppConstants.languages[0];
    } else {
      Get.updateLocale(lang.locale!);
    }

    if (lang.id == 1) {
      LanguageController.i.selected = AppConstants.languages[0];
    } else if (lang.id == 2) {
      LanguageController.i.selected = AppConstants.languages[1];
    } else {
      LanguageController.i.selected = AppConstants.languages[2];
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return GetMaterialApp(
      textDirection: TextDirection.ltr,
      translations: Localization(),
      locale: const Locale('en', 'US'),
      theme: Styles.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      initialBinding: AppBindings(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
