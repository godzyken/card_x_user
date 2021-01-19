import 'package:card_x_user/localizations.dart';
import 'package:flutter/material.dart';


class AddCard extends StatefulWidget {
  AddCard({Key key}) : super(key: key);

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  int card;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          card = snapshot.data;
          return Text("Stream : $card ");
        });
  }
}
