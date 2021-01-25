import 'package:card_x_user/core/models/models.dart';
import 'package:flutter/material.dart';

class CardView extends StatelessWidget {

  final String uid;
  final CardUserModel cardUserModel;

  const CardView({Key key, this.uid, this.cardUserModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 250,
      /*decoration: BoxDecoration(
        image: new DecorationImage(
          image: NetworkImage(cardUserModel?.image),
          fit: BoxFit.cover,
        ),
      ),*/
      child: Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
                child: Container(
                  width: 340,
                  height: 100,
                  child: Card(
                    color: Colors.transparent,
                    shadowColor: Colors.amber[50],
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        ListTile(
                          title: Text(
                            'Job title: ${cardUserModel.job}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15.0),
                          ),
                          subtitle: Text(
                            'description: ${cardUserModel.description}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15.0),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Activity: ${cardUserModel.activity}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15.0),
                          ),
                          subtitle: Text(
                            'Status: ${cardUserModel.status}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
