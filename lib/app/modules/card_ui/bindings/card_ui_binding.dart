import 'package:card_x_user/app/modules/scan_card/repository/page_repository.dart';
import 'package:get/get.dart';

import '../controllers/card_ui_controller.dart';

class CardUiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CardUiController>(
      () => CardUiController(),
    );
    Get.lazyPut(()=>MyPref());
  }
}
