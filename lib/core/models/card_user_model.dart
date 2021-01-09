import 'package:card_x_user/core/models/models.dart';

class CardUserModel extends CardModel implements UserModel {
  String key;
  String value;
  String status;
  String icon;
  UserModel userModel;

  @override
  String email;

  @override
  String photoUrl;

  @override
  String uid;

  CardUserModel(
      {this.key,
      this.value,
      this.status,
      this.icon,
      this.userModel,
      this.email,
      this.photoUrl,
      this.uid});

  factory CardUserModel.fromMap(Map data) {
    return CardUserModel(
      key: data['key'],
      value: data['value'] ?? '',
      icon: data['icon'] ?? '',
      status: data['status'] ?? '',
      email: data['email'] ?? UserModel(email: data['email']),
      photoUrl: data['photoUrl'] ?? UserModel(photoUrl: data['photoUrl']),
      uid: data['uid'] ?? UserModel(uid: data['uid']),
      userModel: data['userModel'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
        'status': status,
        'icon': icon,
        'email': userModel.email,
        'photoUrl': userModel.photoUrl,
        'uid': userModel.uid,
        'userModel': userModel,
      };
}
