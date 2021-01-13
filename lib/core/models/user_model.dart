//User Model
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String email;
  String name;
  String photoUrl;

  UserModel({this.uid, this.email, this.name, this.photoUrl});

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
    );
  }

  UserModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    uid = documentSnapshot.id;
    name = documentSnapshot["name"];
    email = documentSnapshot["email"];
    photoUrl = documentSnapshot["photoUrl"];
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic> map = snap.data();
    if(map.containsKey('name')){
      return UserModel.fromMap(
        map,
      );
    }
    return UserModel(
      uid: snap.id,
      name: snap.reference.path,
      email: snap.reference.path,
      photoUrl: snap.reference.path,
    );
  }

  Map<String, dynamic> toJson() =>
      {"uid": uid, "email": email, "name": name, "photoUrl": photoUrl};
}