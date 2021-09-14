import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pokemon_rarities_controller.dart';

class PokemonRaritiesView extends GetView<PokemonRaritiesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PokemonRaritiesView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PokemonRaritiesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
