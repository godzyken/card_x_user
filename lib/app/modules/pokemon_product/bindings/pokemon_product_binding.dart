import 'package:get/get.dart';

import '../controllers/pokemon_product_controller.dart';

class PokemonProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PokemonProductController>(
      () => PokemonProductController(),
    );
  }
}
