import 'package:card_x_user/core/controllers/card_controller.dart';
import 'package:get/get.dart';

class PageBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => CardController.to(), tag: "create-a-card");
  }

}