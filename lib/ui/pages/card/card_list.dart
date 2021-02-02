import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/ui/pages/card/card_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

class CardList extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GetX<CardController>(
      init: Get.put<CardController>(CardController()),
      builder: (CardController todoController) {
        if (todoController != null && todoController.cardUsers != null) {
          return Expanded(
            child: ListView.builder(
              itemCount: todoController.cardUsers.length,
              itemBuilder: (_, index) {
                return AddUserCard(
                    uid: controller.firebaseUser.value.uid,
                    cardModel: todoController.cardUsers[index]);
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
