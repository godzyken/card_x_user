
import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/ui/pages/card/card_ui.dart';
import 'package:card_x_user/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardProfileUser extends StatefulWidget {
  @override
  _CardProfileUserState createState() => _CardProfileUserState();
}

class _CardProfileUserState extends State<CardProfileUser> {
  static bool canUpdate(Widget oldWidget, Widget newWidget) {
    return oldWidget.runtimeType == newWidget.runtimeType &&
        oldWidget.key == newWidget.key;
  }

  CardModelu cardUserModel;


  @override
  void initState() {

    print(Get.parameters);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(labels?.home?.title),
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
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              print('Card tapped.');
            },
            child: Container(
              width: 300,
              height: 150,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.album),
                    title: Text('The Enchanted Nightingale'),
                    subtitle:
                        Text('Music by Julie Gable. Lyrics by Sidney Stein: '),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text('Activer'),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        child: const Text('Modifier'),
                        onPressed: () {
                          Get.to(AddCard());
                        },
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
