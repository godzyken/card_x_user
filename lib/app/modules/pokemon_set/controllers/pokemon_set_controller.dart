import 'package:card_x_user/app/modules/card_ui/controllers/card_ui_controller.dart';
import 'package:card_x_user/app/modules/pokemon_product/controllers/pokemon_product_controller.dart';
import 'package:get/get.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';

class PokemonSetController extends GetxController {
  static PokemonSetController get to => Get.find();
  final api = CardUiController().api;
  PokemonProductController pokemonProductController = Get.put(PokemonProductController());
  CardSet? cardSet;


  final count = 0.obs;

  get card => pokemonProductController.card;

  @override
  void onInit() async {
    cardSet = await getSet();
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

  getSet() async {
    try {
      final result = await api.getSet(card!.set.id);
      print(result.name);

      cardSet = CardSet(
        id: result.id,
        name: result.name,
        images: result.images,
        printedTotal: result.printedTotal,
        ptcgoCode: result.ptcgoCode,
        releaseDate: result.releaseDate,
        series: result.series,
        total: result.total,
        updatedAt: result.updatedAt,
        legalities: SetLegalities(
          unlimited: result.legalities.unlimited,
          expanded: result.legalities.expanded,
        ),
      );

      update();

      print(cardSet!.name);

      return cardSet;
    } catch (e) {
      print(e);
    }
  }

}
