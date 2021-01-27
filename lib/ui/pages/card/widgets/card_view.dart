import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/ui/pages/card/card_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardView extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardController>(
      id: controller.firestoreUser.value.uid,
      init: Get.put<CardController>(CardController()),
      builder: (CardController cardController) {
        return Builder(builder: (BuildContext context) {
          return UserCard(
            uid: controller.firestoreUser.value.uid,
            cardUserModel: cardController.userCard.value,
          );
        });
      },
    );
  }
}
