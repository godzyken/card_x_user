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
      child: ListView(
        shrinkWrap: true,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  cardUserModel?.job ?? 'Job Title default',
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
                  cardUserModel?.activity ?? 'Activity default',
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
                  cardUserModel?.location ?? 'location default',
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
                  cardUserModel?.description ?? 'description default',
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
                  cardUserModel?.contact ?? 'contact default',
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
                  cardUserModel?.schedules ?? 'schedules default',
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
                  cardUserModel?.dateCreated ?? 'date created default',
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
    );
  }
}
