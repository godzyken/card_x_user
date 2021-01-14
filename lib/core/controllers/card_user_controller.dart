import 'dart:async';

import 'package:card_x_user/core/adapters/repository_adapter.dart';
import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:card_x_user/core/services/services.dart';

class CardUserController extends CardController {
  static CardUserController to = Get.find();
  AppLocalizations_Labels labels;

  final ICardRepository cardRepository;

  CardUserModelService _cardUserModelService;

  RxList<CardUserModel> cardUsers = RxList<CardUserModel>();

  RxBool isLoadingCard = false.obs;
  RxBool isAddingCard = false.obs;
  RxBool isLoadingDetails = false.obs;

  StreamController<int> streamController = StreamController<int>();

  CardUserController({this.cardRepository}) {
    _cardUserModelService = CardUserModelService();
  }

  Stream<DocumentSnapshot> doc =
      FirebaseFirestore.instance.collection("cardUser").doc("id").snapshots();

  @override
  void onInit() {
    super.onInit();
    String uid = Get.find<AuthController>().firebaseUser.value.uid;
    cardUsers.bindStream(Database().cardUserStream(uid));
    cardRepository.getCardUserModels().then((data) {
      changeUser(data, status: RxStatus.success());
    }, onError: (err) {
      changeUser(null, status: RxStatus.error(err.toString()));
    });
  }

  void StartStreamCardUser() {
    doc.listen((event) {
      streamController.sink.add(event.data()['card']);
    });
  }

  Future<CardUserModel> loadUserCards() {
    AuthController authController = AuthController.to;
    return _cardUserModelService
        .findOneCardUser(authController.firebaseUser.value.uid);
  }

  Future<CardUserModel> loadDetailsUser(UserModel id) async {
    try {
      isLoadingDetails.value = true;
      var cardModel = await _cardUserModelService.findOneCardUser(id.uid);
      print(cardModel.value);
      isLoadingDetails.value = false;
      return cardModel;
    } catch (e) {
      print(e);
    }

    return null;
  }

  @override
  FutureOr onClose() {
    streamController.close();
  }

  void changeUser(CardUserModel data, {RxStatus status}) {}
}
