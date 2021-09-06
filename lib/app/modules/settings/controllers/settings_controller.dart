import 'package:card_x_user/app/modules/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getxfire/getxfire.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();
  AuthController? authController = Get.find<AuthController>();
  final store = GetStorage();
  final theme = "system".obs;

  ThemeMode? _themeMode;
  get themeMode => _themeMode;
  String? get currentTheme => theme.value;

  bool get isDarkModeOn => store.read('dark') ?? false;

  var signOut;

  late final List<dynamic>? menuOptions;
  late final String? selectedOption;
  late final void Function(dynamic)? onValueChanged;

  @override
  void onInit() {

    super.onInit();
  }

  @override
  void onReady() {
    signOut = authController!.signOut();

    super.onReady();
  }

  @override
  void onClose() {
  }

  ThemeMode getThemeModeFromString(String? themeString) {
    ThemeMode _setThemeMode = ThemeMode.system;
    if (themeString == 'light') {
      _setThemeMode = ThemeMode.light;
    }
    if (themeString == 'dark') {
      _setThemeMode = ThemeMode.dark;
    }
    return _setThemeMode;
  }

  Future<void> setThemeMode(String? value) async {
    theme.value = value!;
    _themeMode = getThemeModeFromString(value);
    Get.changeThemeMode(_themeMode!);
    await store.write('theme', value);
    update();
  }

  getThemeModeFronStore() async {
    String? _themeString;
    setThemeMode(_themeString);
  }

}
