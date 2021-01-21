import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RxCardUserModel {
  final key = ''.obs;
  final job = ''.obs;
  final location = ''.obs;
  final description = ''.obs;
  final contact = ''.obs;
  final number = ''.obs;
  final schedules = ''.obs;
  final status = ''.obs;
  final dateCreated = ''.obs;
  final activity = ''.obs;
  final image = ''.obs;
}

class CardUserModel {
  CardUserModel({
    key,
    job,
    status,
    description,
    dateCreated,
    schedules,
    location,
    image,
    activity,
    contact,
    number,
  });

  final rx = RxCardUserModel();

  get key => rx.key.value;

  set key(value) => rx.key.value = value;

  get job => rx.job.value;

  set job(value) => rx.job.value = value;

  get status => rx.status.value;

  set status(value) => rx.status.value = value;

  get description => rx.description.value;

  set description(value) => rx.description.value = value;

  get dateCreated => rx.dateCreated.value;

  set dateCreated(value) => rx.dateCreated.value = value;

  get schedules => rx.schedules.value;

  set schedules(value) => rx.schedules.value = value;

  get location => rx.location.value;

  set location(value) => rx.location.value = value;

  get image => rx.image.value;

  set image(value) => rx.image.value = value;

  get activity => rx.activity.value;

  set activity(value) => rx.activity.value = value;

  get contact => rx.contact.value;

  set contact(value) => rx.contact.value = value;

  get number => rx.number.value;

  set number(value) => rx.number.value = value;

  factory CardUserModel.fromMap(Map data) {
    return CardUserModel(
      key: data['key'],
      job: data['job'] ?? '',
      description: data['description'] ?? '',
      status: data['status'] ?? '',
      image: data['image'] ?? '',
      location: data['location'] ?? '',
      dateCreated: data['dateCreated'] ?? '',
      activity: data['activity'] ?? '',
      contact: data['contact'] ?? '',
      number: data['number'] ?? '',
      schedules: data['schedules '] ?? '',
    );
  }

  String toRawJson() => json.encode(toJson());

  static CardUserModel fromRawJson(String str) =>
      CardUserModel.fromJson(json.decode(str) as Map<String, dynamic>);

  static CardUserModel fromJson2(dynamic json) => CardUserModel();

  CardUserModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot,
      {DocumentSnapshot snapshots}) {
    key = documentSnapshot['key'];
    job = documentSnapshot["job"];
    description = documentSnapshot["description"];
    status = documentSnapshot["status"];
    image = documentSnapshot["image"];
    location = documentSnapshot["location"];
    dateCreated = documentSnapshot["dateCreated"];
    activity = documentSnapshot["activity"];
    contact = documentSnapshot["contact"];
    number = documentSnapshot["number"];
    schedules = documentSnapshot["schedules"];
  }

  Map<String, dynamic> toJson() => {
        'key': key,
        'job': job,
        'description': description,
        'status': status,
        'image': image,
        'location': location,
        'dateCreated': dateCreated,
        'activity': activity,
        'contact': contact,
        'number': number,
        'schedules': schedules,
      };

  static CardUserModel fromJson(dynamic json) => CardUserModel(
        key: json["Key"] == null ? null : json["Key"] as String,
        job: json["job"] == null ? null : json["job"] as String,
        description:
            json["description"] == null ? null : json["description"] as String,
        status: json["status"] == null ? null : json["status"] as String,
        image: json["image"] == null ? null : json["image"] as String,
        location: json["location"] == null ? null : json["location"] as String,
        dateCreated:
            json["dateCreated"] == null ? null : json["dateCreated"] as String,
        activity: json["activity"] == null ? null : json["activity"] as String,
        contact: json["contact"] == null ? null : json["contact"] as String,
        number: json["number"] == null ? null : json["number"] as String,
        schedules:
            json["schedules"] == null ? null : json["schedules"] as String,
      );
}
