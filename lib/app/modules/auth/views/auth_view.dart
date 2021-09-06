import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Authentication Services'),
          centerTitle: true,
        ),
        body: Container(
            alignment: Alignment.center,
            width: Get.mediaQuery.size.width,
            height: Get.mediaQuery.size.height,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runSpacing: Get.mediaQuery.size.shortestSide,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                              children: [
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () => Get.toNamed('/sign-in'),
                                  icon: Icon(Icons.account_circle),
                                  iconSize: 84.0,
                                  padding: const EdgeInsets.all(8.0),
                                ),
                                Card(
                                  child: Text('Log to your account'),
                                )
                              ],
                            ),
                          ]),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(children: [
                            IconButton(
                              onPressed: () => Get.toNamed('/sign-in'),
                              icon: Icon(Icons.account_circle),
                              iconSize: 84.0,
                              padding: const EdgeInsets.all(8.0),
                            ),
                            Card(
                              child: Text('Social link'),
                            ),
                          ]),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () => Get.toNamed('/sign-up'),
                                  icon: Icon(Icons.how_to_reg),
                                  iconSize: 84.0,
                                  padding: const EdgeInsets.all(8.0),
                                ),
                                Card(
                                  child: Text('Register'),
                                )
                              ],
                            )
                          ]),
                        )
                      ]),
                ])));
  }
}
