import 'package:card_x_user/localizations.dart';
import 'package:card_x_user/ui/pages/card/card_ui.dart';
import 'package:flutter/material.dart';

class FavoriesList extends StatefulWidget {
  @override
  _FavoriesListState createState() => _FavoriesListState();
}

class _FavoriesListState extends State<FavoriesList> {
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Contact: ${labels?.home?.title}'),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/nunchaku.png'),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
        ),
        child: Center(
          child: Column(
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              CardList(),
            ],
          ),
        ),
      ),
    );
  }
}
