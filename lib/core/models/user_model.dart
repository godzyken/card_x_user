//User Model
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String email;
  String name;
  String photoUrl;

  UserModel({this.uid, this.email, this.name, this.photoUrl});

  static UserModel fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  UserModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    uid = documentSnapshot.id;
    name = documentSnapshot["name"];
    email = documentSnapshot["email"];
    photoUrl = documentSnapshot["photoUrl"];
  }

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["Uid"] == null ? null : json["Uid"] as String,
        name: json["Name"] == null ? null : json["Name"] as String,
        email: json["Email"] == null ? null : json["Email"] as String,
        photoUrl: json["PhotoUrl"] == null ? null : json["PhotoUrl"] as String,
      );

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic> map = snap.data();
    if (map.containsKey('name')) {
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
