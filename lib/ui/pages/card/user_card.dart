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
                  child: Text('test'+
                    cardUserModel.job,
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
                  child: Text(
                    cardUserModel.activity,
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
                    cardUserModel.location,
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
                    cardUserModel.description,
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
                    cardUserModel.contact,
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
                    cardUserModel.schedules,
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
                    cardUserModel.dateCreated.toString(),
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
