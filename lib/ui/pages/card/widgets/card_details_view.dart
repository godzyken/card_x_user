import 'dart:ui';

import 'package:card_x_user/localizations.dart';
import 'package:card_x_user/ui/components/components.dart';
import 'package:card_x_user/ui/pages/card/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:card_x_user/core/models/models.dart';
import 'package:get/get.dart';

class CardDetailsView extends StatelessWidget {
  final UserModel userModel;
  final CardUserModel cardUserModel;

  const CardDetailsView({Key key, this.userModel, this.cardUserModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

    return GestureDetector(
      onDoubleTap: () => Get.back(),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Avatar(userModel),
              Card(
                shadowColor: Colors.lightBlue[800],
                color: Colors.transparent,
                borderOnForeground: true,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          userModel.email,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      FormVerticalSpace(),
                      Expanded(
                        child: Text(
                          userModel.name,
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
                ),
              ),
              Expanded(
                 child: CardView(uid: userModel.uid, cardUserModel: cardUserModel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
