import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/localizations.dart';
import 'package:card_x_user/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps/maps.dart';

class UserCard extends StatelessWidget {
  final String uid;
  final CardUserModel cardUserModel;

  const UserCard({Key key, this.uid, this.cardUserModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

    return Container(
      decoration: BoxDecoration(
        image: new DecorationImage(
          image: NetworkImage('${cardUserModel.image}', scale: 1.0),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          buildCard,
        ],
      ),
    );
  }

  Card get buildCard {
    return Card(
      shadowColor: Colors.lightBlue[800],
      color: Colors.transparent,
      borderOnForeground: true,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Job Title : ${cardUserModel.job}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            FormVerticalSpace(),
            Row(
              children: [
                Expanded(
                  child: Text('Activity : ${cardUserModel.activity}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            FormVerticalSpace(),
            Row(
              children: [
                Expanded(
                  child: Text('Location : ${cardUserModel.location}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            FormVerticalSpace(),
            Row(
              children: [
                Expanded(
                  child: Text('Description : ${cardUserModel.description}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            FormVerticalSpace(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Contact : ${cardUserModel.contact}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            FormVerticalSpace(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Schedules : ${cardUserModel.schedules}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            FormVerticalSpace(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Date Created : ${cardUserModel.dateCreated}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            FormVerticalSpace(),
          ],
        ),
      ),
    );
  }
}
