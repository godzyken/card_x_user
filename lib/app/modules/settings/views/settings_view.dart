import 'package:card_x_user/app/modules/settings/controllers/language_controller.dart';
import 'package:card_x_user/app/modules/settings/views/drop_down_piker_view.dart';
import 'package:card_x_user/app/modules/settings/views/segmented_selector_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/settings_controller.dart';
import '../globals.dart';
import '../menu_options_model.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings View'.tr),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          languageListTitle(context),
          themeListTile(context),
          ListTile(
            title: Text('Update Profile'.tr),
            trailing: ElevatedButton(
              onPressed: () => Get.toNamed('/update-profile'),
              child: Text('Update profile'.tr),
            ),
          ),
          ListTile(
            title: Text('Sign Out'.tr),
            trailing: ElevatedButton(
              onPressed: () => controller.signOut,
              child: Text('Sign Out'),
            ),
          ),
        ],
      ),
    );
  }

  languageListTitle(BuildContext context) {
    return GetBuilder<LanguageController>(
        builder: (_) => ListTile(
              title: Text('language'.tr),
              trailing: DropDownPikerView(
                menuOptions: Globals.languageOptions,
                selectedOption: _.currentLanguage,
                onChanged: (value) async {
                  await _.updateLanguage(value!);
                  Get.forceAppUpdate();
                },
              ),
            ));
  }

  themeListTile(BuildContext context) {
    final List<MenuOptionsModel> themeOptions = [
      MenuOptionsModel(
          key: "system", value: "system".tr, icon: Icons.brightness_4),
      MenuOptionsModel(
          key: "light", value: "light".tr, icon: Icons.brightness_low),
      MenuOptionsModel(key: "dark", value: "dark".tr, icon: Icons.brightness_3),
    ];
    return GetBuilder<SettingsController>(
        builder: (_) => ListTile(
              title: Text('theme'.tr),
              trailing: SegmentedSelectorView(
                selectedOption: _.currentTheme,
                menuOptions: themeOptions,
                onValueChanged: (value) => _.setThemeMode(value),
              ),
            ));
  }
}
