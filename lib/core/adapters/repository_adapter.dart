import 'package:card_x_user/core/models/models.dart';

abstract class ICardRepository {
  Future<CardModelu> getCardModels();
  Future<CardUserModel> getCardUserModels();
}
