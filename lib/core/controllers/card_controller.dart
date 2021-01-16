import 'dart:async';

import 'package:card_x_user/core/adapters/repository_adapter.dart';
import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/core/services/services.dart';
import 'package:card_x_user/localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CardController extends GetxController {
  static CardController to = Get.find();
  AppLocalizations_Labels labels;

  final ICardRepository cardRepository;

  TextEditingController titreProController = TextEditingController();
  TextEditingController lieuProController = TextEditingController();
  TextEditingController contactProController = TextEditingController();
  TextEditingController dispoController = TextEditingController();
  TextEditingController horaireController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  final cardStoreUser = CardUserModel().obs;
  final cardUs = CardModel().obs;

  CardService _cardService;

  RxBool isLoadingCard = false.obs;
  RxBool isAddingCard = false.obs;
  RxBool isLoadingDetails = false.obs;

  Stream<DocumentSnapshot> _doc =
  FirebaseFirestore.instance.collection("cardModel").doc("id").snapshots();
  StreamController<int> streamController = StreamController<int>();

  CardController({this.cardRepository}) {
    _cardService = CardService();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    String uid = Get
        .find<AuthController>()
        .firebaseUser
        .value
        .uid;

    cardUs.bindStream(Database().cardStream(uid));

 /*   cardRepository.getCardModels().then((data) {
      change(data, status: RxStatus.success());
    }, onError: (err)
    {
      change(cardUs.value, status: RxStatus.error(err.toString()));
    });*/
  }

  @override
  void onReady() {
    print('The build method is done. '
        'Your controller is ready to call dialogs and snackbars');
    super.onReady();
  }

  void startStreamCard() {
    _doc.listen((event) {
      streamController.sink.add(event.data()['count']);
    });
  }


  Stream<Iterable<CardModel>> loadCards() {
    AuthController authController = AuthController.to;
    return _cardService.cardStream(authController.firebaseUser.value.uid);
  }


  @override
  FutureOr onClose() {
    titreProController?.dispose();
    lieuProController?.dispose();
    contactProController?.dispose();
    dispoController?.dispose();
    horaireController?.dispose();
    referenceController?.dispose();
    descriptionController?.dispose();

    streamController.close();

    super.onClose();
  }


  Future<CardModel> loadDetails(String id) async {
    try {
      isLoadingDetails.value = true;
      var cardModel = await _cardService.findOne(id);
      print(cardModel.id);
      isLoadingDetails.value = false;
      return cardModel;
    } catch (e) {
      print(e);
    }

    return cardUs.value;
  }

  addCard(String name) async {
    try {
      AuthController authController = AuthController.to;
      isAddingCard.value = true;
      var card = await _cardService.addCard(
          authController.firebaseUser.value.uid, name);

      Get.snackbar("Success", card.id, snackPosition: SnackPosition.BOTTOM);
      isAddingCard.value = false;
    } catch (e) {
      isAddingCard.value = false;
      print(e);
    }
  }

/*  createACardUser(BuildContext context) async {
    final labels = AppLocalizations.of(context);
    showLoadingIndicator();
    try {
      await _firestore.doc('card-user').set();
    } catch (e) {
      print(e);
    }

  }*/

  updateCard(BuildContext context) async {
    try {
      isAddingCard.value = true;
      cardUs.update((val) {
        val.name = cardUs.value.name;
        val.done = cardUs.value.done;
        val.id = cardUs.value.id;
      });

      print(cardUs);
      Get.snackbar("Success", "updated", snackPosition: SnackPosition.BOTTOM);
      isAddingCard.value = false;
    } catch (e) {
      isAddingCard.value = false;
      print(e);
    }
  }

  deleteCard(String id) async {
    try {
      await _cardService.deleteOne(id);

      Get.snackbar("Success", "Deleted", snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print(e);
    }
  }

  void change(CardModel data, {RxStatus status}) {}


}


