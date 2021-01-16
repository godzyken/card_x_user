import 'package:card_x_user/core/constants/constants.dart';
import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/localizations.dart';
import 'package:card_x_user/ui/components/components.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Get.put<AuthController>(AuthController());
  Get.put<CardUserController>(CardUserController());
  Get.put<ThemeController>(ThemeController());
  Get.put<LanguageController>(LanguageController());

  await GetStorage.init();
  Firebase.apps;
  FirebaseStorage.instance;
  await Firebase.initializeApp();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeController.to.getThemeModeFromStore();
    return GetBuilder<LanguageController>(
      initState: (state) => Firebase.apps,
      builder: (languageController) => Loading(
        child: GetMaterialApp(
          //begin language translation stuff
          // https://github.com/aloisdeniel/flutter_sheet_localization
          locale: languageController.getLocale, // <- Current locale
          localizationsDelegates: [
            const AppLocalizationsDelegate(), // <- Your custom delegate
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales:
          AppLocalizations.languages.keys.toList(), // <- Supported locales
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
