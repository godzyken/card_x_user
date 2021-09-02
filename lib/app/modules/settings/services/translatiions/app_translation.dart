import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'selector.dart';

class AppTranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static final fallbackLocale = Locale('en', 'US');
  @override
  Map<String, Map<String, String>> get keys =>
      {'pt_BR': ptBR, 'en_US': enUs, 'es_MX': esMx, 'fr_EN': frFR};
}