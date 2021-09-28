import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pokemon_rarities_controller.dart';

class PokemonRaritiesView extends GetView<PokemonRaritiesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemon Rarities'),
        centerTitle: true,
      ),
      body: GetBuilder<PokemonRaritiesController>(
          init: PokemonRaritiesController(),
          builder: (_) {
            return Center(
              child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text('${_.rarities[index].type}'),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: _.rarities.length),
            );
          }),
    );
  }
}
