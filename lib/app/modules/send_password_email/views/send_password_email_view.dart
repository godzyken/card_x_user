import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/send_password_email_controller.dart';

class SendPasswordEmailView extends GetView<SendPasswordEmailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SendPasswordEmailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SendPasswordEmailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
