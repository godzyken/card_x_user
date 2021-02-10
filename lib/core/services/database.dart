import 'package:card_x_user/core/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final cardUserModel = CardUserModel();

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

  Future<void> saveACard(CardUserModel cardUserModel, String uid) async {
    try {
      await _firestore.collection('cardUser').doc(uid).collection("card").add({
        "id": uid,
        "job": cardUserModel.job,
        "description": cardUserModel.description,
        "status": cardUserModel.status,
        "image": cardUserModel.image,
        "location": cardUserModel.location,
        "dateCreated": Timestamp.now(),
        "activity": cardUserModel.activity,
        "contact": cardUserModel.contact,
        "number": cardUserModel.number,
        "schedules": cardUserModel.schedules,
      });

    } catch (e) {
      print(e);
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
        .map((QuerySnapshot query) {
      List<CardUserModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(CardUserModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Stream<CardUserModel> streamCard(String uid) {

    print('streamCard()');
    if ((cardUserModel.id != null) || (cardStream(uid) == cardUserModel.id)) {
      return _firestore
          .collection("cardUser")
          .doc(uid)
          .snapshots()
          .map((DocumentSnapshot snapshot) => CardUserModel.fromSnapshot(snapshot));
    }

    return null;
  }
}
