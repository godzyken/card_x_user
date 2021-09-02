import 'package:get/get.dart';

import '../controllers/card_ui_controller.dart';

class CardUiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CardUiController>(
      () => CardUiController(),
    );
  }
}
