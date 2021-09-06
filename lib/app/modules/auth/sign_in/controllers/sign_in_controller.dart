import 'package:card_x_user/app/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class SignInController extends GetxController {
  final AuthController? _authController = Get.find<AuthController>();
  AuthController? get authController => _authController;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

}
