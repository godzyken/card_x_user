import 'package:card_x_user/app/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';


class HomeController extends GetxController {
  AuthController? authController;

  @override
  void onInit() {
    authController = AuthController();
    super.onInit();
  }

  @override
  void onReady() async {

    super.onReady();
  }

  @override
  void onClose() {}

}
