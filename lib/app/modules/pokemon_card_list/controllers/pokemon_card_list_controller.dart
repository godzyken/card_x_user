import 'package:card_x_user/app/modules/card_ui/controllers/card_ui_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';

class PokemonCardListController extends GetxController {
  static PokemonCardListController? get to => Get.find();

  final api = CardUiController().api;
  final scroller = ScrollController();
  var cardList = <PokemonCard>[].obs;

  @override
  void onInit() {
    getCardList();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  getCardList() async {
    try {
      final result = await api.getCards();
      print(result.length);

      cardList.value = result;
      print(cardList);

      update();

      return cardList;
    } catch (e) {
      print(e);
    }
  }
}
