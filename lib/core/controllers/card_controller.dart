import 'dart:async';

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

  void addCard() {
    Map<String, int> doneData = {
      "card":(card +1).toInt(),
    };

    DocumentReference documentReference = FirebaseFirestore.instance.collection("cardUser").doc("card");

    documentReference.update(doneData);
  }

  @override
  FutureOr onClose() {
    streamController.close();
  }
}