import 'dart:async';

import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/core/models/card_model.dart';
import 'package:card_x_user/core/models/card_user_model.dart';
import 'package:card_x_user/core/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CardController extends GetxController {
  Rxn<List<CardModelu>>? cardList = Rxn<List<CardModelu>>();
  List<CardModelu>? get cards => cardList!.value;

  Rxn<List<CardUserModel>>? cardUserList = Rxn<List<CardUserModel>>();
  List<CardUserModel>? get cardUsers => cardUserList!.value;

  Rxn<CardUserModel>? userCard = Rxn<CardUserModel>();

  Future getData(String collection) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection(collection).get();
    return snapshot.docs;
  }

  List<CardUserModel> get cardUserModel => _cardUserModel;

  // SORT COLUMN INDEX...

  int? get sortColumnIndex => _sortColumnIndex;

  set sortColumnIndex(int? sortColumnIndex) {
    _sortColumnIndex = sortColumnIndex;
    update();
  }

  // SORT ASCENDING....

  bool get sortAscending => _sortAscending;

  set sortAscending(bool sortAscending) {
    _sortAscending = sortAscending;
    update();
  }

  int get rowsPerPage => _rowsPerPage;

  set rowsPerPage(int rowsPerPage) {
    _rowsPerPage = rowsPerPage;
    update();
  }

  // -------------------------------------- INTERNALS --------------------------------------------

  var _cardUserModel = <CardUserModel>[];

  int? _sortColumnIndex;
  bool _sortAscending = true;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  Future<void> fetchData() async {
    _cardUserModel = CardController().cardUsers!;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    String uid = Get.find<AuthController>().firestoreUser!.value!.uid!;
    cardList!.bindStream(Database().cardStream(uid)); //stream coming from firebase
    cardUserList!.bindStream(Database().cardUserStream(uid)); //stream coming from firebase
    userCard!.bindStream(Database().streamCard(uid)!); //stream coming from firebase
  }

  @override
  FutureOr onClose() {
    super.onClose();
  }
}