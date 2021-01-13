import 'dart:async';

import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/core/services/services.dart';
import 'package:card_x_user/localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CardController extends GetxController {
  static CardController to = Get.find();
  AppLocalizations_Labels labels;
  TextEditingController titreProController = TextEditingController();
  TextEditingController lieuProController = TextEditingController();
  TextEditingController contactProController = TextEditingController();
  TextEditingController dispoController = TextEditingController();
  TextEditingController horaireController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Rx<CardUserModel> cardStoreUser = Rx<CardUserModel>();
  RxList<CardModel> cardUs = RxList<CardModel>();

  CardService _cardService;

  RxBool isLoadingCard = false.obs;
  RxBool isAddingCard = false.obs;
  RxBool isLoadingDetails = false.obs;
  
  Stream<DocumentSnapshot> _doc = FirebaseFirestore.instance.collection("cardUser").doc("id").snapshots();
  StreamController<int> streamController = StreamController<int>();
  CardController() {
    _cardService = CardService();
  }

  @override
  void onInit() {
    String uid = Get.find<AuthController>().firebaseUser.value.uid;
    cardUs.bindStream(Database().cardStream(uid));
    super.onInit();
  }

  void StartStreamCard() {
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

  Future<CardUserModel> get cardUser async => Get.find<AuthController>().firestoreUser.value;


  Stream<CardUserModel> streamFirestoreCardUser() {
    print('streamFirestoreCardUser()');
  /*  if (cardStoreUser?.value?.key != null) {
      return _doc
          .doc('/cardUsers/${cardStoreUser.value.id}')
          .snapshots()
          .map((snapshot) => CardUserModel.fromMap(snapshot.data()));
    }*/

    return null;
  }

  Future<CardUserModel> getFirestoreCardUser() {
   /* if (cardStoreUser?.value?.uid != null) {
      return _doc
          .doc('/cardUsers/${cardStoreUser.value.key}')
          .get()
          .then(
              (documentSnapshot) => CardUserModel.fromMap(documentSnapshot.data()));
    }*/

    return null;
  }

  Future<CardUserModel> loadDetails(String id) async {
    try {
      isLoadingDetails.value = true;
      var cardModel = await _cardService.findOne(id);
      print(cardModel);
      isLoadingDetails.value = false;
      return cardModel;
    } catch (e) {
      print(e);
    }

    return null;
  }

  addCard(String name)  async {
    try {
      AuthController authController = AuthController.to;
      isAddingCard.value = true;
      var card = await _cardService.addCard(authController.firebaseUser.value.uid, name);
      cardUs.add(card);
      Get.snackbar("Success", card.name, snackPosition: SnackPosition.BOTTOM);
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
      await _cardService.updateCard(cardStoreUser.value.done, cardStoreUser.value.id, cardStoreUser.value.uid);
      int index = cardUs.indexWhere((element) => element.id == cardStoreUser.value.uid);

      cardUs[index] = cardStoreUser.value;
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
      int index = cardUs.indexWhere((element) => element.id == id);
      cardUs.removeAt(index);
      Get.snackbar("Success", "Deleted", snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print(e);
    }
  }
}

