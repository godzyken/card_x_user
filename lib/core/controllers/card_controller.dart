import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/core/services/database.dart';
import 'package:card_x_user/localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CardController extends GetxController {
  static CardController get to => Get.find();
  AppLocalizations_Labels labels;
  TextEditingController titreProController = TextEditingController();
  TextEditingController lieuProController = TextEditingController();
  TextEditingController contactProController = TextEditingController();
  TextEditingController dispoController = TextEditingController();
  TextEditingController horaireController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<CardUserModel> cardUser = Rx<CardUserModel>();
  Rx<List<CardModel>> cardList = Rx<List<CardModel>>();
  final datacount = GetStorage();
  int _count = 0;

  List<CardUserModel> get cards => cardList.value;

  @override
  void onInit() {
    UserModel userModel = Get.find<AuthController>().firestoreUser.value;
    cardList.bindStream(Database().cardStream(userModel));
  }

  @override
  void onReady() {
    super.onReady();
    if (datacount.read('count') != null) {
      _count = datacount.read('count');
    }
  }

  @override
  void onClose() {
    titreProController?.dispose();
    lieuProController?.dispose();
    contactProController?.dispose();
    dispoController?.dispose();
    horaireController?.dispose();
    referenceController?.dispose();
    descriptionController?.dispose();

    super.onClose();
  }


}
