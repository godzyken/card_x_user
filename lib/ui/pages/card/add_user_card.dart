import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/ui/components/components.dart';
import 'package:flutter/material.dart';

class AddUserCard extends StatelessWidget {
  final String? uid;
  final CardUserModel? cardModel;

  const AddUserCard({Key? key, this.uid, this.cardModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      shadowColor: Colors.lightBlue[800],
      color: Colors.transparent,
      borderOnForeground: true,
      elevation: 2,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    cardModel!.job,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
                FormVerticalSpace(),
                Expanded(
                  flex: 1,
                  child: Text(
                    cardModel!.activity,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent
                    ),
                  ),
                ),
                FormVerticalSpace(),
                Expanded(
                  flex: 1,
                  child: Text(
                    cardModel!.number,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellowAccent
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    cardModel!.contact,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlueAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                FormVerticalSpace(),
                Expanded(
                  flex: 2,
                  child: Text(
                    cardModel!.location,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                FormVerticalSpace(),
                Expanded(
                  child: Text(
                    cardModel!.schedules,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent
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
