import 'package:get/get.dart';

import '../controllers/pokemon_select_controller.dart';

class PokemonSelectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PokemonSelectController>(
      () => PokemonSelectController(),
    );
  }
}
