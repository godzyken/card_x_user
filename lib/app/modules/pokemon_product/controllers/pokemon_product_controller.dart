import 'package:card_x_user/app/modules/card_ui/controllers/card_ui_controller.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';

class PokemonProductController extends GetxController {
  static PokemonProductController get to => Get.find();
  PokemonCard? card;

  final api = CardUiController().api;

  get cardId => card!.id;

  bool? get isCard => false;

  @override
  void onInit() async {
    var id = 'xy7-54';
    card = await api.getCard(id);

    update();
    super.onInit();
  }

  @override
  void onReady() async {

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getCard(String? cardId) async {
    try {
      final cardresult = await api.getCard(cardId!);
      print(cardresult.images.large);

      if (cardresult.images.large.isURL)
        card = PokemonCard(
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

      print(card!.name);

      return card;
    } catch (e) {
      print(e);
    }
  }
}
