import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/un_known_route_page_controller.dart';

class UnKnownRoutePageView extends GetView<UnKnownRoutePageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UnKnown Route'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          '404',
          style: TextStyle(fontSize: Get.mediaQuery.size.width /2),
        ),
      ),
    );
  }
}
