import 'package:card_x_user/app/modules/card_ui/controllers/card_ui_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';

class PokemonProductController extends GetxController {
  final api = CardUiController().api;
  PokemonCard? card;
  TextEditingController? cardName;
  final scroller = ScrollController();
  var cardList = <PokemonCard>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    cardName!.dispose();
    super.onClose();
  }

  getCard(String? cardId) async {
    try {
      final cardresult = await api.getCard(cardId!);
      print(cardresult.tcgPlayer);

      var newCard = PokemonCard(
          id: cardresult.id,
          name: cardresult.name,
          supertype: cardresult.supertype,
          subtypes: cardresult.subtypes,
          types: cardresult.types,
          hp: cardresult.hp,
          evolvesFrom: cardresult.evolvesFrom,
          legalities: cardresult.legalities,
          rarity: cardresult.rarity,
          number: cardresult.number,
          artist: cardresult.artist,
          convertedRetreatCost: cardresult.convertedRetreatCost,
          set: cardresult.set,
          flavorText: cardresult.flavorText,
          nationalPokedexNumbers: cardresult.nationalPokedexNumbers,
          abilities: cardresult.abilities,
          attacks: cardresult.attacks,
          weaknesses: cardresult.weaknesses,
          resistances: cardresult.resistances,
          retreatCost: cardresult.retreatCost,
          images: cardresult.images,
          tcgPlayer: cardresult.tcgPlayer);

      update();

      card = newCard;
      print(card!.name);

      return card;
    } catch (e) {
      print(e);
    }
  }

  getCardList() async {
    try {
      final result = await api.getCards();
      print(result.length);

      cardList.value = result;
      print(cardList);
      if (cardList.value.first.name == card!.name) {
        return cardList.iterator.current.name;
      }

      update();

      return cardList;
    } catch (e) {
      print(e);
    }
  }
}
