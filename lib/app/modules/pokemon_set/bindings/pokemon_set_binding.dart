import 'package:get/get.dart';

import '../controllers/pokemon_set_controller.dart';

class PokemonSetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PokemonSetController>(
      () => PokemonSetController(),
    );
  }
}
