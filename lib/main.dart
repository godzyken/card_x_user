import 'package:card_x_user/app/firebase/options.dart';
import 'package:card_x_user/app/modules/scan_card/utils/license.dart';
import 'package:card_x_user/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getxfire/getxfire.dart';
import 'package:scanbot_sdk/scanbot_sdk.dart';
import 'package:scanbot_sdk/scanbot_sdk_models.dart';

import 'app/routes/app_pages.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetxFire.init(
      name: 'card_x_user',
      options: firebaseOptions
  );
  await GetStorage.init();

  await ScanbotSdk.initScanbotSdk(ScanbotSdkConfig(
    loggingEnabled: true,
    licenseKey: licenseKey, // see the license key notes below!
  ));

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      locale: Locale('en', 'FR'),
      fallbackLocale: Locale('en', 'FR'),
      translationsKeys: AppTranslation.translations,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      // smartManagement: SmartManagement.keepFactory,
      // showPerformanceOverlay: true,
      popGesture: Get.isPopGestureEnable,
      transitionDuration: Get.defaultTransitionDuration,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
    ),
  );

  Get.config(
      enableLog: true,
      defaultPopGesture: true,
      defaultTransition: Transition.fade
  );
}
