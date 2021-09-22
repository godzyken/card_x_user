import 'package:card_x_user/app/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../controllers/social_connection_controller.dart';

class SocialConnectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SocialConnectionController>(
      () => SocialConnectionController(),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
  }
}
