import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pokemon_set_controller.dart';

class PokemonSetView extends GetView<PokemonSetController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PokemonSetView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PokemonSetView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
