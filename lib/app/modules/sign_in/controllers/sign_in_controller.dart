import 'package:card_x_user/app/modules/auth/controllers/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SignInController extends GetxController {
  final authController = AuthController();

  var hidden = true.obs;
  var rememberme = false.obs;
  late TextEditingController emailC;
  late TextEditingController passC;

  @override
  void onInit() {

    emailC = authController.emailController.value;
    passC = authController.passwordController.value;
    checkData();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
  }

  void checkData() {
    final box = GetStorage();
    if(box.read("dataUser") != null) {
      final data = box.read("dataUser") as Map<String, dynamic>;
      emailC.text = data["email"];
      passC.text = data["password"];
      rememberme.value = data["rememberme"];
    }
  }

  signInWithGoogle(context) => authController.googleSignIn(context);

}
