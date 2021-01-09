import 'package:card_x_user/core/models/card_model.dart';
import 'package:card_x_user/core/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createNewCar(CardModel cardModel) async {
    try {
      await _firestore.collection("carduser").doc(cardModel.id).set({
        "id": cardModel.id,
        "name": cardModel.name,
        "dateCreate": cardModel.dateCreated,
        "done": cardModel.done,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<CardUserModel> getUserCard(UserModel userModel,
      CardModel cardModel) async {
    try {
      DocumentSnapshot _doc = await _firestore.collection("users").doc(
          userModel.uid)
          .collection("carduser").doc(cardModel.id)
          .get();

      return CardUserModel(
        key: cardModel.id,
        value: cardModel.name,
        status: userModel.name,
        userModel: userModel,
        photoUrl: userModel.photoUrl,
        icon: userModel.photoUrl,
        uid: userModel.uid,
        email: userModel.email,
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> addCard(CardModel cardModel, UserModel userModel) async {
    try {
      await _firestore.collection("users")
          .doc(userModel.uid)
          .collection("carduser")
          .add({
        'dateCreated': Timestamp.now(),
        'content': cardModel,
        'done': false,
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<List<CardModel>> cardStream(UserModel userModel) {
    return _firestore
        .collection("users")
        .doc(userModel.uid)
        .collection("carduser")
        .orderBy("dateCreated", descending: true)
        .snapshots()
        .map((querySnapshot) {
      List<CardModel> retVal = [];
      querySnapshot.docs.forEach((element) {
        retVal.add(CardModel.fromMap(element.data()));
      });
      return retVal;
    });
  }

  Future<void> updateCard(bool newValue, UserModel userModel,
      CardModel cardModel) async {
    try {
      _firestore
          .collection("users")
          .doc(userModel.uid)
          .collection("carduser")
          .doc(cardModel.id)
          .update({"done": newValue});
    } catch (e) {
      print(e);
      rethrow;
    }
  }

}