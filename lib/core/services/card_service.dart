import 'package:card_x_user/core/controllers/card_controller.dart';
import 'package:card_x_user/core/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


/*class CardService {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Future<CardModel> addCard(String content, String uid) async {

    try {
      await _store
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
    return null;
  }

  Stream<List<CardModel>> cardStream(String uid) {

    return _store
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

  Future<void> createCard(String uid, String id) async {

    try {
      await _store
          .collection("users")
          .doc(uid)
          .collection("cards")
          .add({
        'dateCreated': Timestamp.now(),
        'content': id,
        'done': false,
      });
    } catch (e) {
      print(e);
      rethrow;
    }

  }

  Future<void> updateCard(bool newValue, String uid, String cardId) async {

    try {
      _store
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
    var result = await _store.doc(id).get();
    return CardModel.fromDocumentSnapshot(result);
  }

  deleteOne(String id) {
    final FirebaseFirestore _store = FirebaseFirestore.instance;

    _store.doc(id).delete();
  }


}*/
