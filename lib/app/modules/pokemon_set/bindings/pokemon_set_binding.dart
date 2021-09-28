import 'package:card_x_user/app/modules/pokemon_product/controllers/pokemon_product_controller.dart';
import 'package:get/get.dart';

import '../controllers/pokemon_set_controller.dart';

class PokemonSetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PokemonSetController>(
      () => PokemonSetController(),
    );
    Get.lazyPut<PokemonProductController>(
          () => PokemonProductController(),
    );
  }
}
