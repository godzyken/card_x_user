import 'package:get/get.dart';

import '../controllers/pokemon_types_controller.dart';

class PokemonTypesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PokemonTypesController>(
      () => PokemonTypesController(),
    );
  }
}
