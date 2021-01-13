import 'package:card_x_user/core/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CardService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection("users").doc(user.uid).set({
        "name": user.name,
        "email": user.email,
        "photoUrl": user.photoUrl,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot _doc =
      await _firestore.collection("users").doc(uid).get();

      return UserModel.fromDocumentSnapshot(documentSnapshot: _doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<CardModel> addCard(String content, String uid) async {
    try {
      await _firestore
          .collection("users")
          .doc(uid)
          .collection("cards")
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

  Stream<List<CardModel>> cardStream(String uid) {
    return _firestore
        .collection("users")
        .doc(uid)
        .collection("cards")
        .orderBy("dateCreated", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<CardModel> retVal = []..length;
      query.docs.forEach((element) {
        retVal.add(CardModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Future<void> updateCard(bool newValue, String uid, String cardId) async {
    try {
      _firestore
          .collection("users")
          .doc(uid)
          .collection("cards")
          .doc(cardId)
          .update({"done": newValue});
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<CardModel> findOne(String id) async {
    var result = await _firestore.doc(id).get();
    return CardModel.fromDocumentSnapshot(result);
  }

  deleteOne(String id) {
    _firestore.doc(id).delete();
  }

}
