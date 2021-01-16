import 'dart:async';

import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/core/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CardUserModelService extends CardService {
  CollectionReference cardUserModelsRef = FirebaseFirestore.instance.collection("cardUserModels");
  final StreamController<List<CardUserModel>> _cardUserModelsController =
  StreamController<List<CardUserModel>>.broadcast();

  Stream<List<CardUserModel>> findAllCards() {
    // Register the handler for when the cardUserModels data changes
    cardUserModelsRef.snapshots().listen((cardUserModelsSnapshot) {
      if (cardUserModelsSnapshot.docs.isNotEmpty) {
        var cardUserModels = cardUserModelsSnapshot.docs
            .map((snapshot) => CardUserModel.fromMap(snapshot.data()))
            .toList();
        print(cardUserModels.length);
        // Add the cardUserModels onto the controller
        _cardUserModelsController.add(cardUserModels);
      }
    });
    // Return the stream underlying our _cardUserModelsController.
    return _cardUserModelsController.stream;
  }


  Future<CardModelu> findOneCardUser(String id) async {
    var result = await cardUserModelsRef.doc(id).get();
    return CardModelu.fromJson(result.id, result.metadata);
  }

  Future<CardUserModel> addOne({
    String key,
    String value,
    String status,
    String icon,
    String date,
    UserModel userModel,
  }) async {
    var result = await cardUserModelsRef.add({
      "key": key,
      "value": value,
      "icon": icon,
      "status": status,
      "date": date,
      "userModel": userModel,
      "created_at": DateTime.now().toUtc().toString(),
    });
    return CardUserModel(
      key: result.id,
      userModels: result.parent.parameters.values.last,
    );
  }

  Future<void> updateOne(CardUserModel cardUserModel) async {
    cardUserModelsRef.doc(cardUserModel.key).update(cardUserModel.toJson());
  }

  deleteOne(String id) {
    cardUserModelsRef.doc(id).delete();
  }

  addGallery(String cardUserModelId, List<UserModel> photoUrl) {
    cardUserModelsRef.doc(cardUserModelId).update(
      {
        "gallery": photoUrl.map((e) => e.toJson()).toList(),
      },
    );
  }
}
