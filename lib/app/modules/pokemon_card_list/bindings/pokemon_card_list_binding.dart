import 'package:get/get.dart';

import '../controllers/pokemon_card_list_controller.dart';

class PokemonCardListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PokemonCardListController>(
      () => PokemonCardListController(),
    );
  }
}
