import 'package:card_x_user/app/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../controllers/sign_in_controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(
      () => SignInController(),
    );
    Get.lazyPut<AuthController>(()=> AuthController());
  }
}
