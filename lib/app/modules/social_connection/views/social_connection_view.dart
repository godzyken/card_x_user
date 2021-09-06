import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/social_connection_controller.dart';

class SocialConnectionView extends GetView<SocialConnectionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SocialConnectionView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SocialConnectionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
