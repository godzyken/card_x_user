import 'package:card_x_user/app/modules/auth/views/auth_view.dart';
import 'package:card_x_user/app/modules/avatar/views/avatar_view.dart';
import 'package:card_x_user/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (_) => _.authController.auth.currentUser == null
            ? AuthView()
            : Scaffold(
                appBar: AppBar(
                  title: Text('Home'),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Get.rootDelegate.toNamed(Routes.SETTINGS);

                          Get.back(result: '/settings', canPop: true);
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
              ));
  }

  Drawer get customDrawer {
    return Drawer(
      child: ListView(
        children: [
          GetBuilder<HomeController>(
            assignId: true,
            builder: (_) {
              return Container(
                child: UserAccountsDrawerHeader(
                  currentAccountPicture: AvatarView(),
                  accountName: Text('Name: '.tr + _.user!.photoURL!),
                  accountEmail: Text('Email: '.tr + _.user!.email!),
                  onDetailsPressed: () {
                    Get.rootDelegate.toNamed('/update-profile');
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.card_giftcard_sharp),
            title: Text('My Files'.tr),
            onTap: () {
              Get.rootDelegate
                  .toNamed('/card-ui', arguments: GetMiddleware(priority: 2));
              Get.back(canPop: true, result: '/card-ui');
            },
          ),
          ListTile(
            leading: Icon(Icons.scanner),
            title: Text('Scanner'.tr),
            onTap: () {
              Get.rootDelegate
                  .toNamed('/scan-card', arguments: GetMiddleware(priority: 2));
              Get.back(canPop: true, result: '/scan-card');
            },
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
    );
  }
}
