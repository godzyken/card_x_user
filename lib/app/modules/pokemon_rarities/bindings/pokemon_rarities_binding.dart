import 'package:card_x_user/app/modules/card_ui/controllers/card_ui_controller.dart';
import 'package:get/get.dart';

import '../controllers/pokemon_rarities_controller.dart';

class PokemonRaritiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PokemonRaritiesController>(
      () => PokemonRaritiesController(),
    );
    Get.lazyPut<CardUiController>(
      () => CardUiController(),
    );
  }
}
