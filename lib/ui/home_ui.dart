import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/localizations.dart';
import 'package:card_x_user/ui/components/components.dart';
import 'package:card_x_user/ui/pages/conference/conference.dart';
import 'package:card_x_user/ui/pages/favories/favories.dart';
import 'package:card_x_user/ui/pages/locations/locations.dart';
import 'package:card_x_user/ui/settings_ui.dart';
import 'package:card_x_user/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/pages_ui.dart';

class HomeUI extends StatefulWidget {
  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  final TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
                        currentAccountPicture:
                            Avatar(controller.firestoreUser.value),
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
                      title: Text('Contact list'),
                      leading: Icon(Icons.people),
                      onTap: () => Get.to(FavoriesList()),
                    ),
                    ListTile(
                      title: Text('Starred'),
                      leading: Icon(Icons.star),
                      onTap: () {
                        print("Clicked");
                      },
                    ),
                    ListTile(
                      title: Text('location'),
                      leading: Icon(Icons.location_on),
                      onTap: () => Get.to(AddressTarget()),
                    ),
                    ListTile(
                      title: Text('Video Call'),
                      leading: Icon(Icons.video_call),
                      onTap: () => Get.to(RoomPage()),
                    ),
                    ListTile(
                      title: Text('Uploads'),
                      leading: Icon(Icons.file_upload),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text('Backups'),
                      leading: Icon(Icons.backup),
                      onTap: () {
                        print("Clicked");
                      },
                    ),
                    ListTile(
                      title: Text('My Card'),
                      leading: Icon(Icons.account_circle),
                      onTap: () => Get.to(CardProfileUser()),
                    ),
                  ],
                ),
              ),
              body: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/marlonW.jpg'),
                      fit: BoxFit.cover,
                    )
                ),
                child: Center(
                  child: Column(
                    verticalDirection: VerticalDirection.up,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
