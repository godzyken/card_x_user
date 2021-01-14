import 'package:card_x_user/core/models/models.dart';
import 'package:get/get.dart';

abstract class ICardProvider {
  Future<Response<CardModel>> getCardModels(String path);
  Future<Response<CardUserModel>> getCardUserModels(String path);
}

class CardProvider extends GetConnect implements ICardProvider{

  @override
  void onInit() {
    httpClient.defaultDecoder = CardModel.fromJson;
    httpClient.baseUrl = 'Https://api.cardxuser.com';
  }

  void onReady() {
    httpClient.defaultDecoder = CardUserModel.fromJson;
  }

  @override
  Future<Response<CardModel>> getCardModels(String path) => get(path);
  Future<Response<CardUserModel>> getCardUserModels(String path) => get(path);
}