import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/localizations.dart';
import 'package:card_x_user/ui/components/components.dart';
import 'package:card_x_user/ui/pages/pages_ui.dart';
import 'package:card_x_user/ui/settings_ui.dart';
import 'package:card_x_user/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) => controller?.firestoreUser?.value?.uid == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text(labels?.home?.title),
                actions: [
                  IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        Get.to(SettingsUI());
                      }),
                ],
              ),
              drawer: Drawer(
                child: ListView(
                  children: <Widget>[
                    Container(
                      child: UserAccountsDrawerHeader(
                        currentAccountPicture: Avatar(controller.firestoreUser.value),
                        accountName: Text(
                            labels.home.nameLabel +
                                ': ' +
                                controller.firestoreUser.value.name,
                            style: TextStyle(fontSize: 16)),
                        accountEmail: Text(
                            labels.home.emailLabel +
                                ': ' +
                                controller.firestoreUser.value.email,
                            style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    //TODO Générer la traduction
                    //TODO Créér les routes
                    ListTile(
                      title: Text('My Files'),
                      leading: Icon(Icons.folder),
                      onTap: () => Get.to(MyExplorerUi()),
                    ),
                    ListTile(
                      title: Text('Shared with me'),
                      leading: Icon(Icons.people),
                      onTap: () {
                        print("Clicked");
                      },
                    ),
                    ListTile(
                      title: Text('Starred'),
                      leading: Icon(Icons.star),
                      onTap: () {
                        print("Clicked");
                      },
                    ),
                    ListTile(
                      title: Text('Recent'),
                      leading: Icon(Icons.timer),
                      onTap: () {
                        print("Clicked");
                      },
                    ),
                    ListTile(
                      title: Text('Offline'),
                      leading: Icon(Icons.offline_pin),
                      onTap: () {
                        print("Clicked");
                      },
                    ),
                    ListTile(
                      title: Text('Uploads'),
                      leading: Icon(Icons.file_upload),
                      onTap: () {
                        print("Clicked");
                      },
                    ),
                    ListTile(
                      title: Text('Backups'),
                      leading: Icon(Icons.backup),
                      onTap: () {
                        print("Clicked");
                      },
                    ),
                  ],
                ),
              ),
              body: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 120),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FormVerticalSpace(),
                        Text(
                            labels.home.uidLabel +
                                ': ' +
                                controller.firestoreUser.value.uid,
                            style: TextStyle(fontSize: 16)),
                        FormVerticalSpace(),
                        Text(
                            labels.home.nameLabel +
                                ': ' +
                                controller.firestoreUser.value.name,
                            style: TextStyle(fontSize: 16)),
                        FormVerticalSpace(),
                        Text(
                            labels.home.emailLabel +
                                ': ' +
                                controller.firestoreUser.value.email,
                            style: TextStyle(fontSize: 16)),
                        FormVerticalSpace(),
                        Text(
                            labels.home.adminUserLabel +
                                ': ' +
                                controller.admin.value.toString(),
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
