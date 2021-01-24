import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/ui/components/components.dart';
import 'package:card_x_user/ui/pages/card/card_ui.dart';
import 'package:card_x_user/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CardProfileUser extends StatefulWidget {
  @override
  _CardProfileUserState createState() => _CardProfileUserState();
}

class _CardProfileUserState extends State<CardProfileUser> {
  @override
  void initState() {
    print(Get.parameters);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) => controller?.firestoreUser?.value?.uid == null
          ? Center(
              child: cardModel(context),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text('user card' /*labels?.home?.title*/),
                actions: [
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        Get.to(CreateACardUi());
                      })
                ],
              ),
              body: Center(
                child: Card(
                  borderOnForeground: true,
                  shadowColor: Colors.blue,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      print('Card tapped.');
                    },
                    child: UserCard(controller?.firestoreUser?.value),
                  ),
                ),
              ),
            ),
    );
  }
}

class UserCard extends GetWidget<AuthController> {

  final UserModel userModel;

  UserCard(this.userModel);


  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return GetX<FormXController>(
      init: Get.put<FormXController>(FormXController()),
      builder: (FormXController controller) {
        if ((controller != null && controller.cardUserModel != null) || (controller.cardUserModel.value.id == userModel.uid)) {

          return Container(
            width: 300,
            height: 150,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ListTile(
                  leading: AvatarCard(controller.cardUserModel.value),
                  title: Text('Job Title :${controller.cardUserModel.value.job}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15.0),
                  ),
                  subtitle: Text(
                    'description : ${controller.cardUserModel.value.description}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 11.0),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('Activer'),
                      onPressed: () {},
                    ),
                    SizedBox(width: 8),
                    TextButton(
                      child: const Text('Modifier'),
                      onPressed: () {
                        Get.to(CreateACardUi());
                      },
                    ),
                    SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          );
        } else {
          return cardModel(context);
        }
      }
    );
  }
}

Widget cardModel(BuildContext context) {
  return Container(
    width: 300,
    height: 150,
    color: Colors.amber[50],
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        const ListTile(
          leading: Icon(Icons.album),
          title: Text('Create your card'),
          subtitle: Text('This is a demo card: '),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              child: const Text('See options'),
              onPressed: () {
                print('show details');
              },
            ),
            const SizedBox(width: 8),
            TextButton(
              child: const Text('Create One'),
              onPressed: () {
                Get.to(CreateACardUi());
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
      ],
    ),
  );
}
