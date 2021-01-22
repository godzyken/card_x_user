import 'dart:async';

import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/core/models/card_model.dart';
import 'package:card_x_user/core/models/card_user_model.dart';
import 'package:card_x_user/core/services/services.dart';
import 'package:get/get.dart';


class CardController extends GetxController {
  Rx<List<CardModelu>> cardList = Rx<List<CardModelu>>();
  List<CardModelu> get cards => cardList.value;

  Rx<List<CardUserModel>> cardUserList = Rx<List<CardUserModel>>();
  List<CardUserModel> get cardUsers => cardUserList.value;

  @override
  void onInit() {
    super.onInit();
    String uid = Get.find<AuthController>().firestoreUser.value.uid;
    cardList.bindStream(Database().cardStream(uid)); //stream coming from firebase
    cardUserList.bindStream(Database().cardUserStream(uid)); //stream coming from firebase
  }

  @override
  FutureOr onClose() {
    super.onClose();
  }
}