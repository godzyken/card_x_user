import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/core/services/services.dart';
import 'package:card_x_user/localizations.dart';
import 'package:flutter/material.dart';


class AddUserCard extends StatelessWidget {
  final String uid;
  final CardUserModel cardModel;

  const AddUserCard({Key key, this.uid, this.cardModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                cardModel.job,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Checkbox(
              value: cardModel.status,
              onChanged: (newValue) {
                Database().updateCard(newValue, uid, cardModel.key);
              },
            ),
          ],
        ),
      ),
    );
  }
}