import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/ui/pages/card/card_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardView extends GetView<AuthController> {
  final UserModel userModel;
  final CardUserModel cardUserModel;

  CardView(this.userModel, this.cardUserModel);
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
                return UserCard(
                    uid: controller.firestoreUser.value.uid,
                    cardUserModel: cardController.cardUsers[index]);
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
