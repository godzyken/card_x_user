import 'package:flutter/material.dart';


import 'menu_options_model.dart';

class Globals {
  static final String defaultLanguage = 'en';

//List of languages that are supported.  Used in selector.
//Follow this plugin for translating a google sheet to languages
//https://github.com/aloisdeniel/flutter_sheet_localization
//Flutter App translations google sheet
//https://docs.google.com/spreadsheets/d/1oS7iJ6ocrZBA53SxRfKF0CG9HAaXeKtzvsTBhgG4Zzk/edit?usp=sharing

  static final List<MenuOptionsModel> languageOptions = [
    MenuOptionsModel(key: "zh", value: "中文", icon: Icons.update), //Chinese
    MenuOptionsModel(key: "de", value: "Deutsche", icon: Icons.update), //German
    MenuOptionsModel(key: "en", value: "English", icon: Icons.update), //English
    MenuOptionsModel(key: "es", value: "Español", icon: Icons.update), //Spanish
    MenuOptionsModel(key: "fr", value: "Français", icon: Icons.update), //French
    MenuOptionsModel(key: "hi", value: "हिन्दी", icon: Icons.update), //Hindi
    MenuOptionsModel(key: "ja", value: "日本語", icon: Icons.update), //Japanese
    MenuOptionsModel(key: "pt", value: "Português", icon: Icons.update), //Portuguese
    MenuOptionsModel(key: "ru", value: "русский", icon: Icons.update), //Russian
  ];
}
