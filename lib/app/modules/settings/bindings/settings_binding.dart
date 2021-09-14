import 'package:card_x_user/app/modules/auth/controllers/auth_controller.dart';
import 'package:card_x_user/app/modules/scan_card/repository/page_repository.dart';
import 'package:card_x_user/app/modules/settings/controllers/language_controller.dart';
import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(
      () => SettingsController(),
    );
    Get.put(LanguageController(), permanent: true);
    Get.put(MyPref());
  }
}
