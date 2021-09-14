import 'package:card_x_user/app/modules/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/settings_controller.dart';
import '../menu_options_model.dart';

class SettingsView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.lightbulb),
              onPressed: () {
                print('sa marche ou pas?');
                Get.isDarkMode
                    ? Get.changeTheme(ThemeData.light())
                    : Get.changeTheme(ThemeData.dark());
              })
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            ListTile(
              title: Text('Update Profile'.tr),
              trailing: ElevatedButton(
                  onPressed: () => Get.toNamed('/update-profile'),
                  child: Text('update Profile')),
            ),
            ListTile(
              title: Text('Sign Out!'.tr),
              trailing: ElevatedButton(
                  onPressed: () {
                    print('sa marche ou pas?');
                    AuthController.to!.signOut();
                  },
                  child: Text('Sign out!')),
            ),
          ],
        ),
      ),
    );
  }
}
