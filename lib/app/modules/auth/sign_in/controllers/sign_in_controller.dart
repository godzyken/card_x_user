import 'package:card_x_user/app/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  static SignInController to = Get.find();
  final authControl = AuthController();

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

/*
  signIn(context) async {
    var isLog = await authControl.signInWithEmailAndPassword(context);
    if(isLog) {
      return Get.to('/home', opaque: true, arguments: Get.arguments, );
    } else {
      return Future.error(isLog, StackTrace.current);
    }
  }
*/
}
