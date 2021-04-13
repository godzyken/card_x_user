import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/core/services/services.dart';
import 'package:card_x_user/localizations.dart';
import 'package:card_x_user/ui/components/components.dart';
import 'package:card_x_user/ui/pages/card/card_ui.dart';
import 'package:card_x_user/ui/pages/card/widgets/card_widget.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
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
    final cardController = Get.put(CardController());
    final labels = AppLocalizations.of(context);

    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) => controller.firestoreUser!.value?.uid == null
          ? Center(
              child: cardModel(context),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text(labels!.card!.title!),
                actions: [
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        Get.to(CreateACardUi());
                      })
                ],
              ),
              body: Center(
                child: buildCardAction(controller, cardController),
              ),
            ),
    );
  }

  Card buildCardAction(AuthController controller, CardController cardController) {
    return Card(
                borderOnForeground: true,
                shadowColor: Colors.transparent,
                color: Colors.red[50],
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    print('Card tapped.');
                    Get.to(CardDetailsView(
                      userModel: controller.firestoreUser!.value,
                      cardUserModel: cardController.userCard!.value,
                    ));
                  },
                  // child: cardModel(context),
                  child: UserCardCreate(controller.firestoreUser!.value),
                ),
              );
  }
}

class UserCardCreate extends GetWidget<AuthController> {
  final UserModel? userModel;

  UserCardCreate(this.userModel);

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

    return GetX<FormXController>(
        init: Get.put<FormXController>(FormXController()),
        builder: (FormXController controller) {
          if ((controller != null && controller.cardUserModel != null) ||
              (controller.cardUserModel.value.id != null &&
                  controller.cardUserModel.value.id == userModel!.uid)) {
            return Container(
              width: 350,
              height: 250,
              // decoration: BoxDecoration(
              //   image: new DecorationImage(
              //     image: NetworkImage(controller.cardUserModel.value.image,
              //         scale: 1.0),
              //     fit: BoxFit.cover,
              //   ),
              // ),
              child: buildCardHeader(labels!, controller),
            );
          } else {
            return cardModel(context);
          }
        });
  }

  Column buildCardHeader(AppLocalizations_Labels labels, FormXController controller) {
    return Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ListTile(
                  leading: Avatar(userModel),
                  title: Text(
                    'Author: ${userModel!.name}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15.0),
                  ),
                  subtitle: Text(
                    labels.auth!.emailFormField! + ': ' + userModel!.email!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 11.0),
                  ),
                ),
                Expanded(
                    child: Container(
                  width: 340,
                  height: 100,
                  child: buildCardProfilModel(labels, controller),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('Activer'),
                      onPressed: () => Get.put(Database().saveACard(
                          controller.cardUserModel.value,
                          controller.cardUserModel.value.id)),
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
            );
  }

  Card buildCardProfilModel(AppLocalizations_Labels labels, FormXController controller) {
    return Card(
      color: Colors.transparent,
      shadowColor: Colors.amber[50],
      child: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            title: Text(
              labels.card!.title! + ': ${controller.cardUserModel.value.job}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
            subtitle: Text(
              labels.card!.description! +
                  ': ${controller.cardUserModel.value.description}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
          ),
          ListTile(
            title: Text(
              labels.card!.activity! +
                  ': ${controller.cardUserModel.value.activity}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
            subtitle: Text(
              /*TODO: labels.card.status + */
              'Status: ${controller.cardUserModel.value.status}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
          ),
        ],
      ),
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
          leading: Icon(
            Icons.account_circle,
            size: 75,
          ),
          title: Text('{labels.card.createACard}'),
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
