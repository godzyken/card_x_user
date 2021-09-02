import 'package:flutter/material.dart';

import 'package:get/get.dart';

class PokemonSelectView extends GetView {
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
