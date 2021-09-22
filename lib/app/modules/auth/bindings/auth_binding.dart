import 'package:card_x_user/app/modules/auth/reset_password/controllers/reset_password_controller.dart';
import 'package:card_x_user/app/modules/sign_in/controllers/sign_in_controller.dart';
import 'package:card_x_user/app/modules/sign_up/controllers/sign_up_controller.dart';
import 'package:card_x_user/app/modules/update_profile/controllers/update_profile_controller.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
    Get.lazyPut<SignInController>(()=> SignInController());
    Get.lazyPut<SignUpController>(()=> SignUpController());
    Get.lazyPut<ResetPasswordController>(() => ResetPasswordController());
    Get.lazyPut<UpdateProfileController>(() => UpdateProfileController());
  }
}
