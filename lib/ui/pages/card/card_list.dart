import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

import 'card_ui.dart';

class CardList extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GetX<CardController>(
      init: Get.put<CardController>(CardController()),
      builder: (CardController todoController) {
        if (todoController != null && todoController.cards != null) {
          return Expanded(
            child: ListView.builder(
              itemCount: todoController.cards.length,
              itemBuilder: (_, index) {
                return AddCard(
                    uid: controller.firebaseUser.value.uid,
                    cardModel: todoController.cards[index]);
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
