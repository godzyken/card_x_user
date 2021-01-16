import 'dart:convert';

import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/core/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CardUserModel {
  String key;
  String value;
  String status;
  String icon;
  int newConfirmed;
  int totalConfirmed;
  int newDeaths;
  int totalDeaths;
  int newRecovered;
  int totalRecovered;
  String date;
  List<UserModel> userModels;

  CardUserModel(
      {this.key,
      this.value,
      this.status,
      this.icon,
      this.userModels,
      this.newConfirmed,
      this.totalConfirmed,
      this.newDeaths,
      this.totalDeaths,
      this.newRecovered,
      this.totalRecovered,
      this.date});

  factory CardUserModel.fromMap(Map data) {
    return CardUserModel(
      key: data['key'],
      value: data['value'] ?? '',
      icon: data['icon'] ?? '',
      status: data['status'] ?? '',
      newConfirmed:
          data['newConfirmed'] ?? Global(newConfirmed: data['newConfirmed']),
      totalConfirmed: data['totalConfirmed'] ??
          Global(totalConfirmed: data['totalConfirmed']),
      newDeaths: data['newDeaths'] ?? Global(newDeaths: data['newDeaths']),
      totalDeaths:
          data['totalDeaths'] ?? Global(totalDeaths: data['totalDeaths']),
      newRecovered:
          data['newRecovered'] ?? Global(newRecovered: data['newRecovered']),
      totalRecovered: data['totalRecovered'] ??
          Global(totalRecovered: data['totalRecovered']),
      date: data['date'] ?? '',
      userModels: data['userModel'] ?? UserModel().toJson(),
    );
  }

  String toRawJson() => json.encode(toJson());

  static CardUserModel fromRawJson(String str) =>
      CardUserModel.fromJson(json.decode(str) as Map<String, dynamic>);

  CardUserModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot, {DocumentSnapshot snapshots}) {
    key = documentSnapshot['key'];
    date = documentSnapshot['date'];
    value = documentSnapshot["value"];
    status = documentSnapshot["status"];
    icon = documentSnapshot["icon"];
    totalRecovered = documentSnapshot["totalRecovered"];
    totalConfirmed = documentSnapshot["totalConfirmed"];
    totalDeaths = documentSnapshot["totalDeaths"];
    newConfirmed = documentSnapshot["newConfirmed"];
    newDeaths = documentSnapshot["newDeaths"];
    newRecovered = documentSnapshot["newRecovered"];
    userModels = documentSnapshot["userModel"];
  }

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
        'status': status,
        'icon': icon,
        'date': date,
        'totalRecovered': totalRecovered,
        'totalDeaths': totalDeaths,
        'totalConfirmed': totalConfirmed,
        'newConfirmed': newConfirmed,
        'newRecovered': newRecovered,
        'newDeaths': newDeaths,
        'userModel': userModels,
      };

  static CardUserModel fromJson(dynamic json) => CardUserModel(
        key: json["Key"] == null ? null : json["Key"] as String,
        value: json["Value"] == null ? null : json["Value"] as String,
        status: json["Status"] == null ? null : json["Status"] as String,
        icon: json["Icon"] == null ? null : json["Icon"] as String,
        date: json["Date"] == null ? null : json["Date"] as String,
        newConfirmed:
            json["NewConfirmed"] == null ? null : json["NewConfirmed"] as int,
        newDeaths: json["NewDeaths"] == null ? null : json["NewDeaths"] as int,
        newRecovered:
            json["NewRecovered"] == null ? null : json["NewRecovered"] as int,
        totalConfirmed: json["TotalConfirmed"] == null
            ? null
            : json["TotalConfirmed"] as int,
        totalDeaths:
            json["TotalDeaths"] == null ? null : json["TotalDeaths"] as int,
        totalRecovered: json["TotalRecovered"] == null
            ? null
            : json["TotalRecovered"] as int,
        userModels: json["UserModel"] == null
            ? null
            : List<UserModel>.from(
                (json["UserModel"] as List<dynamic>)
                    .map((x) => UserModel.fromJson(x as Map<String, dynamic>)),
              ),
      );
}
