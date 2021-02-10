import 'dart:ui';

import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/localizations.dart';
import 'package:card_x_user/ui/components/components.dart';
import 'package:flutter/material.dart';


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
      child: buildCard(labels),
    );
  }

  Card buildCard(AppLocalizations_Labels labels) {
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
                  child: Text(labels.card.title + ': ${cardUserModel.job}',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent,
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
                  child: Text(labels.card.activity + ': ${cardUserModel.activity}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                  child: Text(labels.card.location + ': ${cardUserModel.location}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
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
                  child: Text(labels.card.description + ': ${cardUserModel.description}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlueAccent,
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
                    labels.card.phoneNumber + ': ${cardUserModel.number}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
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
                    labels.card.contact + ': ${cardUserModel.contact}',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
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
                    labels.card.schedules + ': ${cardUserModel.schedules}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
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
                    labels.card.dateCreated + ': ${cardUserModel.dateCreated}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.end,
                    softWrap: true,
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
