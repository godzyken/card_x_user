import 'package:card_x_user/core/adapters/repository_adapter.dart';
import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/core/data/card_api_provider.dart';

class CardRepository implements ICardRepository {
  CardRepository({this.provider});
  final ICardProvider provider;

  @override
  Future<CardModel> getCardModels() async {
    // TODO: implement getCardModels
    final cards = await provider.getCardModels("/summary");
    if (cards.status.hasError == null) {
      return Future.error(cards.statusText);
    } else {
      return cards.body;
    }
  }

  @override
  Future<CardUserModel> getCardUserModels() async {
    // TODO: implement getCardUserModels
    final cards = await provider.getCardUserModels("/summary");
    if (cards.status.hasError == null) {
      return Future.error(cards.statusText);
    } else {
      return cards.body;
    }
  }

  @override
  Future<CardModelu> getCardModelU() async {
    // TODO: implement getCardModelU
    final cards = await provider.getCardModelU("/summary");
    if (cards.status.hasError == null) {
      return Future.error(cards.statusText);
    } else {
      return cards.body;
    }
  }


}