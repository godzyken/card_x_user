import 'package:card_x_user/core/adapters/repository_adapter.dart';
import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/core/data/card_api_provider.dart';
import 'package:card_x_user/core/data/card_repository.dart';
import 'package:get/get.dart';

class PageBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => CardController.to, tag: "create-a-card");
    Get.lazyPut<ICardProvider>(() => CardProvider());
    Get.lazyPut<ICardRepository>(() => CardRepository(provider: Get.find()));
    Get.lazyPut(() => CardController(cardRepository: Get.find()));

    Get.lazyPut(() => CardUserController.to, tag: "create-a-user-card");
    Get.lazyPut(() => CardUserController(cardRepository: Get.find()));
  }

}