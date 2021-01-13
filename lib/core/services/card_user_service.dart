import 'dart:async';

import 'package:card_x_user/core/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CardUserModelService {
  CollectionReference cardUserModelsRef = FirebaseFirestore.instance.collection("cardUserModels");
  final StreamController<List<CardUserModel>> _cardUserModelsController =
  StreamController<List<CardUserModel>>.broadcast();
  Stream<List<CardUserModel>> findAll() {
    // Register the handler for when the cardUserModels data changes
    cardUserModelsRef.snapshots().listen((cardUserModelsSnapshot) {
      if (cardUserModelsSnapshot.docs.isNotEmpty) {
        var cardUserModels = cardUserModelsSnapshot.documents
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

  Future<CardUserModel> findOne(String id) async {
    var result = await cardUserModelsRef.document(id).get();
    return CardUserModel.fromMap(result.data());
  }

  Future<CardUserModel> addOne({
    String key,
    String value,
    String status,
    String icon,
    UserModel userModel,
  }) async {
    var result = await cardUserModelsRef.add({
      "key": key,
      "value": value,
      "icon": icon,
      "status": status,
      "userModel": userModel,
      "created_at": DateTime.now().toUtc().toString(),
    });
    return CardUserModel(
      uid: result.id,
      userModel: result.parent.parameters.values.last,
    );
  }

  Future<void> updateOne(CardUserModel cardUserModel) async {
    cardUserModelsRef.doc(cardUserModel.id).update(cardUserModel.toJson());
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
