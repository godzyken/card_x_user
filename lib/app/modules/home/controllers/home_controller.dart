import 'package:card_x_user/app/modules/auth/controllers/auth_controller.dart';
import 'package:card_x_user/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final fireStoreUser = AuthController();
  final isSignIn = false.obs;

  @override
  void onInit() {
    ever(isSignIn, handleAuthStateChanged);
    isSignIn.value = fireStoreUser.auth.currentUser != null;
    fireStoreUser.auth.authStateChanges().listen((event) {
      isSignIn .value = event != null;
    });

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void handleAuthStateChanged(isSignIn) {
    if (isSignIn) {
      Get.offAllNamed(Routes.HOME, arguments: fireStoreUser.getUser);
    } else {
      Get.offAllNamed(Routes.AUTH);
    }
  }
}
