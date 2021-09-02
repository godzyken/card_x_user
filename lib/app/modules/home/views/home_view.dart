import 'package:card_x_user/app/modules/auth/views/auth_view.dart';
import 'package:card_x_user/app/modules/avatar/views/avatar_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (_) => _.fireStoreUser.auth.currentUser?.uid == null
            ? AuthView()
            : Scaffold(
                appBar: AppBar(
                  title: Text('Home'.tr),
                  actions: [
                    IconButton(
                        onPressed: () => Get.toNamed('/settings'),
                        icon: Icon(Icons.settings)),
                  ],
                  automaticallyImplyLeading: true,
                ),
                drawer: Drawer(
                  child: ListView(
                    children: [
                      Container(
                        child: UserAccountsDrawerHeader(
                          currentAccountPicture: AvatarView(),
                          accountName: Text('Name: '.tr +
                              _.fireStoreUser.fireStoreUser.value!.name!),
                          accountEmail: Text('Email: '.tr +
                              _.fireStoreUser.fireStoreUser.value!.email),
                        ),
                      ),
                      ListTile(
                        title: Text('My Files'.tr),
                      ),
                      ListTile(
                        title: Text('Contacts'.tr),
                      ),
                      ListTile(
                        title: Text('Starred'.tr),
                      ),
                      ListTile(
                        title: Text('location'.tr),
                      ),
                      ListTile(
                        title: Text('Video Call'.tr),
                      ),
                      ListTile(
                        title: Text('Uploads'.tr),
                      ),
                      ListTile(
                        title: Text('BackUps'.tr),
                      ),
                      ListTile(
                        title: Text('My Card'.tr),
                      ),
                    ],
                  ),
                ),
                body: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/marlonW.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      verticalDirection: VerticalDirection.up,
                      children: <Widget>[
                        SizedBox(
                          height: 8,
                        ),

                      ],
                    ),
                  ),
                ),
              ));
  }
}
