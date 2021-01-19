import 'dart:convert';

import 'package:card_x_user/core/models/card_user_model.dart';
import 'package:card_x_user/core/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


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

class RxCardModel {
  final id = ''.obs;
  final name = 'name'.obs;
  final dateCreated = Timestamp.now().obs;
  final done = false.obs;
  final cardUserModel = CardUserModel().obs;
  final global = Global().obs;
}

class CardModelu {
  CardModelu({id, name, dateCreated, done, cardUserModel, global});

  final rx = RxCardModel();

  get name => rx.name.value;

  set name(value) => rx.name.value = value;

  get id => rx.id.value;

  set id(value) => rx.id.value = value;

  get dateCreated => rx.dateCreated.value;

  set dateCreated(value) => rx.dateCreated.value = value;

  get done => rx.done.value;

  set done(value) => rx.done.value = value;

  get cardUserModel => rx.cardUserModel.value;

  set cardUserModel(value) => rx.cardUserModel.value = value;

  get global => rx.global.value;

  set global(value) => rx.global.value = value;

  CardModelu.fromJson(dynamic, json) {
    id = json['id'];
    name = json['name'];
    dateCreated = json['dateCreated'];
    done = json['done'];
    cardUserModel = json['cardUserModel'];
    global = json['global'];
  }
  static CardModelu fromJson2(dynamic json) => CardModelu();

  CardModelu.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    name = documentSnapshot.data()["name"];
    dateCreated = documentSnapshot.data()["dateCreated"];
    cardUserModel = documentSnapshot.data()["cardUserModel"];
    global = documentSnapshot.data()["global"];
    done = documentSnapshot.data()["done"];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'dateCreated': dateCreated,
        'done': done,
        'cardUserModel': cardUserModel,
        'global': global,
      };
}
