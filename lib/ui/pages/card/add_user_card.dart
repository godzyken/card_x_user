
import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/ui/components/components.dart';
import 'package:flutter/material.dart';

class AddUserCard extends StatefulWidget {
  final String uid;
  final CardUserModel cardModel;

  const AddUserCard({Key key, this.uid, this.cardModel}) : super(key: key);

  @override
  _AddUserCardState createState() => _AddUserCardState();
}

class _AddUserCardState extends State<AddUserCard> {
  @override
  Widget build(BuildContext context) {

    return buildContactCard;
  }

  Card get buildContactCard {
    return Card(
    elevation: 8.0,
    semanticContainer: true,
    shadowColor: Colors.lightBlue[800],
    color: Colors.transparent,
    borderOnForeground: true,
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.cardModel.job,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              FormVerticalSpace(),
              Expanded(
                child: Text(
                  widget.cardModel.activity,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FormVerticalSpace(),
              Expanded(
                child: Text(
                  widget.cardModel.description,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.cardModel.contact,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              FormVerticalSpace(),
              Expanded(
                child: Text(
                  widget.cardModel.location,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FormVerticalSpace(),
              Expanded(
                child: Text(
                  widget.cardModel.schedules,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
  }
}
