import 'package:card_x_user/app/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getxfire/getxfire.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();
  AuthController? authController;

  // a variable to On Off Switch in flutter
  var isSwitcheded = false;

  @override
  void onInit() {
    authController = AuthController();
    super.onInit();
  }

  @override
  void onReady() {

  }

  @override
  void onClose() {

  }
}
