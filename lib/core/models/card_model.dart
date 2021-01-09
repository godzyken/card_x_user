import 'package:cloud_firestore/cloud_firestore.dart';

class CardModel {

  String id;
  String name;
  Timestamp dateCreated;
  bool done;

  CardModel({ this.id, this.name, this.dateCreated, this.done });

  CardModel.fromMap(Map<String, dynamic> json){
      this.id = json['id'];
      this.name = json['name'];
      this.dateCreated = json['dateCreated'];
      this.done = json['done'];
  }

  Map<String, dynamic> toJson() => {'id':id, 'name':name };
}