import 'package:get/get.dart';

import '../controllers/pokemon_rarities_controller.dart';

class PokemonRaritiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PokemonRaritiesController>(
      () => PokemonRaritiesController(),
    );
  }
}
