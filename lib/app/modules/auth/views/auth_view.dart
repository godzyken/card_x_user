import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Authentication Services'),
        centerTitle: true,
      ),
      body: Semantics(
        container: true,
        child: Column(
          verticalDirection: VerticalDirection.down,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogToYourAccount(),
            Divider(),
            SocialLink(),
            Divider(),
            Register(),
          ],
        ),
      ),
    );
  }
}

class Register extends GetView {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Wrap(
                children: [
                  IconButton(
                    onPressed: onPressed,
                    icon: Icon(Icons.how_to_reg),
                    iconSize: Get.mediaQuery.size.height / 5,
                    padding: const EdgeInsets.all(8.0),
                  ),
                  Card(
                    child: Text('Register'),
                  ),
                ],
              ),
            )
          ]),
    );
  }

  void onPressed() => Get.toNamed('/sign-up');
}

class SocialLink extends GetView {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.redAccent,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Wrap(
                children: [
                  IconButton(
                    onPressed: onPressed,
                    icon: Icon(Icons.account_circle_outlined),
                    iconSize: Get.mediaQuery.size.height / 5,
                    padding: const EdgeInsets.all(8.0),
                  ),
                  Card(
                    child: Text('Social link'),
                  ),
                ],
              ),
            )
          ]),
    );
  }

  void onPressed() => Get.toNamed('/social-connection');
}

class LogToYourAccount extends GetView {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.cyan,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Wrap(
                children: [
                  IconButton(
                    onPressed: onPressed,
                    icon: Icon(Icons.account_circle_sharp),
                    iconSize: Get.mediaQuery.size.height / 5,
                    padding: const EdgeInsets.all(8.0),
                  ),
                  Card(
                    child: Text('Log to your account'.tr),
                  ),
                ],
              ),
            )
          ]),
    );
  }

  void onPressed() =>
      Get.toNamed('/sign-in', arguments: AuthController().isSignIn);
}
