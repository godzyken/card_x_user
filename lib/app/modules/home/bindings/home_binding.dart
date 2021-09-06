import 'package:card_x_user/app/modules/auth/controllers/auth_controller.dart';
import 'package:card_x_user/app/modules/auth/services/auth_services.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
    Get.lazyPut(() => AuthServices.to);
  }
}