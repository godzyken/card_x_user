import 'package:card_x_user/core/adapters/repository_adapter.dart';
import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/core/data/card_api_provider.dart';
import 'package:card_x_user/core/data/card_repository.dart';
import 'package:card_x_user/core/services/linker_service.dart';
import 'package:get/get.dart';

class PageBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => CardController(), tag: "create-a-card");
    Get.lazyPut(() => CardController(), tag: "edit-table");
    Get.lazyPut<ICardProvider>(() => CardProvider());
    Get.lazyPut<ICardRepository>(() => CardRepository(provider: Get.find()));
    Get.lazyPut<CardController>(() => CardController());

    Get.lazyPut<LinkerService>(() => LinkerService());

  }

}