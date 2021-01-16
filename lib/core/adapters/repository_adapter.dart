import 'package:card_x_user/core/models/models.dart';

abstract class ICardRepository {
  Future<CardModel> getCardModels();
  Future<CardModelu> getCardModelU();
  Future<CardUserModel> getCardUserModels();
}