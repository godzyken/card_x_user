import 'package:card_x_user/core/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createNewCar(CardModelu cardModel) async {
    try {
      await _firestore.collection("cardUser").doc(cardModel.id).set({
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
      DocumentSnapshot _doc =
          await _firestore.collection("cardUser").doc(uid).get();

      return CardUserModel.fromDocumentSnapshot(_doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addCard(String name, String uid) async {
    try {
      await _firestore.collection("cardUser").doc(uid).collection("card").add({
        'dateCreated': Timestamp.now(),
        'name': name,
        'done': false,
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> updateCard(bool newValue, String uid, String cardId) async {
    try {
      _firestore
          .collection("cardUser")
          .doc(uid)
          .collection("card")
          .doc(cardId)
          .update({"done": newValue});
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> saveACard(CardUserModel cardModel) async {
    try {
      await _firestore.collection('cardUser').doc(cardModel.key).collection("card").add({
        "key": cardModel.key,
        "job": cardModel.job,
        "description": cardModel.description,
        "status": cardModel.status,
        "image": cardModel.image,
        "location": cardModel.location,
        "dateCreated": cardModel.dateCreated,
        "activity": cardModel.activity,
        "contact": cardModel.contact,
        "number": cardModel.number,
        "schedules": cardModel.schedules,
      });

    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<List<CardModelu>> cardStream(String uid) {
    return _firestore
        .collection("cardUser")
        .doc(uid)
        .collection("card")
        .orderBy("dateCreated", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<CardModelu> retVal = [];
      query.docs.forEach((element) {
        retVal.add(CardModelu.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Stream<List<CardUserModel>> cardUserStream(String uid) {
    return _firestore
        .collection("cardUser")
        .doc(uid)
        .collection("card")
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

}
