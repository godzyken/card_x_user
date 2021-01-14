import 'package:card_x_user/core/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CardService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
    return null;
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
