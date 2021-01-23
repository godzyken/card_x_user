import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/ui/components/avatar_card.dart';
import 'package:card_x_user/ui/pages/card/card_ui.dart';
import 'package:card_x_user/localizations.dart';
import 'package:flutter/cupertino.dart';
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
                    child: UserCard(),
                  ),
                ),
              ),
            ),
    );
  }
}

class UserCard extends StatelessWidget {
  final UserModel userModel;
  final CardUserModel cardUserModel;

  const UserCard({Key key, this.userModel, this.cardUserModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return GetBuilder<CardController>(
      init: CardController(),
      builder: (controller) => controller?.userCard?.value?.key == null
          ? Center(
              child: cardModel(context),
            )
          : Container(
              width: 300,
              height: 150,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ListTile(
                    leading: AvatarCard(controller.userCard.value),
                    title: Text(
                      controller.userCard.value.job,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    subtitle: Text(
                      controller.userCard.value.description,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
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
                          Get.to(AddCard());
                        },
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

Widget cardModel(BuildContext context) {
  return Container(
    width: 300,
    height: 150,
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
