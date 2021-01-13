import 'package:cloud_firestore/cloud_firestore.dart';

class CardModel {

  String id;
  String name;
  Timestamp dateCreated;
  bool done;

  CardModel({ this.id, this.name, this.dateCreated, this.done = false });

  CardModel.fromMap(Map<String, dynamic> json){
      this.id = json['id'];
      this.name = json['name'] ?? this.name;
      this.dateCreated = json['dateCreated'] ?? this.dateCreated;
      this.done = json['done'] ?? this.done;
  }

  Map<String, dynamic> toJson() => {'id':id, 'name':name, 'dateCreated': dateCreated, 'done': done };

  copyWith({
    name, done
  }) {
    return CardModel(
      id: id ?? this.id,
      name: name ?? this.name,
      dateCreated: dateCreated ?? this.dateCreated,
      done: done ?? this.done,
    );
  }

  CardModel.fromDocumentSnapshot(DocumentSnapshot snap) {
    id = snap.id;
    name = snap["name"];
    dateCreated = snap["dateCreated" ];
    done = snap["done"];
  }
}