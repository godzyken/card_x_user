import 'package:card_x_user/app/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class AvatarController extends GetxController {
  AuthController? authController = Get.find<AuthController>();

  late User? user;

  @override
  void onInit() {
    super.onInit();
    user = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

}
