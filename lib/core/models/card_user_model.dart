import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RxCardUserModel {
  final id = ''.obs;
  final job = ''.obs;
  final location = ''.obs;
  final description = ''.obs;
  final contact = ''.obs;
  final number = ''.obs;
  final schedules = ''.obs;
  final status = false.obs;
  final dateCreated = Timestamp.now().obs;
  final activity = ''.obs;
  final image = ''.obs;
}

class CardUserModel {
  CardUserModel({
    id,
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

  get id => rx.id.value;

  set id(value) => rx.id.value = value;

  get job => rx.job.value;

  set job(value) => rx.job.value = value;

  get status => rx.status.value;

  set status(value) => rx.status.value = false;

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


  String toRawJson() => json.encode(toJson());

  static CardUserModel fromRawJson(String str) =>
      CardUserModel.fromJson(json.decode(str) as Map<String, dynamic>);

  static CardUserModel fromJson2(dynamic json) => CardUserModel();

  CardUserModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot,
      ) {
    id = documentSnapshot.id;
    job = documentSnapshot["job"];
    description = documentSnapshot["description"];
    status = documentSnapshot["status"];
    image = documentSnapshot["image"];
    location = documentSnapshot["location"];
    dateCreated = documentSnapshot["dateCreated"] as Timestamp;
    activity = documentSnapshot["activity"];
    contact = documentSnapshot["contact"];
    number = documentSnapshot["number"];
    schedules = documentSnapshot["schedules"];
  }

  factory CardUserModel.fromMap(Map data) {
    return CardUserModel(
      id: data['id'],
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

  factory CardUserModel.fromJson(Map<String, dynamic> json) => CardUserModel(
    id: json["id"] == null ? null : json["id"] as String,
    job: json["job"] == null ? null : json["job"] as String,
    description:
    json["description"] == null ? null : json["description"] as String,
    status: json["status"] == null ? null : json["status"] as String,
    image: json["image"] == null ? null : json["image"] as String,
    location: json["location"] == null ? null : json["location"] as String,
    dateCreated:
    json["dateCreated"] == null ? null : json["dateCreated"] as Timestamp,
    activity: json["activity"] == null ? null : json["activity"] as String,
    contact: json["contact"] == null ? null : json["contact"] as String,
    number: json["number"] == null ? null : json["number"] as String,
    schedules:
    json["schedules"] == null ? null : json["schedules"] as String,
  );

  factory CardUserModel.fromSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic> map = snap.data();
    if(map.containsKey('id')) {
      return CardUserModel.fromMap(map,);
    }
    return CardUserModel(
      id: snap.id,
      job: snap.reference.path,
      schedules: snap.reference.path,
      description: snap.reference.path,
      number: snap.reference.path,
      contact: snap.reference.path,
      activity: snap.reference.path,
      dateCreated: snap.reference.path,
      image: snap.reference.path,
      status: snap.reference.path,
      location: snap.reference.path,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
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

}
