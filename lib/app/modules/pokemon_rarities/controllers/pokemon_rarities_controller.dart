import 'package:card_x_user/app/modules/card_ui/controllers/card_ui_controller.dart';
import 'package:get/get.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';

class PokemonRaritiesController extends GetxController {
  static PokemonRaritiesController? get to => Get.find();

  final api = CardUiController().api;
  final rarities = <Rarity>[].obs;
  Rarity? rarity;

  final count = 0.obs;
  @override
  void onInit() async {
    rarity = await getRarities();
    update();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  getRarities() async {
    rarities.value = await api.getRarities();
    for(var r in rarities) {
      rarity = r;
      return rarity;
    }

    update();
    return rarities;
  }
}
