import 'dart:convert';

import 'package:card_x_user/core/models/card_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CardModel {
  String id;
  List<CardUserModel> name;
  String dateCreated;
  bool done;
  Global global;

  CardModel(
      {this.id, this.name, this.dateCreated, this.global, this.done = false});

  String toRawJson() => json.encode(toJson());

  CardModel.fromMap(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'] ?? this.name;
    this.dateCreated = json['dateCreated'] ?? this.dateCreated;
    this.done = json['done'] ?? this.done;
    this.global = json['global'] ?? this.global;
  }

  copyWith({name, done}) {
    return CardModel(
      id: id ?? this.id,
      name: name ?? this.name,
      dateCreated: dateCreated ?? this.dateCreated,
      done: done ?? this.done,
      global: global ?? this.global,
    );
  }

  CardModel.fromDocumentSnapshot(DocumentSnapshot snap) {
    id = snap.id;
    name = snap["name"];
    dateCreated = snap["dateCreated"];
    done = snap["done"];
    global = snap['global'];
  }

  static CardModel fromRawJson(String str) =>
      CardModel.fromJson(json.decode(str) as Map<String, dynamic>);

  static CardModel fromJson(dynamic json) => CardModel(
        global: json["Global"] == null
            ? null
            : Global.fromJson(json["Global"] as Map<String, dynamic>),
        dateCreated:
            json["DateCreate"] == null ? null : json["DateCreate"] as String,
        name: json["Name"] == null
            ? null
            : List<CardUserModel>.from(json["Name"])
                .map((x) => CardUserModel.fromJson(x as Map<String, dynamic>)),
        done: json["Done"] == null ? null : json["Done"] as bool,
        id: json["Id"] == null ? null : json["Id"] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'dateCreated': dateCreated,
        'done': done,
        'global': global?.toJson(),
      };
}

class Global {
  final int newConfirmed;
  final int totalConfirmed;
  final int newDeaths;
  final int totalDeaths;
  final int newRecovered;
  final int totalRecovered;

  Global(
      {this.newConfirmed,
      this.totalConfirmed,
      this.newDeaths,
      this.totalDeaths,
      this.newRecovered,
      this.totalRecovered});

  factory Global.fromRawJson(String str) =>
      Global.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory Global.fromJson(Map<String, dynamic> json) => Global(
        newConfirmed:
            json["NewConfirmed"] == null ? null : json["NewConfirmed"] as int,
        totalConfirmed: json["TotalConfirmed"] == null
            ? null
            : json["TotalConfirmed"] as int,
        newDeaths: json["NewDeaths"] == null ? null : json["NewDeaths"] as int,
        totalDeaths:
            json["TotalDeaths"] == null ? null : json["TotalDeaths"] as int,
        newRecovered:
            json["NewRecovered"] == null ? null : json["NewRecovered"] as int,
        totalRecovered: json["TotalRecovered"] == null
            ? null
            : json["TotalRecovered"] as int,
      );

  Map<String, dynamic> toJson() => {
        "NewConfirmed": newConfirmed == null ? null : newConfirmed,
        "TotalConfirmed": totalConfirmed == null ? null : totalConfirmed,
        "NewDeaths": newDeaths == null ? null : newDeaths,
        "TotalDeaths": totalDeaths == null ? null : totalDeaths,
        "NewRecovered": newRecovered == null ? null : newRecovered,
        "TotalRecovered": totalRecovered == null ? null : totalRecovered,
      };
}
