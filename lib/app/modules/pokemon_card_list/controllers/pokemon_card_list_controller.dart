import 'package:card_x_user/app/modules/card_ui/controllers/card_ui_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';

class PokemonCardListController extends GetxController {
  static PokemonCardListController? get to => Get.find();

  final api = CardUiController().api;
  final scroller = ScrollController();

  var cardList = <PokemonCard>[].obs;

  CardImages? get images => cardList.single.images;
  CardSet? get set => cardList.single.set;


  @override
  void onInit() {
    getCardList();
    update();
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

      update();

      return cardList;
    } catch (e) {
      print(e);
    }
  }

}
