import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pokemon_select_controller.dart';

class PokemonSelectView extends GetView<PokemonSelectController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PokemonSelectView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PokemonSelectView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
