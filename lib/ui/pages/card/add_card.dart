import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCard extends StatefulWidget {
  AddCard({Key key}) : super(key: key);

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  final CardController cardController = Get.put(CardController());
  CardModel cardModel;

  @override
  void initState() {
    print(Get.parameters);
    if (Get.parameters != null) {
      var id = Get.parameters["id"];
      if (id != null) {
        cardController.loadDetails(id).then((value) => setState(() {
              cardModel = value;
              cardController.titreProController.text = value.name as String;
            }));
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("labels?,cardad?.title"),
        actions: [IconButton(icon: Icon(Icons.save), onPressed: () {})],
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
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    if (cardController.titreProController.text != "") {
                      if (cardModel != null) {
                        cardModel.name = cardController.titreProController.text as List<CardUserModel>;
                        // CardController.to().updateCard(context);
                        cardController.titreProController.clear();
                      } else {
                        CardController.to
                            .addCard(cardController.titreProController.text);
                        cardController.titreProController.clear();
                      }
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .6,
                    height: MediaQuery.of(context).size.height * .6,
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
            ),
          ],
        ),
      ),
    );
  }

}
