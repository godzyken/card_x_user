import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/ui/components/components.dart';
import 'package:card_x_user/ui/pages/card/card_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                return buildAddUserCard(todoController, index);
              },
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }

  AddUserCard buildAddUserCard(CardController todoController, int index) {
    return AddUserCard(
                  uid: controller.firebaseUser.value.uid,
                  cardModel: todoController.cardUsers[index]);
  }
}
