import 'package:card_x_user/core/models/card_model.dart';
import 'package:card_x_user/core/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*
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

  Future<CardUserModel> getUserCard(String uid) async {
    try {
      DocumentSnapshot _doc = await _firestore.collection("users").doc(uid).get();

      return CardUserModel.fromDocumentSnapshot(_doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addCard(String content, String uid) async {
    try {
      await _firestore.collection("users")
          .doc(uid)
          .collection("carduser")
          .add({
        'dateCreated': Timestamp.now(),
        'content': content,
        'done': false,
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<CardModel> cardStream(String uid) {
    return _firestore
        .collection("users")
        .doc(uid)
        .collection("carduser")
        .orderBy("dateCreated", descending: true)
        .snapshots()
        .map((querySnapshot) {
      CardModel retVal = CardModel(
        id: querySnapshot.docs.last.id,

      );
      querySnapshot.docs.forEach((element) {
        retVal.id = element.id;
      });
      return retVal;
    });
  }

  Stream<List<CardUserModel>> cardUserStream(String uid) {
    return _firestore
        .collection("users")
        .doc(uid)
        .collection("carduser")
        .orderBy("dateCreated", descending: true)
        .snapshots()
        .map((querySnapshot) {
      List<CardUserModel> retVal = [];
      querySnapshot.docs.forEach((element) {
        retVal.add(CardUserModel.fromMap(element.data()));
      });
      return retVal;
    });
  }


  Future<void> updateCard(bool newValue, String uid,
      String cardId) async {
    try {
      _firestore
          .collection("users")
          .doc(uid)
          .collection("carduser")
          .doc(cardId)
          .update({"done": newValue});
    } catch (e) {
      print(e);
      rethrow;
    }
  }

}*/
