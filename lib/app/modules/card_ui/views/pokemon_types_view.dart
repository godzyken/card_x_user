import 'package:flutter/material.dart';

import 'package:get/get.dart';

class PokemonTypesView extends GetView {
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
