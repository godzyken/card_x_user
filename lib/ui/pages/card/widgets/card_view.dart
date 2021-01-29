import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/ui/pages/card/card_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GetX<CardController>(
      init: Get.put<CardController>(CardController()),
      builder: (CardController cardController) {
        if (cardController != null && cardController.cardUsers != null) {
          return Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (_, index) {
                return AddUserCard(
                    uid: controller.firestoreUser.value.uid,
                    cardModel: cardController.cardUsers[index]);
              },
            ),
          );
        } else {
          return Text("loading...");
        }
      },
    );
  }
}
