import 'package:card_x_user/core/constants/globals.dart';
import 'package:card_x_user/core/controllers/auth_controller.dart';
import 'package:card_x_user/core/controllers/language_controller.dart';
import 'package:card_x_user/core/controllers/theme_controller.dart';
import 'package:card_x_user/core/models/menu_option_model.dart';
import 'package:card_x_user/localizations.dart';
import 'package:card_x_user/ui/auth/auth.dart';
import 'package:card_x_user/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsUI extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(labels.settings.title),
      ),
      body: _buildLayoutSection(context),
    );
  }

  Widget _buildLayoutSection(BuildContext context) {
    final labels = AppLocalizations.of(context);

    return ListView(
      children: <Widget>[
        languageListTile(context),
        themeListTile(context),
        ListTile(
            title: Text(labels.settings.updateProfile),
            trailing: ElevatedButton(
              onPressed: () async {
                Get.to(UpdateProfileUI());
              },
              child: Text(
                labels.settings.updateProfile,
              ),
            )),
        ListTile(
          title: Text(labels.settings.signOut),
          trailing: ElevatedButton(
            onPressed: () {
              AuthController.to.signOut();
            },
            child: Text(
              labels.settings.signOut,
            ),
          ),
        )
      ],
    );
  }

  languageListTile(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return GetBuilder<LanguageController>(
      builder: (controller) => ListTile(
        title: Text(labels.settings.language),
        trailing: DropdownPicker(
          menuOptions: Globals.languageOptions,
          selectedOption: controller.currentLanguage,
          onChanged: (value) async {
            await controller.updateLanguage(value);
            Get.forceAppUpdate();
          },
        ),
      ),
    );
  }

  themeListTile(BuildContext context) {
    final labels = AppLocalizations.of(context);
    final List<MenuOptionsModel> themeOptions = [
      MenuOptionsModel(
          key: "system",
          value: labels.settings.system,
          icon: Icons.brightness_4),
      MenuOptionsModel(
          key: "light",
          value: labels.settings.light,
          icon: Icons.brightness_low),
      MenuOptionsModel(
          key: "dark", value: labels.settings.dark, icon: Icons.brightness_3)
    ];
    return GetBuilder<ThemeController>(
      builder: (controller) => ListTile(
        title: Text(labels.settings.theme),
        trailing: SegmentedSelector(
          selectedOption: controller.currentTheme,
          menuOptions: themeOptions,
          onValueChanged: (value) {
            controller.setThemeMode(value);
          },
        ),
      ),
    );
  }
}
