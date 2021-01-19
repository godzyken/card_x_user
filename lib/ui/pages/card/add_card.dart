import 'package:card_x_user/core/models/card_model.dart';
import 'package:card_x_user/core/services/services.dart';
import 'package:card_x_user/localizations.dart';
import 'package:flutter/material.dart';


class AddCard extends StatelessWidget {
  final String uid;
  final CardModelu cardModel;

  const AddCard({Key key, this.uid, this.cardModel}) : super(key: key);

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
                cardModel.name,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Checkbox(
              value: cardModel.done,
              onChanged: (newValue) {
                Database().updateCard(newValue, uid, cardModel.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}