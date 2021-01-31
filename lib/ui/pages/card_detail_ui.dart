import 'package:card_x_user/core/constants/constants.dart';
import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardDetailUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.darkTheme,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              title: GetBuilder<CardController>(
                init: CardController(),
                builder: (data) => Text(Get.arguments),
              )),
        ),
      ),
    );
  }
}