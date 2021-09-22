import 'package:card_x_user/app/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../controllers/avatar_controller.dart';

class AvatarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AvatarController>(
      () => AvatarController(),
    );
    Get.lazyPut<AuthController>(
          () => AuthController(),
    );

  }
}
