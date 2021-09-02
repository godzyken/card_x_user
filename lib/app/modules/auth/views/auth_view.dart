import 'package:card_x_user/app/modules/auth/sign_in/views/sign_in_view.dart';
import 'package:card_x_user/app/modules/auth/sign_up/views/sign_up_view.dart';
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
        body: Stack(
          children: [
            SizedBox(),
            Container(
                child: Column(children: [
              Row(children: [
                Expanded(flex: 1, child: SignInView()),
              ]),
              SizedBox(),
              Row(children: [
                Expanded(flex: 1, child: SignUpView()),
              ]),
            ]))
          ],
        ));
  }
}
