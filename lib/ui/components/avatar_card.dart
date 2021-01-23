import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/ui/components/components.dart';
import 'package:flutter/material.dart';

class AvatarCard extends StatelessWidget {
  AvatarCard(this.cardUserModel);

  final CardUserModel cardUserModel;

  @override
  Widget build(BuildContext context) {
    if ((cardUserModel?.image == '') || (cardUserModel?.image == null)) {
      return LogoGraphicHeader();
    }
    return Hero(
      tag: 'Card avatar image',
      child: CircleAvatar(
        foregroundColor: Colors.yellow[50],
        backgroundColor: Colors.greenAccent[100],
        radius: 70.0,
        child: ClipOval(
          child: Image.network(
            cardUserModel?.image,
            fit: BoxFit.cover,
            width: 100.0,
            height: 200.0,
          ),
        ),
      ),
    );
  }
}
