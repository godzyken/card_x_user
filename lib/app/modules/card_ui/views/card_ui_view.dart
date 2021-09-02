import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/card_ui_controller.dart';

class CardUiView extends GetView<CardUiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CardUiView'),
        centerTitle: true,
      ),
      body: GetBuilder<CardUiController>(
        assignId: true,
        builder: (_) {
          return Center(
            child: Column(
              children: [
                ElevatedButton(onPressed: _.getCards, child: Text('Get cards')),
                ElevatedButton(onPressed: _.getCardsForSet, child: Text('Get cards for set')),
                ElevatedButton(onPressed: _.getCard, child: Text('Get card')),
                ElevatedButton(onPressed: _.getSet, child: Text('Get set')),
                ElevatedButton(onPressed: _.getSets, child: Text('Get sets')),
                ElevatedButton(onPressed: _.getTypes, child: Text('Get types')),
                ElevatedButton(onPressed: _.getSubtypes, child: Text('Get subtypes')),
                ElevatedButton(onPressed: _.getSupertypes, child: Text('Get supertypes')),
                ElevatedButton(onPressed: _.getRarities, child: Text('Get rarities')),

              ],
            ),
          );
        },
      ),
    );
  }
}
