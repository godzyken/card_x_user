import 'package:card_x_user/core/models/models.dart';
import 'package:get/get.dart';

abstract class ICardProvider {
  Future<Response<CardModel>> getCardModels(String path);
  Future<Response<CardUserModel>> getCardUserModels(String path);
  Future<Response<CardModelu>> getCardModelU(String path);
}

class CardProvider extends GetConnect implements ICardProvider{

  @override
  void onInit() {
    httpClient.defaultDecoder = CardModel.fromJson;
    httpClient.baseUrl = 'https://api.cardxuser.com';
  }

  void onReady() {
    httpClient.defaultDecoder = CardUserModel.fromJson;
    httpClient.baseUrl = 'https://api.cardxuser.com/me';
    httpClient.userAgent = 'https://apli.cardxuser.com/userprofile';
  }

  void onSaved() {
    httpClient.baseUrl = 'https://api.cardxuser.com/me';
    httpClient.userAgent = 'https://apli.cardxuser.com/userprofile';
  }


  @override
  Future<Response<CardModel>> getCardModels(String path) => get(path);
  Future<Response<CardUserModel>> getCardUserModels(String path) => get(path);
  Future<Response<CardModelu>> getCardModelU(String path) => get(path);
}