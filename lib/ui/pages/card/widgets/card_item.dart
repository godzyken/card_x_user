/*
import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/core/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
*/

/*class CardItem extends StatelessWidget {
  final CardModel cardModel;
  const CardItem(this.cardModel, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: GestureDetector(
        onTap: () {
          Get.toNamed("/cards/${cardModel.id}/edit");
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: cardModel.done ? Colors.grey : Colors.green[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Text("${cardModel.name}"),
                ]),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: GestureDetector(
                        onTap: () {
                          CardController.to
                              .updateCard(cardModel.copyWith(done: !cardModel.done));
                        },
                        child: !cardModel.done
                            ? Icon(Icons.check_box_outline_blank)
                            : Icon(Icons.check_box),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: GestureDetector(
                          onTap: () {
                            CardController.to.deleteCard(cardModel.id);
                          },
                          child: Icon(Icons.cancel)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}*/
