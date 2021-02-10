import 'package:camera/camera.dart';
import 'package:card_x_user/core/constants/constants.dart';
import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/localizations.dart';
import 'package:card_x_user/ui/components/components.dart';
import 'package:card_x_user/ui/pages/conference/conference.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart'
    show ArCoreController;

List<CameraDescription> cameras = [];

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    Get.put<AuthController>(AuthController());
    Get.put<ThemeController>(ThemeController());
    Get.put<LanguageController>(LanguageController());
    print('ARCORE IS AVAILABLE?');
    print(await ArCoreController.checkArCoreAvailability());
    print('\nAR SERVICES INSTALLED?');
    print(await ArCoreController.checkIsArCoreInstalled());
    cameras = await availableCameras();
    await GetStorage.init();
    await Firebase.initializeApp();
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }
  // FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
/*  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeController.to.getThemeModeFromStore();
    return GetBuilder<LanguageController>(
      builder: (languageController) => Loading(
        child: GetMaterialApp(
          //begin language translation stuff
          // https://github.com/aloisdeniel/flutter_sheet_localization
          locale: languageController.getLocale,
          // <- Current locale
          localizationsDelegates: [
            const AppLocalizationsDelegate(), // <- Your custom delegate
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.languages.keys.toList(),
          // <- Supported locales
          //end language translation stuff
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
          ],
          debugShowCheckedModeBanner: false,
          //defaultTransition: Transition.fade,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: ThemeMode.system,
          initialRoute: "/",
          getPages: AppRoutes.routes,
        ),
      ),
    );
  }
}
