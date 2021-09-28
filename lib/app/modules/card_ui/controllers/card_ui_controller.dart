import 'dart:convert';

import 'package:card_x_user/app/modules/card_ui/services/card_market_api.dart';
import 'package:get/get.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';

import '../models/models.dart';


///hooks_riverpod 0.14.0+4
///
///"url": "https://api.ebay.com/oauth/api_scope"

class CardUiController extends GetxController {
  final api = PokemonTcgApi(apiKey: 'de24380f-8a46-4f2c-a139-716db256d4f9');
  final cardMarketApi = CardMarketApi(options: 'application/json; charset=UTF-8');
  final pokemonCardV2Model = PokemonCardV2();

  PaginatedPokemonCards? paginatedCardsAll;
  PaginatedPokemonCards? paginatedCardsSwsh5;

  @override
  void onInit() {
    paginatedCardsAll = PaginatedPokemonCards([], api);
    paginatedCardsSwsh5 = PaginatedPokemonCards([], api);

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  ///GET pokemon model.json [https://api.pokemontcg.io/v2/cards?q=name:*****]
  ///Search engine example [https://pokemontcg.guru/]
  void getCards() async {
    try {
      await paginatedCardsAll!.loadMore(page: 1);
      print(paginatedCardsAll!.cards);
    } catch (e) {
      print(e);
    }
  }

  void getCardsForSet() async {
    try {
      await paginatedCardsAll!.loadMoreForSet('swsh5', page: 1);
      print(paginatedCardsAll!.cards);
    } catch (e) {
      print(e);
    }
  }

  void getSsAll() async {
    try {
      await paginatedCardsSwsh5!.loadMore(page: 1);
      print(paginatedCardsSwsh5!.cards);
    } catch (e) {
      print(e);
    }
  }

  void getSsAllForSet() async {
    try {
      await paginatedCardsSwsh5!.loadMore(page: 1);
      print(paginatedCardsSwsh5!.cards);
    } catch (e) {
      print(e);
    }
  }

  void getCard() async {
    try {
      final card = await api.getCard('xy7-54');
      print(card.tcgPlayer);
    } catch (e) {
      print(e);
    }
  }

  void getCardName(String? name) async {
    try {
      final card = await api.getCard('$name');
      print(card.name);
    } catch (e) {
      print(e);
    }
  }

  void getSet() async {
    try {
      final set = await api.getSet('SwSh5');
      print(set.id);
    } catch (e) {
      print(e);
    }
  }

  void getSets() async {
    try {
      final sets = await api.getSets();
      print(sets.length);
    } catch (e) {
      print(e);
    }
  }

  void getTypes() async {
    try {
      final types = await api.getTypes();
      types.forEach((element) {
        print(element.type);
      });
    } catch (e) {
      print(e);
    }
  }

  void getSubtypes() async {
    try {
      final types = await api.getSubtypes();
      types.forEach((element) {
        print(element.type);
      });
    } catch (e) {
      print(e);
    }
  }

  void getSupertypes() async {
    try {
      final types = await api.getSupertypes();
      types.forEach((element) {
        print(element.type);
      });
    } catch (e) {
      print(e);
    }
  }

  void getRarities() async {
    try {
      final types = await api.getRarities();
      types.forEach((element) {
        print(element.type);
      });
    } catch (e) {
      print(e);
    }
  }

  //----> Fin TCG <----//

  ///GET pokemon model.json ["https://api.cardmarket.com/ws/v2.0/products/265535"]
  ///[https://api.cardmarket.com/ws/v2.0/articles/:idProduct]
  ///https://api.cardmarket.com/ws/v2.0/articles/266361?userType=private&idLanguage=1&minCondition=NM&start=0&maxResults=10
  void getCardFromCardmarket() async {

    try{
      final card = await cardMarketApi.getCard('pikachu');
      print(card.name);
    } catch (e) {
      print(e);
    }

  }


}
