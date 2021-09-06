import 'dart:ui' as ui;

import 'package:card_x_user/app/modules/settings/services/translatiions/app_translation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logging/logging.dart';

import '../globals.dart';

class LanguageController extends GetxController {
  static LanguageController get to => Get.find();
  final language = "".obs;
  final store = GetStorage();

  String get currentLanguage => language.value;

  @override
  void onReady() async {
    setInitialLocalLanguage();
    super.onReady();
  }

  // Retrieves and Sets language based on device settings
  setInitialLocalLanguage() {
    String? _deviceLanguage = ui.window.locale.toString();
    _deviceLanguage =
        _deviceLanguage.substring(0, 2); //only get 1st 2 characters
    print(ui.window.locale.toString());
    updateLanguage(_deviceLanguage);
  }

// Gets current language stored
  RxString? get currentLanguageStore {
    language.value = store.read('language');
    return language;
  }

  Locale? get getLocale {
    language.value = Globals.defaultLanguage;
    updateLanguage(Globals.defaultLanguage);

    Locale? _updatedLocal = AppTranslationService.locale;

    return _updatedLocal;
  }

  // gets the default language key (from the translation language system)

// updates the language stored
  void updateLanguage(String? value) async {
    try {
      language.value = value!;
      await store.write("language", value);
      Get.updateLocale(getLocale!);
      update();
    } catch (e) {
      Logger.root.severe(e);
    }
  }
}
