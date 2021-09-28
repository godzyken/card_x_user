import 'package:card_x_user/app/modules/card_ui/controllers/card_ui_controller.dart';
import 'package:card_x_user/app/modules/scan_card/repository/page_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';
import 'package:scanbot_sdk/common_data.dart' as c;

class PokemonProductController extends GetxController {
  static PokemonProductController get to => Get.find();
  final api = CardUiController().api;
  PokemonCard? card;

  List<PokemonCard?> cardList = [];

  var cardName = TextEditingController().obs;
  bool? get isCard => false;

  get cardId => card!.id;
  get image => card!.images;

  @override
  void onInit() async {
    var id = 'xy7-54';
    card = await api.getCard(id);

    cardName = TextEditingController().obs;
    cardList = await api.getCards();

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

  void dialogError(String? msg) {
    Get.defaultDialog(
      title: "Ké passa a ora!!",
      middleText: msg!,
    );
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

  Future<PokemonCard?> getCardName(String? name) async {
    try {
      await api.getCards().then((cards) {
        for (var card in cards) {
          if (card.name == name) {
            card = PokemonCard(
                id: card.id,
                name: card.name,
                supertype: card.supertype,
                subtypes: card.subtypes,
                types: card.types,
                hp: card.hp,
                evolvesFrom: card.evolvesFrom,
                legalities: card.legalities,
                rarity: card.rarity,
                number: card.number,
                artist: card.artist,
                convertedRetreatCost: card.convertedRetreatCost,
                set: card.set,
                flavorText: card.flavorText,
                nationalPokedexNumbers: card.nationalPokedexNumbers,
                abilities: card.abilities,
                attacks: card.attacks,
                weaknesses: card.weaknesses,
                resistances: card.resistances,
                retreatCost: card.retreatCost,
                images: card.images,
                tcgPlayer: card.tcgPlayer);

            print('Card name ${card.name} & name of $name, found!');

            var c = getCard(card.id);

            update();

            return c;
          } else {
            print(
                'Card $name Search, not match with ${card.name} or not found!');
          }
        }
        return card;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<c.Page?> saveCard() async {
    List<c.PolygonPoint>? list;
    Uri? uri;
    final repo = PageRepository();

    try {
      var preview = c.Page(card!.id);
      uri = Uri(query: card!.images.large);
      if (preview.pageId == cardId) {
        preview.pageId = card!.id;
        print('Page ID:' + '${preview.pageId}');

        preview.originalPreviewImageFileUri = uri;
        print('Original Preview file Uri:' +
            '${preview.originalPreviewImageFileUri}');

        preview.detectionStatus = c.DetectionStatus.OK;
        print('Detection Status:' + '${preview.detectionStatus}');

        preview.polygon = list;
        print('Polygon:' + '${preview.polygon!.length}');

        repo.addPage(preview);
        print('Preview:' + '$preview');

        return preview;
      } else {
        dialogError("le champs de put est vide");
      }
      return preview;
    } catch (e) {
      print(e);
      repo.clearPages();
      dialogError(e.toString());
    }
  }
}
