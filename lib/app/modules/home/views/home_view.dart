import 'package:card_x_user/app/modules/auth/controllers/auth_controller.dart';
import 'package:card_x_user/app/modules/avatar/views/avatar_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed('/settings');
              },
              icon: Icon(Icons.settings)),
        ],
        automaticallyImplyLeading: true,
      ),
      drawerEnableOpenDragGesture: true,
      drawer: customDrawer,
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
    );
  }

  Drawer get customDrawer {
    return Drawer(
      elevation: 16.0,
      child: ListView(
        children: [
          GetBuilder<HomeController>(
              init: HomeController(),
              builder: (_) {
                return Container(
                  color: Colors.transparent,
                  child: UserAccountsDrawerHeader(
                    currentAccountPicture: AvatarView(),
                    currentAccountPictureSize: const Size.square(82.0),
                    accountName: Text(
                      'Name: '.tr +
                          _.authController!.auth.currentUser!.displayName!,
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    accountEmail: Text(
                        'Email: '.tr +
                            _.authController!.auth.currentUser!.email!,
                        style: TextStyle(color: Colors.deepPurple)),
                    onDetailsPressed: () => Get.toNamed('/update-profile'),
                    arrowColor: Colors.red,
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.black12,
                          Colors.yellowAccent,
                        ],
                      ),
                      backgroundBlendMode: BlendMode.softLight,
                    ),
                  ),
                );
              }),
          ListTile(
            leading: Icon(Icons.card_giftcard_sharp),
            title: Text('My Files'.tr),
            onTap: () {
              Get.toNamed('/card-ui');
            },
          ),
          ListTile(
            leading: Icon(Icons.scanner),
            title: Text('Scanner'.tr),
            onTap: () {
              Get.toNamed('/scan-card');
            },
          ),
          ListTile(
            leading: Icon(Icons.list_alt),
            title: Text('Pokemon List card V1'.tr),
            onTap: () {
              Get.toNamed('/pokemon-card-list');
            },
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
            leading: Image.asset('assets/img/pikachu.png'),
            title: Text('My Card'.tr),
            onTap: () {
              Get.toNamed('/pokemon-product');
            },
          ),
        ],
      ),
    );
  }
}
