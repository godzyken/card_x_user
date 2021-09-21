import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';

import '../controllers/pokemon_card_list_controller.dart';

class PokemonCardListView extends GetView<PokemonCardListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemon Card List'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Card(
                elevation: 12.0,
                color: Colors.lightBlueAccent,
                margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
                borderOnForeground: true,
                shadowColor: Colors.black12,
                child: GetBuilder<PokemonCardListController>(
                    init: PokemonCardListController(),
                    initState: (state) => controller.getCardList(),
                    builder: (_) => ListView.builder(
                          shrinkWrap: true,
                          controller: _.scroller,
                          addAutomaticKeepAlives: true,
                          addRepaintBoundaries: true,
                          addSemanticIndexes: true,
                          semanticChildCount: _.cardList.length,
                          padding: EdgeInsets.all(8.0),
                          itemCount: _.cardList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final card = _.cardList[index];

                            return buildListTile(card);
                          },
                        )),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Container buildListTile(PokemonCard? card) {
    return Container(
      child: Image.network(
        '${card!.images.small}'.tr,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
        width: Get.mediaQuery.size.width,
        height: Get.mediaQuery.size.height,
      ),
    );
  }
}
