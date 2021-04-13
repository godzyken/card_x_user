import 'package:card_x_user/core/models/models.dart';
import 'package:get/get.dart';

abstract class ICardProvider {
  Future<Response<CardModelu>>? getCardModels(String? path);
  Future<Response<CardUserModel>>? getCardUserModels(String? path);
  Future<Response<CardModelu>>? getCardModelU(String? path);
}

class CardProvider extends GetConnect implements ICardProvider{

  @override
  void onInit() {
    httpClient.defaultDecoder = CardModelu.fromJson2;
    httpClient.baseUrl = 'https://api.cardxuser.com';
  }

  void onReady() {
    httpClient.defaultDecoder = CardUserModel.fromJson2;
    httpClient.baseUrl = 'https://api.cardxuser.com/me';
    httpClient.userAgent = 'https://api.cardxuser.com/userprofile';
  }

  void onSaved() {
    httpClient.baseUrl = 'https://api.cardxuser.com/me';
    httpClient.userAgent = 'https://api.cardxuser.com/userprofile';
  }


  @override
  Future<Response<CardModelu>>? getCardModels(String? path) => get(path!);
  Future<Response<CardUserModel>>? getCardUserModels(String? path) => get(path!);
  Future<Response<CardModelu>>? getCardModelU(String? path) => get(path!);
}
