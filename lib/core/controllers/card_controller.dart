import 'dart:async';

import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/core/models/card_model.dart';
import 'package:card_x_user/core/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


class CardController extends GetxController {
  StreamController<int> streamController = StreamController<int>();
  Stream<DocumentSnapshot> doc = FirebaseFirestore.instance.collection("cardUser").doc("card").snapshots();
  int card;

  void startStream() {
    doc.listen((event) {
      streamController.sink.add(event.data()['cardUser']);
    });
  }
  Rx<List<CardModelu>> cardList = Rx<List<CardModelu>>();

  List<CardModelu> get cards => cardList.value;


  @override
  void onInit() {
    String uid = Get.find<AuthController>().firestoreUser.value.uid;
    cardList
        .bindStream(Database().cardStream(uid)); //stream coming from firebase
  }

  @override
  FutureOr onClose() {
    streamController.close();
  }
}