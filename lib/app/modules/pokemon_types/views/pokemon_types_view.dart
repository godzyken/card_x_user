import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pokemon_types_controller.dart';

class PokemonTypesView extends GetView<PokemonTypesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PokemonTypesView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PokemonTypesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
