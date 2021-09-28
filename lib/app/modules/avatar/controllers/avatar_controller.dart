import 'package:card_x_user/app/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class AvatarController extends GetxController {

  AuthController? authController;

  @override
  void onInit() {
    authController = AuthController();
    update();
    super.onInit();
  }

  @override
  void onReady() {

    super.onReady();
  }

  @override
  void onClose() {}

}
