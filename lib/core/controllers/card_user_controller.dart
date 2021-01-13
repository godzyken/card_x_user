import 'dart:async';

import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/core/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get.dart';
import 'package:card_x_user/core/services/services.dart';

class CardUserController extends GetxController {
  StreamController<int> streamController = StreamController<int>();

  Stream<DocumentSnapshot> doc = FirebaseFirestore.instance
      .collection("data")
      .doc("cardState")
      .snapshots();

  void StartStream() {
    doc.listen((event) {
      streamController.sink.add(event.data()['card']);
    });
  }

  @override
  FutureOr onClose() {
    streamController.close();
  }
}
