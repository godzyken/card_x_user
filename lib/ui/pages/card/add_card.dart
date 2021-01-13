import 'package:card_x_user/core/controllers/card_controller.dart';
import 'package:card_x_user/core/models/card_model.dart';
import 'package:card_x_user/localizations.dart';
import 'package:card_x_user/ui/pages/card_profile_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AddCard extends StatefulWidget {
  AddCard({Key key}) : super(key: key);

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  CardController cardController = CardController();
  CardModel cardModel;

  @override
  void initState() {
    print(Get.parameters);
    if (Get.parameters != null) {
      var id = Get.parameters["id"];
      if (id != null) {
        CardController.to.loadDetails(id).then((value) =>
            setState(() {
              cardModel = value;
              cardController.titreProController.text = value.name;
            }));
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return GetBuilder<CardController>(
        init:CardController(),
        builder: (cardController) =>
        cardController?.cardStoreUser?.value?.uid == null
            ? Center(child: CircularProgressIndicator(),
        )
            : Scaffold(
          appBar: AppBar(
            title: Text("labels?,cardad?.title"),
            actions: [
              IconButton(icon: Icon(Icons.save), onPressed: () {})
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: cardController.titreProController,
                  decoration: InputDecoration(
                    hintText: "Add title",
                    border: OutlineInputBorder(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      if (cardController.titreProController.text != "") {
                        if (cardModel != null) {
                          cardModel.name =
                              cardController.titreProController.text;
                          // CardController.to().updateCard(context);
                          cardController.titreProController.clear();
                        } else {
                          CardController.to.addCard(cardController
                              .titreProController.text);
                          cardController.titreProController.clear();
                        }
                      }
                    },
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .6,
                      height: 50,
                      child: Center(
                        child: Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      color: Colors.blue,
                    ),
                  ),
                ),
                Obx(
                      () =>
                  CardController.to.isAddingCard.value
                      ? Container(
                    child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.green,
                        )),
                  )
                      : CardProfileUser(),
                )
              ],
            ),
          ),
        )
    );
  }

/* @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: cardController.titreProController,
              decoration: InputDecoration(
                hintText: "Add title",
                border: OutlineInputBorder(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  if (cardController.titreProController.text != "") {
                    if (cardModel != null) {
                      cardModel.name = cardController.titreProController.text;
                      // CardController.to().updateCard(context);
                      cardController.titreProController.clear();
                    } else {
                      CardController.to().addCard(cardController.titreProController.text);
                      cardController.titreProController.clear();
                    }
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .6,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  color: Colors.blue,
                ),
              ),
            ),
            Obx(
                  () => CardController.to().isAddingCard.value
                  ? Container(
                child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.green,
                    )),
              )
                  : CardProfileUser(),
            )
          ],
        ),
      ),
    );
  }*/


}
